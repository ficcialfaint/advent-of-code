from aoc import read_input

a, b = map(str.splitlines, read_input().split("\n\n"))
a = list(map(lambda x: (int(x.split('|')[0]), int(x.split('|')[1])), a))
b = [tuple(map(int, i.split(','))) for i in b]

copy = b.copy()
wrong = []
p1 = p2 = 0

for before, after in a:
    for j in copy:
        if before not in j or after not in j:
            continue

        if j.index(before) > j.index(after):
            copy.remove(j)
            wrong.append(list(j))

for i in copy:
    p1 += i[int((len(i) - 1) / 2)]

for i, j in enumerate(wrong):
    for before, after in sorted(filter(lambda x: x[0] in j and x[1] in j, a), key=lambda x: j.index(x[0]), reverse=True):
        if j.index(before) > j.index(after):
            index1, index2 = j.index(before), j.index(after)
            wrong[i].insert(index2, before)
            wrong[i].pop(index1+1)

for i in wrong:
    p2 += i[int((len(i) - 1) / 2)]

print(p1)
print(p2)
