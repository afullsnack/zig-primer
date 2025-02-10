const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;

test "inline for loop" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0; // is usize known at compile time or runtime
    inline for (types) |T| {
        print("Type: {}, Size: {}\n", .{ T, @sizeOf(T) });
        sum += @sizeOf(T);
    }
    try expect(sum == 10);
}
