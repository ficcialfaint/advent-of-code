from aoc import read_input
from collections import Counter

content = read_input().split('\n')

list1, list2 = [], []

for i in content:
    nums = i.split()
    list1.append(int(nums[0]))
    list2.append(int(nums[1]))

list1.sort()
list2.sort()

num1 = 0
for i in range(len(list1)):
    num1 += abs(list1[i] - list2[i])

print(num1)

num2 = 0
counter = Counter(list1)
counter2 = Counter(list2)

for i in counter2:
    if i not in list1:
        continue

    num2 += i*counter2[i]*counter[i]

print(num2)

