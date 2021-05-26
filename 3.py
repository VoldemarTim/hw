# 3. * (вместо 2) Доработать функцию currency_rates(): теперь она должна возвращать кроме курса дату,
# которая передаётся в ответе сервера. Дата должна быть в виде объекта date.
# Подумайте, как извлечь дату из ответа, какой тип данных лучше использовать в ответе функции?

import requests
from datetime import datetime
from decimal import Decimal


def currency_rates(val):
    response = requests.get('https://www.cbr-xml-daily.ru/daily_json.js')
    date = datetime.strptime(response.headers['Date'], '%a, %d %B %Y %H:%M:%S %Z').date()
    response = response.json()
    if not response['Valute'].get(val.upper()):
        return
    return f'{Decimal(str(response["Valute"][val.upper()]["Value"]))}, {date}'

print(currency_rates('USD'))