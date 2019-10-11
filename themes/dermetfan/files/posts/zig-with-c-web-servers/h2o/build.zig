const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("h2o-zig", "src/main.zig");

    exe.linkLibC();

    exe.linkSystemLibrary("h2o-evloop");

    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("crypto");

    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
