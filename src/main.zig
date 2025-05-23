const uart = @import("mmio/uart.zig");
const syscon = @import("mmio/syscon.zig");
const std = @import("std");

export fn main() void {
    uart.init();
    var buffer: [255]u8 = undefined;

    while (true) {
        print("> ");
        const n = uart.read(&buffer);
        print("\r\n");

        if (std.mem.eql(u8, buffer[0..n], "")) {
            continue;
        } else if (std.mem.eql(u8, buffer[0..n], "poweroff") or std.mem.eql(u8, buffer[0..n], "exit")) {
            break;
        } else if (std.mem.eql(u8, buffer[0..n], "reboot")) {
            syscon.reboot();
        } else {
            print("Unknow command!\r\n");
        }
    }

    syscon.poweroff();
}

fn print(comptime msg: []const u8) void {
    uart.write(msg);
}
