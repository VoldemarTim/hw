# 2. Написать функцию currency_rates(),
# принимающую в качестве аргумента код валюты (USD, EUR, ...)
# и возвращающую курс этой валюты по отношению к рублю.
# Использовать библиотеку requests. В качестве API можно использовать
# http://www.cbr.ru/scripts/XML_daily.asp. Рекомендация:
# выполнить предварительно запрос к API в обычном браузере,
# посмотреть содержимое ответа. Можно ли, используя только методы класса str,
# решить поставленную задачу? Функция должна возвращать результат числового типа,
# например float. Подумайте: есть ли смысл для работы с денежными величинами
# использовать вместо float тип Decimal? Сильно ли усложняется код функции при этом?
# Если в качестве аргумента передали код валюты, которого нет в ответе, вернуть None.
# Можно ли сделать работу функции не зависящей от того, в каком регистре был передан аргумент?
# В качестве примера выведите курсы доллара и евро.

import requests
from decimal import Decimal
from datetime import datetime


def currency_rates(val):
    response = requests.get('https://www.cbr-xml-daily.ru/daily_json.js')
    date = datetime.strptime(response.headers['Date'], '%a, %d %B %Y %H:%M:%S %Z').date()
    response = response.json()
    if response.status_code != 200:
        return
    return f'{Decimal(str(response["Valute"][val.upper()]["Value"]))}, {date}'


if __name__ == '__main__':
    print(currency_rates('USD'))