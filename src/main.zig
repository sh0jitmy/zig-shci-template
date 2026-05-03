const std = @import("std");
const Io = std.Io;
const lib = @import("lib.zig");
const version = @import("version.zig").version;

pub fn main() !void {
    std.log.info("Hello, Zig CI/CD!", .{});

    const result = lib.add(2, 3);
    std.log.info("2 + 3 = {d}", .{result});

    const fizz = lib.fizzBuzz(15);
    std.log.info("FizzBuzz of 15: {s}", .{fizz});

    std.log.info("version = {s}", .{version});
}
