a = [10, 10.51, 11, 11.52, 12, 12.53, 13, 13.54, 14, 14.55]

r = ' руб'
k = ' коп'
for i in a:
    c = i
    b = int(c)
    d = (c - int(c)) * 100 + 0.1
    d = int(d)
    print(str(b) + r + ' ' + str(d) + k + ',', end=' ')