from aoc import read_input

content = read_input().splitlines()

p1 = p2 = 0
for i, val in enumerate(content):
    for j, val2 in enumerate(val):
        if val2 == "A" and len(val)-2 >= j >= 1 and 0 < i <= len(content) - 2:
            word = ((content[i+1][j+1], content[i-1][j-1]), (content[i-1][j+1], content[i+1][j-1]))
            p2 += word[0] in (("M", "S"), ("S", "M")) and word[1] in (("M", "S"), ("S", "M"))

        if val2 != "X":
            continue

        if i >= 3 and val2+content[i-1][j]+content[i-2][j]+content[i-3][j] == "XMAS":
            p1 += 1

        if i <= len(content)-4 and val2 + content[i + 1][j] + content[i + 2][j] + content[i + 3][j] == "XMAS":
            p1 += 1

        if j >= 3 and val2+val[j-1]+val[j-2]+val[j-3] == "XMAS":
            p1 += 1

        if j <= len(val)-4 and val2 + val[j+1] + val[j+2] + val[j+3] == "XMAS":
            p1 += 1

        if j <= len(val)-4 and i <= len(content)-4 and val2+content[i+1][j+1]+content[i+2][j+2]+content[i+3][j+3] == "XMAS":
            p1 += 1

        if j <= len(val)-4 and i >= 3 and val2+content[i-1][j+1]+content[i-2][j+2]+content[i-3][j+3] == "XMAS":
            p1 += 1

        if j >= 3 and i <= len(content)-4 and val2+content[i+1][j-1]+content[i+2][j-2]+content[i+3][j-3] == "XMAS":
            p1 += 1

        if j >= 3 and i >= 3 and val2+content[i-1][j-1]+content[i-2][j-2]+content[i-3][j-3] == "XMAS":
            p1 += 1

print(p1)
print(p2)
