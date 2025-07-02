const uart = @import("mmio/uart.zig");
const syscon = @import("mmio/syscon.zig");
const std = @import("std");

export var temp_mem: u64 = 0;
export var RAM_START_ADDRESS: u64 = 0;

export fn main() void {
    uart.init();
    var buffer: [255]u8 = undefined;

    print("Number of cpu: ");
    var a: [1]u8 = .{0};
    a[0] = '0' + @as(u8, @intCast(temp_mem));
    print(&a);
    print("\n");

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

fn print(msg: []const u8) void {
    uart.write(msg);
}

export fn scheduler() void {
    while (true) {}
}
