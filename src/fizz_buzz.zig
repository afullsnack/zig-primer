const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var count: u8 = 1;

    while (count <= 100) : (count += 1) {
        try stdout.print("{}\n", .{count});

        if (count % 3 == 0 and count % 5 == 0) {
            try stdout.writeAll("Fizz buzz\n");
        } else if (count % 5 == 0) {
            try stdout.writeAll("Buzz\n");
        } else if (count % 3 == 0) {
            try stdout.writeAll("Fizz\n");
        } else {
            try stdout.print("{}\n", .{count});
        }
    }
}

pub fn switchMain() !void {
    const stdout = std.io.getStdOut().writer();
    var count: u8 = 1;

    while (count <= 100) : (count += 1) {
        try stdout.print("{}\n", .{count});
        const div_3: u2 = @intFromBool(count % 3 == 0);
        const div_5 = @intFromBool(count % 5 == 0);

        switch (div_3 * 2 + div_5) {
            0b10 => try stdout.writeAll("Fizz\n"),
            0b11 => try stdout.writeAll("Fizz Buzz\n"),
            0b01 => try stdout.writeAll("Buzz\n"),
            0b00 => try stdout.print("{}\n", .{count}),
        }
    }
}
