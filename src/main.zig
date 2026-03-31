const std = @import("std");
const lib = @import("lib.zig");
const version = @import("version.zig").version;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Hello, {s}!\n", .{"Zig CI/CD"});

    const result = lib.add(2, 3);
    try stdout.print("2 + 3 = {d}\n", .{result});

    const fizz = lib.fizzBuzz(15);
    try stdout.print("fizzBuzz(15) = {s}\n", .{fizz});

    try stdout.print("version = {s}\n", .{version});
}
