// sentinel termination
const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

test "sentinel termination" {
    const terminated = [3:0]u8{ 1, 2, 3 };
    try expect(terminated.len == 3);
    try expect(@as(*const [4]u8, @ptrCast(&terminated))[3] == 0);
}

test "string literal" {
    try expect(@TypeOf("hello") == *const [5:0]u8);
}

test "C string" {
    const c_string: [*:0]const u8 = "hello";
    var array: [5]u8 = undefined;

    var i: usize = 0;
    while (c_string[i] != 0) : (i += 1) {
        array[i] = c_string[i];
    }
}

test "coercion" { // would coerce to non-sentinel type
    const a: [*:0]u8 = undefined;
    const b: [*]u8 = a;

    const c: [5:0]u8 = undefined;
    const d: [5]u8 = c;

    const e: [:0]f32 = undefined;
    const f: []f32 = e;

    _ = .{ b, d, f }; //ignore unused
}

test "sentinel terminated slicing" {
    var x = [_:0]u8{255} ** 3;
    const y = x[0..3 :0];
    _ = y;
}
