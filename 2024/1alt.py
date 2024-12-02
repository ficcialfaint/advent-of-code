from aoc import read_input
from collections import Counter

content = read_input().split('\n')
num = sum(map(lambda x: abs(x[0]-x[1]), zip(sorted([int(i.split()[0]) for i in content]), sorted([int(i.split()[1]) for i in content]))))
print(num)

num2 = sum([Counter([int(i.split()[1]) for i in content])[i]*i*Counter([int(i.split()[0]) for i in content])[i] for i in Counter([int(i.split()[0]) for i in content])])
print(num2)