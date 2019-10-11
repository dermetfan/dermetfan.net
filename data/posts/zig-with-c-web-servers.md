{---
title = "Trying Zig with C web servers";
tags = [ "code" "zig" "nix" "h2o" "facil.io" "lwan" ];
date = "2020-03-26";
---}

I wanted to try using Zig to build an application server.

The C integration should, in theory, allow me to use an existing web server library.
Here are my results.

I tried the following web servers:

- [H2O](/posts/zig-with-c-web-servers-2.html) (success)
- [facil.io](/posts/zig-with-c-web-servers-3.html) (failure)
- [LWAN](/posts/zig-with-c-web-servers-4.html) (failure)

*TL;DR: C translation is obviously not production ready, but I was able to get it to work with H2O.*

<<<

# [H2O](https://h2o.examp1e.net)

This is the only one I had success with.

I ported the `simple.c` example to Zig, following this [intro](https://powerdns.org/libh2o/) to `libh2o`.

[Here](/posts/zig-with-c-web-servers/h2o.tar.gz) you can download the entire project.

A few problems came up which I want to briefly discuss below.

## Zig cannot translate C bitfields

H2O makes use of C bitfields throughout its codebase. Unfortunately, Zig does not (yet) understand them.
There was an effort to fix this but it seems to have stagnated:

- [Issue #1499](https://github.com/ziglang/zig/issues/1499)
- [PR #4165](https://github.com/ziglang/zig/pull/4165)

Consequently we have to remove all bitfields from H2O.
Fortunately using Nix it is trivial to apply a [patch](/posts/zig-with-c-web-servers/h2o/h2o-no-bitfields.patch) and use the recompiled H2O:

```nix
pkgs.h2o.overrideAttrs (oldAttrs: {
  patches = [ ./h2o-no-bitfields.patch ];
});
```

## libuv

H2O has its own event loop implementation that is faster than libuv, so for a simple demo I did not want to link against libuv.
So without libuv in the build environment obviously the header file cannot be found.

```
./src/c.zig:1:20: error: C import failed
pub usingnamespace @cImport({
                   ^
/nix/store/…-h2o-2.3.0-beta2-dev/include/h2o/socket/uv-binding.h:27:10: note: 'uv.h' file not found
#include <uv.h>
```

We can fix that be setting the `H2O_USE_LIBUV` preprocessor variable.

```zig
{{ lib.theme.dermetfan.codeSnippet 1 4 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
```

If you want to compile H2O without libuv support you need to pass that to H2O's `CMakeLists.txt`. Using Nix that looks like this:

```nix
pkgs.h2o.overrideAttrs (oldAttrs: {
  cmakeFlags = [ "-DDISABLE_LIBUV=1" ];
});
```

## `#define H2O_STRLIT`

H2O passes strings around with an additional length parameter using the preprocessor.

```c
h2o_iovec_init(H2O_STRLIT("default");
```

That expands to:

```c
h2o_iovec_init("default", 7)
```

That `H2O_STRLIT` macro cannot be used in Zig code, so we will have to type the length ourselves.

For common use cases you can write little wrapper functions to make it more comfortable:

```zig
{{ lib.theme.dermetfan.codeSnippet 149 155 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
```

## Zig stdlib bug when linking libc

Setting up the listening socket is easier than in C. Zig's standard library handles everything for us:

```zig
{{ lib.theme.dermetfan.codeSnippet 28 30 "posts/zig-with-c-web-servers/h2o/src/main.zig" }}
```

Here I hit a [bug](https://github.com/ziglang/zig/issues/4797) in the standard library, but that was quickly solved by a Zig contributor.

In case you are using a version before commit `778dbc17acce77588a46a27074ecb8b418786d94`, there is a workaround.

- Make a copy of the stdlib
- Replace the `setsockopt()` signature in `std/os.zig` with the one below
- Use a compiler binary that is at a path relative to your stdlib

> Zig locates lib files relative to executable path by searching up the filesystem tree for a sub-path of `lib/zig/std/std.zig` or `lib/std/std.zig`. Typically the former is an install and the latter a git working tree which contains the build directory. ([source](https://github.com/ziglang/zig/blob/master/CONTRIBUTING.md#editing-source-code))

```patch
- pub fn setsockopt(fd: fd_t, level: u32, optname: u32, opt: []const u8) SetSockOptError!void {
+ pub fn setsockopt(fd: fd_t, level: u32, optname: u32, opt: []u8) SetSockOptError!void {
```

## Pointer size

When passing the size of a pointer to `h2o_create_handler()` I had to take it times 4, any less and H2O internals would dereference a null pointer.
I thought pointer sizes would be the same so the reason is not entirely clear to me, if you have an idea here I would be glad to hear it.

```zig
{{ lib.theme.dermetfan.codeSnippet 17 17 "posts/zig-with-c-web-servers/h2o/src/main.zig" }}
```

## H2O_TOKEN_…

Similarly Zig can not parse the `H2O_TOKEN_…` macros. There is a `h2o_lookup_token()` function that we can use though.

To avoid looking up tokens all the time, we can assign all the tokens on startup of our program to our own constants.

```zig
// lookup_token() cannot run comptime so these have to be vars...
{{ lib.theme.dermetfan.codeSnippet 27 30 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
// …

{{ lib.theme.dermetfan.codeSnippet 83 83 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
{{ lib.theme.dermetfan.codeSnippetIndent 104 107 "posts/zig-with-c-web-servers/h2o/src/c.zig" " " (4 * 1) }}
    // …
{{ lib.theme.dermetfan.codeSnippet 147 151 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
```

Admittedly that is not very nice. Maybe we could build the `H2O_TOKEN_…` structs directly and assign them to actual `const`s.

## Converting `h2o_iovec_t` to slices

We can simplify here with a little helper.

```zig
{{ lib.theme.dermetfan.codeSnippet 157 159 "posts/zig-with-c-web-servers/h2o/src/c.zig" }}
```

That allows us to use `std.mem.eql()` instead of `h2o_ismem()`, if desired.

```zig
{{ lib.theme.dermetfan.codeSnippet 50 50 "posts/zig-with-c-web-servers/h2o/src/main.zig" }}
```

## Conclusion

Since this was the only web server I could get to work, there is still work to do in the C translation.
But that is to be expected from such an early version of the language.

I find it remarkable that C translation works so well already. Very promising!

<<<

# [facil.io](http://facil.io)

I was able to start the server and answer a request.

Unfortunately Zig is unable to translate `fiobj_free()`.
Therefore I did not think it was worth investigating further.

[Download](/posts/zig-with-c-web-servers/facil.io.tar.gz) all files.

```zig
{{ lib.theme.dermetfan.readFile "posts/zig-with-c-web-servers/facil.io/main.zig" }}
```

```
./zig-cache/o/…/cimport.zig:2918:24: error: unable to translate function
pub const fiobj_free = @compileError("unable to translate function");
                       ^
./src/main.zig:8:12: note: referenced here
    defer c.fiobj_free(HTTP_HEADER_X_DATA);
           ^
```

<<<

# [LWAN](https://lwan.ws)

Those macros can clearly not easily be translated to Zig, so the journey ends abruptly.

```c
#define LWAN_HANDLER_REF(name_) lwan_handler_##name_
#define LWAN_HANDLER(name_)                                                    \
    static enum lwan_http_status lwan_handler_##name_(                         \
        struct lwan_request *, struct lwan_response *, void *);                \
    static const struct lwan_handler_info                                      \
        __attribute__((used, section(LWAN_SECTION_NAME(lwan_handler))))        \
            lwan_handler_info_##name_ = {.name = #name_,                       \
                                         .handler = lwan_handler_##name_};     \
    static enum lwan_http_status lwan_handler_##name_(                         \
        struct lwan_request *request __attribute__((unused)),                  \
        struct lwan_response *response __attribute__((unused)),                \
        void *data __attribute__((unused)))
```
