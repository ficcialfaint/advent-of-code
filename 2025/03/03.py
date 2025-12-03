def p1(x: list[int]):
    for i in range(9, 0, -1):
        try:
            index = x.index(i)
            num = i * 10
        except ValueError:
            continue

        for i in range(9, 0, -1):
            if i in x[index + 1 :]:
                return num + i

    return 0


def p2(x: list[int]):
    for first_digit in range(9, 0, -1):
        try:
            index = x.index(first_digit)
            n = str(first_digit)
        except ValueError:
            continue

        if len(x) - index - 1 < 11:
            continue

        c = 1
        while c != 12:
            prev = c

            for i in range(9, 0, -1):
                try:
                    index_ = index + 1 + x[index + 1 :].index(i)
                except ValueError:
                    continue

                if len(x) - index_ - 1 < 12 - (c + 1):
                    continue

                index = index_
                n += str(i)
                c += 1
                break

            if c == prev:
                break

        if len(n) == 12:
            return int(n)

    return 0


lines = open("input").read().strip().split()
nums = [list(map(int, i)) for i in lines]

print(sum(map(p1, nums)))
print(sum(map(p2, nums)))
