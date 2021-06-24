Проанализировать структуру БД vk, которую мы создали на занятии, 
и внести предложения по усовершенствованию (если такие идеи есть). 
Напишите пожалуйста, всё-ли понятно по структуре.

Усовершенствование: 
дополнить как и во всех современных соц.сетей - лента, хранилища, мессенджер.



Добавить необходимую таблицу/таблицы для того, 
чтобы можно было использовать лайки для медиафайлов, постов и пользователей.

CREATE TABLE IF NOT EXISTS likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост", 
  comment TEXT NOT NULL COMMENT "Текст коммента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  );
