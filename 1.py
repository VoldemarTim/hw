#1. Написать функцию num_translate(), переводящую числительные от 0 до 10 c английского на русский язык.
#Например:
#>>> >>> num_translate("one")
#"один"
#>>> num_translate("eight")
#"восемь"

#list_english = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten']
#list_russian = ['ноль', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять', 'десять']

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
print(num_translate.get('te', 'None'))



