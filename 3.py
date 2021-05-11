
book = {
    'И': ['Иван', 'Илья'],
    'М': 'Мария',
    'П': 'Петр'
}

while True:
    print('Enter a name: (Введите имя)')
    name = input()

    if name in book:
        print(book[name])