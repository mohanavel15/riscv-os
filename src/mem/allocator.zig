const std = @import("std");
const Allocator = std.mem.Allocator;
const Alignment = std.mem.Alignment;

pub const KernelAllocator = struct {
    const Self = @This();

    ptr: [*]u8 = undefined,
    start: usize = 0,

    pub fn init(self: *Self, start: usize) void {
        self.ptr = @ptrFromInt(start);
        self.start = 0;
    }

    pub fn __alloc(ctx: *anyopaque, len: usize, alignment: Alignment, ret_addr: usize) ?[*]u8 {
        const self: *KernelAllocator = @ptrCast(@alignCast(ctx));
        _ = alignment;
        _ = ret_addr;

        const buffer = self.ptr[self.start .. self.start + len];
        self.start += len;
        return buffer.ptr;
    }

    pub fn __free(ctx: *anyopaque, memory: []u8, alignment: Alignment, ret_addr: usize) void {
        const self: *KernelAllocator = @ptrCast(@alignCast(ctx));

        _ = alignment;
        _ = ret_addr;
        _ = self;
        _ = memory;
    }

    pub fn __resize(ctx: *anyopaque, memory: []u8, alignment: Alignment, new_len: usize, ret_addr: usize) bool {
        const self: *KernelAllocator = @ptrCast(@alignCast(ctx));

        _ = memory;
        _ = alignment;
        _ = ret_addr;
        _ = self;
        _ = new_len;

        return false;
    }

    pub fn __remap(ctx: *anyopaque, memory: []u8, alignment: Alignment, new_len: usize, ret_addr: usize) ?[*]u8 {
        const self: *KernelAllocator = @ptrCast(@alignCast(ctx));

        _ = memory;
        _ = alignment;
        _ = ret_addr;
        _ = self;
        _ = new_len;

        return null;
    }

    pub fn allocator(self: *Self) Allocator {
        return Allocator{
            .ptr = self,
            .vtable = &.{
                .alloc = Self.__alloc,
                .free = Self.__free,
                .remap = Self.__remap,
                .resize = Self.__resize,
            },
        };
    }
};
