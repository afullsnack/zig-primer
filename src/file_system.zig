const std = @import("std");
const testing = std.testing;

test "Write and read from file system" {
    const file = try std.fs.cwd().createFile("logs.txt", .{ .read = true });
    defer file.close();

    try file.writeAll("Hello, man man");

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);

    const byte_read = try file.readAll(&buffer);

    try testing.expect(std.mem.eql(u8, buffer[0..byte_read], "Hello, man man"));
}
