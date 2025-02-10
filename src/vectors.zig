const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const meta = std.meta;

test "Vector defintion with @Type" {
    const x: @Vector(3, f32) = .{ 1, -10, 3.4 };
    const sumVec = x + @as(@Vector(3, f32), @splat(2));

    print("Vector: {}\n", .{sumVec});
    try expect(meta.eql(sumVec, @Vector(3, f32){ 3, -8, 5.4 }));
}
