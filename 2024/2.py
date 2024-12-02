from aoc import read_input

content = read_input().splitlines()
content = list(map(lambda x: list(map(int, x.split())), content))
pairs = [list(zip(i[:-1], i[1:])) for i in content]
num1, num2 = 0, 0

for index, i in enumerate(pairs):
    orig = content[index]

    if (sorted(orig) == orig or sorted(orig)[::-1] == orig) and len(set(sorted(orig))) == len(orig):
        for (a, b) in i:
            if abs(b-a) not in (1, 2, 3):
                break
        else:
            num1 += 1
            num2 += 1
            continue

    for index1, j in enumerate(orig):
        copied = orig.copy()
        copied.pop(index1)
        pairs1 = list(zip(copied[:-1], copied[1:]))

        if (sorted(copied) == copied or sorted(copied)[::-1] == copied) and len(set(sorted(copied))) == len(copied):
            for index2, (a, b) in enumerate(pairs1):
                if abs(b - a) not in (1, 2, 3):
                    break
            else:
                num2 += 1
                break

print(num1)
print(num2)
