const std = @import("std");
// defining enums and using it in program statement
// passing it into control flows and testing with switch
// statements

pub fn main() !void {
    const Direction = enum {
        north,
        south,
        east,
        west,
    };

    const way_point = Direction.north;

    switch (way_point) {
        Direction.north => {
            std.debug.print("Direction is {}\n", .{way_point});
        },
        Direction.south => {
            std.debug.print("Directino is {}\n", .{Direction.south});
        },
        else => {
            std.debug.print("Not found way pint", .{});
        },
    }
}

test "enum with next field" {
    const Value2 = enum(u32) {
        hundred = 100,
        thousand = 1000,
        next,
    };
    std.debug.print("Enum values {}\n", .{@intFromEnum(Value2.hundred)});
    try std.testing.expect(@intFromEnum(Value2.next) == 1001);
}
const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enums can have functions" {
    try std.testing.expect(Suit.spades.isClubs() != Suit.isClubs(.clubs));
}

const Bottle = enum {
    coke,
    fanta,
    const amountDrank: u32 = 1000;
    var milesRan: u64 = 1500;
};

test "enums can have var or const variables" {
    try std.testing.expect(Bottle.amountDrank == 1000);
}

test "get miles ran" {
    const miles = Bottle.milesRan;

    std.debug.print("Miles ran by bottle {}ml \n", .{miles});
    try std.testing.expectEqual(miles, Bottle.milesRan);
}
