const SYSCON: *volatile u32 = @ptrFromInt(0x100000);

pub fn poweroff() void {
    SYSCON.* = 0x5555;
}

pub fn reboot() void {
    SYSCON.* = 0x7777;
}
