list_of_cubes = [i ** 3 for i in range(1001) if i % 2 != 0]
sum_of_numbers = 0
for number in list_of_cubes:
    sum_of_numerals = 0
    count = number
    while count != 0:
        sum_of_numerals += count % 10
        count //= 10
    if not sum_of_numerals % 7:
        sum_of_numbers += number
print(sum_of_numbers)
sum_of_numbers = 0
for number in list_of_cubes:
    sum_of_numerals = 0
    count = number + 17
    while count !=0:
        sum_of_numerals += count % 10
        count //= 10
    if not sum_of_numerals % 7:
        sum_of_numbers += number + 17
print(sum_of_numbers)



#s = 0
#for b in range(1001):
#    if(b % 2 != 0):     не понял почему не работает...
#    s += int(b)
#    print(b)
#print(s)


#a = list(range(1001))
#s = 0
#for b in a:
#    s += int(b)
#    print(b)
#print(s)


