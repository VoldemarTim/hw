-- Написать приложение, которое собирает основные новости с сайтов mail.ru, lenta.ru. Для парсинга использовать xpath. Структура данных должна содержать:

-- название источника,
-- наименование новости,
-- ссылку на новость,
-- дата публикации

from lxml import html
import requests
from datetime import datetime

def get_news_lenta_ru():
    
    news = []
    
    keys = ('title', 'date', 'link')
    date_format = '%Y-%m-%dT%H:%M:%S%z'
    link_lenta = 'https://lenta.ru/'
    
    request = requests.get(link_lenta)

    root = html.fromstring(request.text)
    root.make_links_absolute(link_lenta)
    
    news_links = root.xpath('''(//section[@class="row b-top7-for-main js-top-seven"]//div[@class="first-item"]/h2 | 
                                //section[@class="row b-top7-for-main js-top-seven"]//div[@class="item"])
                                /a/@href''')
    
    news_text = root.xpath('''(//section[@class="row b-top7-for-main js-top-seven"]//div[@class="first-item"]/h2 | 
                                //section[@class="row b-top7-for-main js-top-seven"]//div[@class="item"])
                                /a/text()''')
    
    for i in range(len(news_text)):
        news_text[i] = news_text[i].replace(u'\xa0', u' ')
    
    news_date = []
    
    for item in news_links:
        request = requests.get(item)
        root = html.fromstring(request.text)
        date = root.xpath('//time[@itemprop="datePublished"]/@datetime')
        news_date.extend(date)

    for i in range(len(news_date)):
        news_date[i] = datetime.strptime(news_date[i], date_format)
        
    for item in list(zip(news_text, news_date, news_links)):
        news_dict = {}
        for key, value in zip(keys, item):
            news_dict[key] = value
        
        news_dict['source'] = 'lenta.ru'
        news.append(news_dict)
    
    return news

def get_news_mail_ru():
    
    news = []    
    
    headers = {
                'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0'
            }
    
    keys = ('title', 'date', 'link')
    date_format = '%Y-%m-%dT%H:%M:%S%z'
    

    link_mail_ru = 'https://mail.ru/'
    
    request = requests.get(link_mail_ru, headers=headers)
    root = html.fromstring(request.text)
    
    news_links = root.xpath('''(//div[@class =  "news-item o-media news-item_media news-item_main"]  |  
                                //div[@class =  "news-item__inner"])
                                /a[contains(@href, "news.mail.ru")]/@href''')
    
    news_text = root.xpath('''(//div[@class =  "news-item o-media news-item_media news-item_main"]//h3  |  
                               //div[@class =  "news-item__inner"]/a[contains(@href, "news.mail.ru")])
                               /text()''')
    
    for i in range(len(news_text)):
        news_text[i] = news_text[i].replace(u'\xa0', u' ')
    
    news_links_temp = []
    for item in news_links:
        item = item.split('/')
        news_links_temp.append('/'.join(item[0:5]))
        
    news_links = news_links_temp
    del(news_links_temp)
    
    news_date = []
    
    for item in news_links:
        request = requests.get(item, headers=headers)
        root = html.fromstring(request.text)
        date = root.xpath('//span[@class="note__text breadcrumbs__text js-ago"]/@datetime')
        news_date.extend(date)
        
    for i in range(len(news_date)):
        news_date[i] = datetime.strptime(news_date[i], date_format)
        
    for item in list(zip(news_text, news_date, news_links)):
        news_dict = {}
        for key, value in zip(keys, item):
            news_dict[key] = value
        
        news_dict['source'] = 'mail.ru'
        news.append(news_dict)
    
    return news

get_news_lenta_ru()

[{'title': 'В МЧС сообщили об уголовной ответственности за курение на балконах',
  'date': datetime.datetime(2019, 9, 26, 23, 16, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/no_smkng/',
  'source': 'lenta.ru'},
 {'title': 'В Солнечной системе нашли признаки черной дыры',
  'date': datetime.datetime(2019, 9, 27, 0, 15, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/27/hole/',
  'source': 'lenta.ru'},
 {'title': 'На Мамаева нашелся новый претендент',
  'date': datetime.datetime(2019, 9, 27, 0, 8, 20, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/27/mamaev_rostov/',
  'source': 'lenta.ru'},
 {'title': 'Неизвестный открыл стрельбу в московском общежитии',
  'date': datetime.datetime(2019, 9, 26, 23, 55, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/fire/',
  'source': 'lenta.ru'},
 {'title': 'Звезда «Глухаря» устроил скандал в самолете',
  'date': datetime.datetime(2019, 9, 26, 23, 39, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/averin/',
  'source': 'lenta.ru'},
 {'title': 'Футболист украл у одноклубника часы за 70 тысяч евро',
  'date': datetime.datetime(2019, 9, 26, 22, 52, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/stolen_watch/',
  'source': 'lenta.ru'},
 {'title': 'Табун верблюдов под Новороссийском удивил спасателей',
  'date': datetime.datetime(2019, 9, 26, 22, 46, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/verbl/',
  'source': 'lenta.ru'},
 {'title': 'В скандале о разговоре Трампа с Зеленским появилось ЦРУ',
  'date': datetime.datetime(2019, 9, 26, 22, 20, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/cia/',
  'source': 'lenta.ru'},
 {'title': 'Адвокат Кокорина найден мертвым',
  'date': datetime.datetime(2019, 9, 26, 21, 53, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/kokodav/',
  'source': 'lenta.ru'},
 {'title': 'Россиянка отправилась с женихом в отпуск и попала в сексуальное рабство',
  'date': datetime.datetime(2019, 9, 26, 20, 36, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://lenta.ru/news/2019/09/26/sexualslavery/',
  'source': 'lenta.ru'}]

get_news_mail_ru()

[{'title': 'В России запретят курить на балконах с 1 октября',
  'date': datetime.datetime(2019, 9, 26, 22, 55, 29, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38873886',
  'source': 'mail.ru'},
 {'title': 'Кудрин заявил об отсутствии бедных пенсионеров в России',
  'date': datetime.datetime(2019, 9, 26, 15, 53, 12, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/economics/38869455',
  'source': 'mail.ru'},
 {'title': 'Лавров рассказал о безвозмездных поставках оружия в ЦАР',
  'date': datetime.datetime(2019, 9, 27, 0, 26, 18, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/politics/38874035',
  'source': 'mail.ru'},
 {'title': 'Администрацию столицы Калмыкии возглавил экс-глава ДНР',
  'date': datetime.datetime(2019, 9, 26, 18, 20, 28, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/politics/38871266',
  'source': 'mail.ru'},
 {'title': 'Выбраны 50 лучших снимков от тревел-фотографов',
  'date': datetime.datetime(2019, 9, 26, 16, 31, 28, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38869923',
  'source': 'mail.ru'},
 {'title': 'Белка остановила девушку, чтобы та спасла бельчонка (видео)',
  'date': datetime.datetime(2019, 9, 26, 13, 12, 5, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38865961',
  'source': 'mail.ru'},
 {'title': 'Умер Герой Советского Союза Геннадий Манаков',
  'date': datetime.datetime(2019, 9, 26, 17, 10, 20, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38870666',
  'source': 'mail.ru'},
 {'title': 'Россия потратит миллиарды на жилье для чиновников',
  'date': datetime.datetime(2019, 9, 26, 9, 52, 15, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/economics/38862466',
  'source': 'mail.ru'},
 {'title': 'В России отказались судить Шварценеггера и Джеки Чана',
  'date': datetime.datetime(2019, 9, 26, 15, 3, 1, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38864436',
  'source': 'mail.ru'},
 {'title': 'В Татарстане прокомментировали идею легализации многоженства',
  'date': datetime.datetime(2019, 9, 26, 16, 50, 11, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38870193',
  'source': 'mail.ru'},
 {'title': 'Раскопку шахт с советскими деньгами проверит прокуратура',
  'date': datetime.datetime(2019, 9, 26, 16, 9, 18, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38869696',
  'source': 'mail.ru'},
 {'title': 'В Норвегии появился «перекрученный» мост (фото)',
  'date': datetime.datetime(2019, 9, 26, 17, 11, 9, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38870732',
  'source': 'mail.ru'},
 {'title': 'В Гидрометцентре назвали работающие погодные приметы',
  'date': datetime.datetime(2019, 9, 26, 16, 31, 51, tzinfo=datetime.timezone(datetime.timedelta(seconds=10800))),
  'link': 'https://news.mail.ru/society/38870002',
  'source': 'mail.ru'}]