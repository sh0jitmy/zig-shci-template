const std = @import("std");
const testing = std.testing;

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn fizzBuzz(n: u32) []const u8 {
    if (n % 15 == 0) return "FizzBuzz";
    if (n % 3 == 0) return "Fizz";
    if (n % 5 == 0) return "Buzz";
    return "Other";
}

test "add basic" {
    try testing.expectEqual(@as(i32, 5), add(2, 3));
    try testing.expectEqual(@as(i32, 0), add(-1, 1));
    try testing.expectEqual(@as(i32, -2), add(-1, -1));
}

test "fizzBuzz" {
    try testing.expectEqualStrings("FizzBuzz", fizzBuzz(15));
    try testing.expectEqualStrings("FizzBuzz", fizzBuzz(30));
    try testing.expectEqualStrings("Fizz", fizzBuzz(3));
    try testing.expectEqualStrings("Buzz", fizzBuzz(5));
    try testing.expectEqualStrings("Other", fizzBuzz(7));
}
