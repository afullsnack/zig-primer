const expect = @import("std").testing.expect;
const std = @import("std");

// optionals are values that can store null(nothing) or a value
test "optional" {
    var found_index: ?usize = null;
    const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 12 };
    for (data, 0..) |v, i| {
        if (v == 10) found_index = i;
    }
    try expect(found_index == null);
}

// using orelse when optional variable is still null
test "orelse" {
    const a: ?f32 = null;
    const fallback_value: f32 = 0;
    const b = a orelse fallback_value;
    try expect(b == 0);
    try expect(@TypeOf(b) == f32);
}

// orelse unreachable with shorthand a.?
test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;
    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}

// optionals values can be captured in if or while
test "if optional payload capture" {
    const a: ?i32 = 5;
    if (a != null) {
        const value = a.?;
        _ = value;
    }

    var b: ?i32 = 5;
    if (b) |*value| {
        value.* += 1;
    }

    try expect(b.? == 6);
}

// while capture
var numbers_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) return null;
    numbers_left -= 1;
    std.debug.print("Numbers left {}\n", .{numbers_left});
    return numbers_left;
}

test "while null capture" {
    var sum: u32 = 0;
    while (eventuallyNullSequence()) |value| {
        std.debug.print("Value in sequence: {}\n", .{value});
        sum += value;
    }
    try expect(sum == 6); // 3 + 2 + 1
}
