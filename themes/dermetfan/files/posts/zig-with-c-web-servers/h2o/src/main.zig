const std = @import("std");
const c = @import("c.zig");

var accept_ctx: c.h2o_accept_ctx_t = undefined;

pub fn main() !void {
    c.h2o._init();

    var config: c.h2o_globalconf_t = undefined;
    {
        c.h2o_config_init(&config);

        const hostconf: *c.h2o_hostconf_t = c.h2o_config_register_host(&config, c.h2o.iovec_init("default"), 65535);

        { // /hello
            const pathconf: *c.h2o_pathconf_t = c.h2o_config_register_path(hostconf, "/hello", 0);
            const handler: *c.h2o_handler_t = c.h2o_create_handler(pathconf, @sizeOf(c.h2o_handler_t));
            handler.on_req = helloHandler;
        }
    }

    var ctx: c.h2o_context_t = undefined;
    c.h2o_context_init(&ctx, c.h2o_evloop_create(), &config);

    accept_ctx.ctx = &ctx;
    accept_ctx.hosts = config.hosts;

    var server = std.net.StreamServer.init(.{});
    defer server.deinit();
    try server.listen(try std.net.Address.parseIp4("127.0.0.1", 12345));

    c.h2o_socket_read_start(
        c.h2o_evloop_socket_create(ctx.loop, server.sockfd.?, c.H2O_SOCKET_FLAG_DONT_READ),
        onAccept
    );

    while (c.h2o_evloop_run(ctx.loop, std.math.maxInt(c_int)) == 0) {}
}

fn onAccept(listener: [*c]c.h2o_socket_t, err: [*c]const u8) callconv(.C) void {
    if (err != 0) return;

    const sock: [*c]c.h2o_socket_t = c.h2o_evloop_socket_accept(listener);
    if (sock == 0) return;

    c.h2o_accept(&accept_ctx, sock);
}

fn helloHandler(self: [*c]c.h2o_handler_t, req: [*c]c.h2o_req_t) callconv(.C) c_int {
    if (!std.mem.eql(u8, c.h2o._from_iovec(req.*.method), c.h2o.METHOD_GET)) return -1;

    req.*.res.status = 200;
    req.*.res.reason = "OK";
    _ = c.h2o_add_header(&req.*.pool, &req.*.res.headers, c.h2o.TOKEN_CONTENT_TYPE, 0, c.h2o.CONTENT_TYPE_TEXT_PLAIN, c.h2o.CONTENT_TYPE_TEXT_PLAIN.len);

    const body = "Hello, world!\n";
    c.h2o_send_inline(req, body, body.len);

    return 0;
}
