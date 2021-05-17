# 1. Написать генератор нечётных чисел от 1 до n (включительно),
# используя ключевое слово yield, например:
# >>> odd_to_15 = odd_nums(15)
# >>> next(odd_to_15)
# 1
# >>> next(odd_to_15)
# 3
# ...
# >>> next(odd_to_15)
# 15
# >>> next(odd_to_15)
# ...StopIteration...

from itertools import count


def fgen():
    for i in count(1, 2):
        yield(i)

generator = fgen()
x = 0
for k in generator:
    if x < 8:
        print(k)
        x += 1
    else:
        break

