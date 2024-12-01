from aoc import read_input
from collections import Counter

content = read_input().split('\n')

_list1 = []
_list2 = []

for i in content:
    nums = i.split("   ")
    _list1.append(int(nums[0]))
    _list2.append(int(nums[1]))

_list1.sort()
_list2.sort()

num1 = 0
for i in range(len(_list1)):
    num1 += abs(_list1[i] - _list2[i])

print(num1)

num2 = 0
counter = Counter(_list2)

for i in counter:
    if i not in _list1:
        continue

    num2 += i*counter[i]

print(num2)

