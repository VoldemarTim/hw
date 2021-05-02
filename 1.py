duration = int(input('Введите количество секунд:'))
if duration < 60:
    print(f'{duration} секунд(а)')

elif 60 <= duration < 3600:
    print(f'{duration % 60} секунд(а), {duration // 60} минута(а)')

elif 3600 <= duration < 86400:
    print(f'{(duration % 3600) % 60} секунд(а), {(duration % 3600) // 60} минут(а), {duration // 3600} час(а/ов')

elif 86400 <= duration < 2419200:
    print(f'{(((duration % 86400) % 3600) % 60 % 60)} секунд(а), {((duration % 86400) % 3600) // 60} минута(а),'
          f'{(duration % 86400) // 3600} час(а/ов), {duration // 86400} день/дней/дня')


