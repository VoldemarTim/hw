# 4. Написать свой модуль utils и перенести в него функцию currency_rates()
# из предыдущего задания. Создать скрипт, в котором импортировать этот модуль
# и выполнить несколько вызовов функции currency_rates(). Убедиться, что ничего лишнего не происходит.

from sys import argv
import utils

if len(argv) == 1:
    print('Укажите наименование валюты!')
elif len(argv) == 2:
    print(utils.currency_rates(argv[1]))
else:
    print('Передано слишком много параметров!')