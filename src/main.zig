const std = @import("std");
const lib = @import("lib.zig");
const version = @import("version.zig").version;

pub fn main() !void {
    var outbuf: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&outbuf);
    const stdout = &stdout_writer.interface;

    _ = try stdout.print("Hello, {s}!\n", .{"Zig CI/CD"});

    const result = lib.add(2, 3);
    _ = try stdout.print("2 + 3 = {d}\n", .{result});

    const fizz = lib.fizzBuzz(15);
    _ = try stdout.print("fizzBuzz(15) = {s}\n", .{fizz});

    _ = try stdout.print("version = {s}\n", .{version});
}
