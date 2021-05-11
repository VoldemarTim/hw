
book = {
    'И': 'Иван',
    'М': 'Мария',
    'П': 'Петр'
}

while True:
    print('Enter a name: (Введите имя)')
    name = input()
    if name == '':
        break

    if name in book:
        print(book[name])
    else:
        print('Нет такого имени в книге')