const std = @import("std");
const builtin = @import("builtin"); // explore the builtin package

const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();
    const connection = try std.net.tcpConnectToHost(alloc, "localhost", 8080);
    print("Connection info: {}", .{connection});
    _ = connection.close();

    while (true) {
        std.time.sleep(1_000_000_000);
    }
}

test "understanding GPA" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();
    const connection = try std.net.tcpConnectToHost(alloc, "localhost", 8000);
    _ = connection;

    while (true) {
        std.time.sleep(1_000_000_000);
    }
}

// test "what os" {
//     const os = builtin.os.tag;
//     print("Current operating system is: {}\n", .{os});

//     const string_literal =
//         \\ this is a shitty string literal
//         \\ maybe we can use this for some up coming mods
//         \\ or look into the type
//     ;

//     print("Type of string literal {}\n", .{@TypeOf(string_literal)});
//     print("{s}\n", .{string_literal});
// }
