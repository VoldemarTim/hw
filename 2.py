#2. * (вместо задачи 1) Доработать предыдущую функцию num_translate_adv():
#реализовать корректную работу с числительными, начинающимися с заглавной буквы. Например:
#>>> >>> num_translate_adv("One")
#"Один"
#>>> num_translate_adv("two")
#"два"


num_translate = {
        'zero': 'ноль',
        'one': 'один',
        'two': 'два',
        'three': 'три',
        'four': 'четыре',
        'five': 'пять',
        'six': 'шесть',
        'seven': 'семь',
        'eight': 'восемь',
        'nine': 'девять',
        'ten': 'десять'
}
num_translate_adv = {
        'Zero': 'Ноль',
        'One': 'Один',
        'Two': 'Два',
        'Three': 'Три',
        'Four': 'Четыре',
        'Five': 'Пять',
        'Six': 'Шесть',
        'Seven': 'Семь',
        'Eight': 'Восемь',
        'Nine': 'Девять',
        'Ten': 'Десять'
}
num_translate.update(num_translate_adv)
print(num_translate.get('ten', 'None'))
