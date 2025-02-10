const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const eql = std.mem.eql;

test "optional-if" {
    const maybe_num: ?usize = 10;
    if (maybe_num) |n| {
        try expect(@TypeOf(n) == usize);
        try expect(n == 10);
    } else {
        unreachable;
    }
}

const Info = union(enum) {
    a: u23,
    b: []const u8,
    c,
    d: u32,
};

test "switch capture" {
    const info = Info{ .a = 10 };
    const x = switch (info) {
        .b => |str| blk: {
            try expect(@TypeOf(str) == []const u8);
            break :blk 1;
        },
        .c => 2,
        .a, .d => |num| blk: { // capture to named block and return computed value
            try expect(@TypeOf(num) == u32);
            break :blk num * 2;
        },
    };
    try expect(x == 20);
}

test "for with pointer capture" { // use pointer capture to modify original value inside of |val| capture
    var data = [_]u8{ 1, 2, 3 };
    for (&data) |*byte| {
        print("\nPointer capture,Raw byte: {} - Dereferenced byte {}\n", .{ byte, byte.* });
        byte.* += 1;
    }
    try expect(eql(u8, &data, &[_]u8{ 2, 3, 4 }));
}
