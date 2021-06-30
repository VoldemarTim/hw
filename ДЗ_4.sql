USE vk;

 -- Создаем и связываем таблицы для постов, медиа и лайков 
 
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Тип медиайла',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Тип медиа контента';

CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  media_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип контента',
  filename varchar(1000) NOT NULL COMMENT 'Путь в файлу',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Медиа';

ALTER TABLE media ADD CONSTRAINT fk_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id);

CREATE TABLE messages_media (
  message_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор сообшения',
  media_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор медиа',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Связь сообщений и медиа';

ALTER TABLE messages_media ADD CONSTRAINT fk_mm_media_id FOREIGN KEY (media_id) REFERENCES media (id);
ALTER TABLE messages_media ADD CONSTRAINT fk_mm_message_id FOREIGN KEY (message_id) REFERENCES messages (id);

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  user_id int UNSIGNED DEFAULT NULL COMMENT 'Ссылка на идентификатор пользователя который опубликовал пост',
  community_id int UNSIGNED DEFAULT NULL COMMENT 'Ссылка на дентификатор пользователя который опубликовал пост',
  post_content text COMMENT 'Текст произвольной длины',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время публикации поста',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Посты пользователей и групп';

ALTER TABLE posts ADD CONSTRAINT fk_post_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE posts ADD CONSTRAINT fk_post_community_id FOREIGN KEY (community_id) REFERENCES communities(id);

CREATE TABLE posts_media (
  post_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор поста',
  media_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор медиа',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (post_id, media_id)
) COMMENT 'Связь постов и медиа';

ALTER TABLE posts_media ADD CONSTRAINT fk_pm_media_id FOREIGN KEY (media_id) REFERENCES media(id);
ALTER TABLE posts_media ADD CONSTRAINT fk_pm_post_id FOREIGN KEY (post_id) REFERENCES posts(id);

CREATE TABLE like_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  like_type_name varchar(100) NOT NULL UNIQUE COMMENT 'Название варианта лайка'
) COMMENT 'Справочная таблица с типами лайков';

CREATE TABLE entity_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  entity_name varchar(100) NOT NULL UNIQUE COMMENT 'Имя сущности'
) COMMENT 'Справочная таблица с перечнем сущностей, которым можно поставить лайк';

CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  entity_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор сущности',
  from_user_id int unsigned NOT NULL COMMENT 'Ссылка на идентификатор пользователя',
  like_type_id int unsigned NOT NULL COMMENT 'Ссылка на тип лайка',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Таблица лайков';

ALTER TABLE likes ADD CONSTRAINT fk_likes_entity_id FOREIGN KEY (entity_id) REFERENCES entity_types(id);
ALTER TABLE likes ADD CONSTRAINT fk_likes_type_id FOREIGN KEY (like_type_id) REFERENCES like_types(id);

-- Ограничесние целостности CHECK

INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'cherzog@example.net', '509-986-2300x58598', '1990-04-12 21:42:36', '2003-07-12 06:48:50');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'wilkinson.loraine@example.com', '(737)498-1615x2849', '1988-12-01 02:42:20', '2003-05-19 10:06:19');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'antwon34@example.com', '+10(8)8934137382', '2009-08-23 09:42:37', '2019-02-25 22:06:35');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'jakubowski.cameron@example.org', '(709)957-7507', '2002-08-27 17:56:19', '2014-12-01 23:01:22');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'bernardo77@example.net', '858-093-9510x9193', '2016-01-27 17:46:22', '1983-03-27 23:44:31');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'bstiedemann@example.org', '08856615317', '1998-08-27 13:21:25', '1978-09-18 17:27:16');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'xstehr@example.org', '419.567.8366', '2020-03-16 11:25:07', '2010-05-21 18:41:42');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'bayer.hailie@example.org', '717-413-1244x97668', '1993-12-10 16:55:24', '1982-07-18 19:45:46');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'shirthe@example.org', '(698)752-9748', '1979-12-17 08:41:14', '2000-07-04 11:06:09');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'orin.borer@example.org', '1-496-291-6169x0028', '2018-11-22 11:00:19', '2018-10-10 12:00:41');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'emil17@example.com', '911.754.3337', '1998-05-14 13:27:09', '2003-02-05 16:15:47');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'jessika31@example.net', '1-828-358-7120x18317', '1999-02-13 06:53:17', '2004-08-02 20:44:36');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'buckridge.mayra@example.org', '151.995.7276', '1994-06-03 23:35:42', '1979-10-25 04:19:28');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'omante@example.org', '+02(7)8578013924', '2008-06-01 03:28:47', '1999-12-05 00:06:41');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'wilbert37@example.net', '+86(6)4554074423', '2009-09-03 18:23:05', '1988-01-17 12:19:22');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'carmella.jakubowski@example.net', '187-146-6626x41525', '2020-06-29 17:48:30', '1996-06-21 19:22:16');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'pmaggio@example.org', '304.772.3049', '1991-03-13 10:51:23', '1987-06-30 04:05:52');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'windler.emely@example.net', '+31(9)0889023553', '1976-08-26 20:36:08', '1985-12-16 19:54:10');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'emilia.rippin@example.net', '1-060-256-4499x2161', '1975-05-12 17:41:59', '1971-06-24 16:08:00');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'murray.lauren@example.net', '(918)983-6050', '2002-12-23 04:21:07', '2018-08-18 14:35:50');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'cassandra68@example.net', '+30(4)4437349828', '1981-11-13 14:23:29', '1973-02-06 19:15:21');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'rafaela49@example.org', '+78(4)0961354221', '1987-08-24 20:10:59', '2004-09-03 13:26:59');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'kristopher60@example.net', '513.846.0891', '2002-09-13 07:55:35', '2015-11-18 19:51:47');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'abernathy.rosetta@example.com', '+57(7)1709889272', '2021-02-17 20:53:19', '1980-12-10 15:45:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'gilbert08@example.org', '1-758-609-0517x830', '2015-05-23 04:14:53', '1978-09-17 15:58:25');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'savanna.bayer@example.net', '849-831-4284', '1999-03-20 07:36:56', '1976-01-24 03:27:29');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'barrows.jordan@example.org', '06910658525', '1993-10-19 02:27:28', '2000-04-26 13:33:32');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'tony44@example.com', '248.019.7423x545', '1980-06-09 10:40:25', '1988-01-22 02:52:48');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'kturner@example.net', '00295789170', '1994-07-04 13:00:08', '2007-05-26 03:59:20');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'hudson.filiberto@example.org', '(312)271-2726x846', '2019-02-20 19:10:39', '2010-09-11 20:04:13');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'kub.alanis@example.net', '(993)603-9283', '2011-03-19 19:33:48', '1993-02-04 04:48:27');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'israel.bernhard@example.net', '290.739.0266x290', '2000-04-08 04:55:52', '1988-12-17 17:46:56');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'emmie.stokes@example.com', '075-391-8973', '2003-11-26 13:52:15', '1997-12-07 05:46:45');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'chickle@example.org', '368.020.6082', '2015-12-26 09:03:59', '1982-05-22 23:53:37');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'sophia93@example.com', '+01(5)6816901144', '1982-10-26 15:35:19', '2012-05-11 19:40:23');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'sgleichner@example.org', '024.133.1534', '1977-08-11 04:34:20', '1971-04-18 23:13:43');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'ubauch@example.org', '(869)587-3360', '2007-02-23 22:21:44', '1981-03-18 12:34:38');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'christy.heaney@example.org', '05990086887', '1993-05-23 12:45:05', '1988-10-01 15:21:15');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'jbode@example.net', '(132)406-8269x20415', '2013-11-14 08:34:14', '1973-05-12 02:34:00');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'bzieme@example.org', '1-713-245-1246x59137', '2007-05-19 22:32:32', '1991-09-19 01:35:47');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'abshire.geovanny@example.com', '1-513-385-6493', '1982-09-12 03:58:00', '2017-10-27 07:52:43');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'jeichmann@example.net', '1-430-004-5086x3080', '2006-10-20 19:33:24', '2008-09-03 06:36:44');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'lindsey.little@example.com', '1-569-578-4610x5447', '2002-05-10 15:46:19', '2009-08-28 05:29:19');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'ian.keeling@example.com', '125.290.3864x912', '1987-01-05 06:13:04', '2012-05-06 00:34:09');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'labadie.bernard@example.net', '06234415789', '1987-01-25 14:39:32', '1982-01-23 02:38:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'maurine42@example.org', '(979)472-4837x2348', '1970-03-25 04:30:30', '1977-08-17 07:46:18');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'dejah.dooley@example.org', '1-648-740-5350', '1971-03-03 00:56:34', '2006-05-25 15:01:59');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'alfreda10@example.net', '01084223918', '2007-12-21 05:28:04', '2008-02-11 17:40:50');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'kihn.dovie@example.org', '1-008-875-8377x349', '1995-01-02 02:05:33', '1991-07-17 19:49:52');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'wschuppe@example.net', '(699)323-0927x8121', '2015-09-17 05:23:19', '1994-07-05 01:22:28');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'reyna35@example.org', '578-275-1086x37572', '1993-10-09 08:10:21', '2018-05-27 06:31:26');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'kareem68@example.net', '1-879-757-3541x9135', '2009-09-07 16:44:43', '2000-02-18 08:57:21');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'lonie.bartoletti@example.com', '1-888-767-3579x4644', '1984-09-01 09:10:33', '2005-02-11 06:56:17');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'lucie.hackett@example.net', '1-233-358-4224x42408', '2009-02-02 13:28:41', '2003-02-03 05:57:34');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'wmetz@example.org', '529-550-8096', '1993-01-15 08:25:45', '2020-02-24 08:02:47');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'tessie.brekke@example.net', '951-564-0590x1724', '1972-08-02 05:17:17', '2002-10-26 12:02:51');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'karlie.harris@example.org', '1-828-134-9283x1591', '2021-06-17 23:34:09', '1993-07-11 05:11:03');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'lhahn@example.net', '1-132-442-8028', '2017-06-12 07:33:42', '2002-08-22 10:27:12');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'macejkovic.yazmin@example.org', '1-728-582-0185', '2015-10-06 15:58:26', '2013-10-12 12:55:16');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'keeling.ethel@example.net', '936.859.7664x641', '1994-01-11 03:37:53', '2009-11-27 14:44:26');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'felton05@example.net', '+25(2)1967680959', '2005-01-13 09:17:18', '1982-06-28 00:01:42');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'melisa.paucek@example.com', '+69(4)5653348845', '1981-08-13 21:06:22', '2001-10-06 09:44:56');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'jakubowski.libby@example.com', '(860)325-9720', '2020-01-11 09:52:01', '2007-07-25 11:13:40');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'rmclaughlin@example.com', '201-041-1010', '2005-03-27 08:25:30', '1983-10-14 13:17:38');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'johnson.bradley@example.org', '583.168.2119x107', '2016-12-01 01:53:28', '1979-05-14 21:04:53');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'audrey.boyer@example.org', '1-943-195-7090x80927', '2004-12-22 04:32:34', '2002-03-09 12:30:37');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'wilmer.wilderman@example.org', '+68(1)7434140621', '1981-11-21 00:50:34', '2001-11-23 04:15:34');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'jessyca.goldner@example.org', '+23(8)9043049616', '2002-04-07 00:48:33', '2007-05-10 04:54:23');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'homenick.lloyd@example.com', '1-896-704-3019', '1984-08-05 18:05:55', '1994-02-24 23:14:07');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'rhett39@example.net', '+66(8)3530136801', '2012-05-11 19:40:10', '1980-03-22 00:38:32');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'marie.altenwerth@example.org', '+40(9)4616480143', '2004-09-04 07:19:30', '1972-10-11 15:26:16');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'rae39@example.org', '+66(8)8173837335', '1991-10-26 04:04:52', '1971-05-02 02:15:21');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'jeanette.huel@example.com', '295.792.4212', '2006-09-08 18:07:49', '1986-09-02 02:01:33');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'uharber@example.org', '+14(7)4911396366', '1993-09-19 22:05:29', '1998-12-03 19:58:22');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'dakota.goyette@example.net', '1-430-555-0761x4336', '2005-06-24 03:22:11', '1989-02-19 06:10:33');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'madison.osinski@example.net', '1-852-669-5482', '2017-08-17 15:03:56', '1997-10-26 16:09:53');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'skohler@example.org', '1-876-253-4541x380', '1985-12-22 16:52:45', '1999-08-02 00:47:56');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'dameon35@example.com', '590.004.9126', '2018-10-05 10:50:51', '1981-05-30 11:58:33');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'lindgren.larry@example.com', '773-399-9746', '1987-03-12 06:51:37', '2001-04-17 12:39:27');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'kali.schamberger@example.org', '03608136774', '2004-09-09 03:36:20', '2006-01-10 09:36:43');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'obartoletti@example.net', '075.795.2047x99033', '1984-11-17 22:25:02', '2015-01-30 14:30:43');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'alba.johns@example.net', '(814)613-2237x55770', '1995-11-16 19:04:46', '1978-10-07 13:27:44');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'marques.reichel@example.com', '365-118-4734x665', '2001-02-20 12:30:01', '1970-08-23 04:44:43');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'trystan03@example.net', '(889)763-0492x038', '1995-10-15 15:40:30', '1988-11-12 12:42:58');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'tessie88@example.com', '696-466-1904', '2000-02-15 17:36:21', '1978-08-28 07:49:01');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'kpaucek@example.org', '1-606-430-9534', '1971-11-08 02:55:37', '1984-01-20 17:41:42');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'kovacek.sasha@example.net', '1-353-879-4804', '2003-05-31 00:49:14', '2009-03-09 15:21:34');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'gjaskolski@example.com', '1-492-708-2754', '2015-03-11 20:30:52', '1971-05-26 16:31:38');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'emurray@example.net', '975-445-7504x22647', '2014-05-08 07:00:38', '1986-06-01 11:56:58');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'krunte@example.org', '573.719.0057', '1972-04-19 14:59:47', '1979-12-22 21:14:16');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'laurine.jaskolski@example.org', '01832097882', '1985-04-14 04:00:55', '2004-03-26 08:54:25');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'gcorwin@example.com', '+93(8)4958033828', '1975-06-17 09:36:25', '1987-08-13 10:46:14');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'onie48@example.com', '(649)569-8207x4929', '1980-11-24 22:14:17', '2008-10-28 18:42:33');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'darby16@example.net', '185.576.8622x16848', '1987-06-24 04:38:43', '1979-12-27 08:56:55');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'priscilla02@example.com', '678-472-5956', '1993-08-07 03:21:49', '1980-01-11 11:06:15');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'jody.keebler@example.net', '351.249.9676x4871', '2012-08-05 08:19:24', '2009-04-12 08:14:39');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'plabadie@example.com', '(697)848-7957', '1998-12-19 14:29:16', '1985-10-08 06:59:51');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'norval14@example.net', '487.271.5496x064', '2019-12-28 22:10:23', '2019-11-13 09:18:29');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'glenna.crooks@example.org', '1-717-992-0409', '1977-01-26 08:21:49', '1995-11-10 03:06:42');
INSERT INTO `users` (`id`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'cleora.robel@example.com', '849.519.6514x00554', '1975-06-01 22:40:34', '1989-03-28 07:32:20');

-- Проверяем данные 
SELECT phone from users LIMIT 10;

-- Допустимы только номера телефонов вида +7<10 цифровых знаков>
ALTER TABLE users ADD CONSTRAINT phone_check CHECK (REGEXP_LIKE(PHONE, '^\\+7[0-9]{10}$'));

-- Генерируем подходящие данные для номера телефонов
update users set phone = CONCAT('+7', 9000000000 + FLOOR(RAND()*9999999999)); 

-- Работа с метаданными
USE INFORMATION_SCHEMA;

SHOW TABLES;

DESC `TABLES`;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE  WHERE TABLE_SCHEMA = 'vk';

SELECT 
	TABLE_NAME,
	COLUMN_NAME,
	CONSTRAINT_NAME,
	REFERENCED_TABLE_NAME,
	REFERENCED_COLUMN_NAME
FROM 
	INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
	TABLE_SCHEMA = 'vk'
    AND TABLE_NAME = 'profiles' 
    AND REFERENCED_COLUMN_NAME IS NOT NULL;