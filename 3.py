a = ['в', '5', 'часов', '17', 'минут', 'температура', 'воздуха', 'была', '+5', 'градусов']

a.insert(1, '"')
a.insert(3, '"')
a.insert(5, '"')
a.insert(7, '"')
a.insert(12, '"')
a.insert(14, '"')
a.remove('5')
a.insert(2, '05')
a.remove('+5')
a.insert(13, '+05')

print(' '.join(a))