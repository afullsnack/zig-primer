const std = @import("std");
const array = [5]u8('h', 'e', 'l', 'l', 'e');
const b = [5]u8('w', 'o', 'r', 'l', 'd');
const length = array.len;

pub fn main() !void {
    try arrayFn(&[_]u32{ 1, 2, 3, 4 });
}

const SomeError = error{SomeKindOfError};

pub fn arrayFn(arrayList: []const u32) SomeError!void {
    std.debug.print("Length: {}\n", .{arrayList.len});
    for (arrayList, 0..) |item, index| {
        std.debug.print("Item: {} - index: {}\n", .{ item, index });
    }

    var cursor: u8 = 0;
    while (cursor < arrayList.len) : (cursor += 1) {
        // if (cursor == 2) return SomeError.SomeKindOfError;
        std.debug.print("Inside of while loop: {}\n", .{arrayList[cursor]});
    }

    switch (cursor) {
        0...1 => {
            std.debug.print("Switching on 0 to 1 \n", .{});
        },
        else => {
            std.debug.print("Value found in switch checker {}\n", .{cursor});
        },
    }
}
