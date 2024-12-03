from aoc import read_input
import re

content = read_input()
p1 = p2 = 0
allow = True
for i in re.finditer(r"(do\(\))|(don't\(\))|(mul\((\d*),(\d*)\))", content):
    if i.group(2):
        allow = False
    elif i.group(1):
        allow = True
    else:
        if allow:
            p2 += int(i.group(4))*int(i.group(5))
        p1 += int(i.group(4)) * int(i.group(5))

print(p1)
print(p2)
