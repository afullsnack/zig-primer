const std = @import("std");

const expect = std.testing.expect;

test "allocation" {
    const allocator = std.heap.page_allocator;

    var memory = try allocator.alloc(u8, 100); // allocate a section of memory
    defer allocator.free(memory); // free memory when function closes

    for (memory.ptr, 0..memory.len) |_, idx| {
        // std.debug.print("Space data {}, index: {}\n", .{ space, idx });
        // std.debug.print("Assigning...\n", .{});
        const index: u8 = @intCast(idx);
        memory.ptr[idx] = @as(u8, index + 2);
    }

    std.debug.print("Data inside memory - {d}\n", .{memory.ptr[3]});

    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}

test "fixed buffer allocator" {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    // std.debug.print("Size of memory {}", .{@sizeOf(memory.*)});
    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}

test "arena allocator" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    _ = try allocator.alloc(u8, 1);
    _ = try allocator.alloc(u8, 10);
    _ = try allocator.alloc(u8, 100);
}

test "allocator create/destroy" {
    const byte = try std.heap.page_allocator.create(u8);
    defer std.heap.page_allocator.destroy(byte);
    byte.* = 128;
}

test "GPA" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer {
        const deinit_status = gpa.deinit();
        //fail test; can't try in defer as defer is executed after we return
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }

    const bytes = try allocator.alloc(u8, 100);
    defer allocator.free(bytes);
}
