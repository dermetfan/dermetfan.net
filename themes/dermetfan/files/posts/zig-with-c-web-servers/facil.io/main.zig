const std = @import("std");

const c = @cImport({
    @cInclude("fio.h");
    @cInclude("http.h");
});

pub fn main() !void {
    const HTTP_HEADER_X_DATA: c.FIOBJ = c.fiobj_str_new("X-Data", "X-Data".len);
    defer c.fiobj_free(HTTP_HEADER_X_DATA); // FIXME https://github.com/ziglang/zig/blob/8ea0a00f406bb04c08a8fa4471c3a3895f82b24a/src-self-hosted/translate_c.zig

    const socket_uuid = c.http_listen("3000", null, .{
        .on_request = on_request,
        .log = 1,
        .on_upgrade = null,
        .on_response = null,
        .on_finish = null,
        .udata = null,
        .public_folder = null,
        .public_folder_length = 0,
        .max_header_size = 0,
        .max_body_size = 0,
        .max_clients = 0,
        .tls = null,
        .reserved1 = 0,
        .reserved2 = 0,
        .reserved3 = 0,
        .ws_max_msg_size = 0,
        .timeout = 0,
        .ws_timeout = 0,
        .is_client = 0,
    });
    if (socket_uuid == -1) return error.Listen;

    c.fio_start(.{ .threads = 1, .workers = 1, });
}

fn on_request(request: [*c]c.http_s) callconv(.C) void {
    const body_ = "Hello World!\r\n";
    var body: [body_.len]u8 = undefined;
    std.mem.copy(u8, body[0..], body_[0..]);

    _ = c.http_send_body(request, body[0..], body.len);
}
