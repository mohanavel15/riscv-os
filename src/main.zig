const UART: *volatile u8 = @ptrFromInt(0x10000000);

fn write(c: u8) void {
    UART.* = c;
}

export fn main() void {
    while (true) {
        print("Hello, World\r\n");
    }
}

fn print(comptime msg: []const u8) void {
    for (msg) |c| {
        write(c);
    }
}
