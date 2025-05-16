const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .riscv64,
            .cpu_model = .{
                .explicit = &std.Target.riscv.cpu.generic_rv64,
            },
            .os_tag = .freestanding,
            .abi = .none,
        },
    });

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = .ReleaseSmall,
    });

    const exe = b.addExecutable(.{
        .name = "riscv_kernel",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);
}
