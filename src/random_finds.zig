const std = @import("std");
const builtin = @import("builtin"); // explore the builtin package

const print = std.debug.print;

test "what os" {
    const os = builtin.os.tag;
    print("Current operating system is: {}\n", .{os});

    const string_literal =
        \\ this is a shitty string literal
        \\ maybe we can use this for some up coming mods
        \\ or look into the type
    ;

    print("Type of string literal {}\n", .{@TypeOf(string_literal)});
    print("{s}\n", .{string_literal});
}
