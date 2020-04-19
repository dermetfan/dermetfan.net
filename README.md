## Does Not Work in Sandbox

Fetches frequently changing content from the web without using a fixed-output derivation.
This is not allowed in sandboxed builds.

If your Nix configuration has sandboxed builds enabled you need to run with `--option sandbox relaxed`.

Examples:

```
styx live --option sandbox relaxed
```
