const std = @import("std");
const Range = struct { u64, u64 };

fn cmp(_: void, a: Range, b: Range) bool {
    return a.@"0" < b.@"0";
}

fn readFile(allocator: std.mem.Allocator, fileName: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(fileName, .{ .mode = .read_only });
    defer file.close();

    return file.readToEndAlloc(allocator, std.math.maxInt(usize));
}

fn parse(allocator: std.mem.Allocator, text: []u8, ranges: *std.ArrayList(Range), nums: *std.ArrayList(u64)) !void {
    var split = std.mem.splitScalar(u8, text, '\n');
    var part = @as(u64, 1);
    while (split.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r\n");
        if (trimmed.len == 0) {
            if (part == 1) part = 2 else continue;
            continue;
        }

        if (part == 1) {
            var split1 = std.mem.splitScalar(u8, line, '-');
            var range = Range{ 0, 0 };

            var c = @as(u64, 0);
            while (split1.next()) |s| {
                if (c == 0) {
                    range.@"0" = try std.fmt.parseInt(u64, s, 10);
                    c = 1;
                } else {
                    range.@"1" = try std.fmt.parseInt(u64, s, 10);
                }
            }
            try ranges.append(allocator, range);
        } else {
            try nums.append(allocator, try std.fmt.parseInt(u64, line, 10));
        }
    }
}

pub fn main() !void {
    var _gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = _gpa.allocator();

    const text = try readFile(gpa, "input");

    var ranges = try std.ArrayList(Range).initCapacity(gpa, 0);
    defer ranges.deinit(gpa);

    var nums = try std.ArrayList(u64).initCapacity(gpa, 0);
    defer nums.deinit(gpa);

    try parse(gpa, text, &ranges, &nums);

    var p1 = @as(u64, 0);
    for (nums.items) |num| {
        for (ranges.items) |range| {
            if (num >= range.@"0" and num <= range.@"1") {
                p1 += 1;
                break;
            }
        }
    }

    std.mem.sort(Range, ranges.items, {}, cmp);

    var p2 = @as(u64, 0);
    var cur = @as(u64, 0);
    for (ranges.items) |range| {
        var l = range.@"0";
        const r = range.@"1";

        var skip = false;
        for (ranges.items[0..cur]) |range1| {
            const r1 = range1.@"1";

            if (l <= r1 and r <= r1) {
                skip = true;
                break;
            } else if (l <= r1 and r >= r1) {
                l = r1 + 1;
            }
        }

        cur += 1;
        if (skip) continue;
        p2 += r - l + 1;
    }

    std.debug.print("{}\n", .{p1});
    std.debug.print("{}\n", .{p2});
}
