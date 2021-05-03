-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 03 2021 г., 12:03
-- Версия сервера: 5.7.31
-- Версия PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test_task`
--

-- --------------------------------------------------------

--
-- Структура таблицы `boosterpack`
--

DROP TABLE IF EXISTS `boosterpack`;
CREATE TABLE IF NOT EXISTS `boosterpack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bank` decimal(10,2) NOT NULL DEFAULT '0.00',
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `boosterpack`
--

INSERT INTO `boosterpack` (`id`, `price`, `bank`, `time_created`, `time_updated`) VALUES
(1, '5.00', '2.00', '2020-03-30 00:17:28', '2021-05-03 07:35:07'),
(2, '20.00', '0.00', '2020-03-30 00:17:28', '2021-04-28 18:37:47'),
(3, '50.00', '0.00', '2020-03-30 00:17:28', '2021-04-28 18:37:53');

-- --------------------------------------------------------

--
-- Структура таблицы `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `assign_id` int(10) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `to_user_id`, `assign_id`, `text`, `time_created`, `time_updated`) VALUES
(1, 1, NULL, 1, 'Ну чо ассигн проверим', '2020-03-27 21:39:44', '2021-04-28 05:59:40'),
(2, 1, 2, 1, 'Второй коммент', '2020-03-27 21:39:55', '2021-04-27 16:28:38'),
(3, 2, 1, 1, 'Второй коммент от второго человека', '2020-03-27 21:40:22', '2021-04-27 16:28:36'),
(8, 1, NULL, 1, 'Comment', '2021-04-29 06:58:42', '2021-04-29 06:58:42'),
(12, 2, NULL, 1, 'test', '2021-04-29 07:15:56', '2021-04-29 07:15:56');

-- --------------------------------------------------------

--
-- Структура таблицы `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `img` varchar(1024) DEFAULT NULL,
  `likes` int(11) NOT NULL,
  `time_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `post`
--

INSERT INTO `post` (`id`, `user_id`, `text`, `img`, `likes`, `time_created`, `time_updated`) VALUES
(1, 2, 'Тестовый постик 1', '../images/posts/1.png', 24, '2018-08-30 13:31:14', '2021-04-29 07:19:25'),
(2, 2, 'Печальный пост', '../images/posts/2.png', 0, '2018-10-11 01:33:27', '2021-04-29 07:05:33');

-- --------------------------------------------------------

--
-- Структура таблицы `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sum` decimal(10,2) NOT NULL,
  `c_likes` int(11) NOT NULL DEFAULT '0',
  `cur_balance` decimal(10,2) NOT NULL,
  `info` int(11) NOT NULL DEFAULT '0',
  `time_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `transaction`
--

INSERT INTO `transaction` (`id`, `type`, `user_id`, `sum`, `c_likes`, `cur_balance`, `info`, `time_created`, `time_updated`) VALUES
(1, 1, 2, '10.00', 0, '120.00', 0, '2021-05-02 12:12:41', '2021-05-02 09:12:41'),
(2, 1, 2, '10.00', 0, '140.00', 0, '2021-05-02 14:01:11', '2021-05-02 11:01:11'),
(3, 1, 2, '10.00', 0, '150.00', 0, '2021-05-02 14:08:01', '2021-05-02 11:08:01'),
(4, 1, 1, '10.00', 0, '160.00', 0, '2021-05-02 14:08:11', '2021-05-03 08:17:59'),
(5, 2, 2, '5.00', 3, '170.00', 2, '2021-05-02 16:13:15', '2021-05-03 07:33:55'),
(6, 2, 2, '5.00', 2, '145.00', 1, '2021-05-02 16:45:37', '2021-05-03 07:33:50'),
(7, 2, 1, '5.00', 13, '140.00', 1, '2021-05-03 10:34:22', '2021-05-03 07:51:07'),
(8, 2, 2, '5.00', 6, '135.00', 1, '2021-05-03 10:34:46', '2021-05-03 07:34:46'),
(9, 2, 2, '5.00', 3, '130.00', 1, '2021-05-03 10:35:07', '2021-05-03 07:35:07');

-- --------------------------------------------------------

--
-- Структура таблицы `transaction_info`
--

DROP TABLE IF EXISTS `transaction_info`;
CREATE TABLE IF NOT EXISTS `transaction_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `transaction_info`
--

INSERT INTO `transaction_info` (`id`, `type`) VALUES
(1, 'purchase boosterpack_1'),
(2, 'purchase boosterpack_2'),
(3, 'purchase boosterpack_3');

-- --------------------------------------------------------

--
-- Структура таблицы `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
CREATE TABLE IF NOT EXISTS `transaction_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `transaction_type`
--

INSERT INTO `transaction_type` (`id`, `type`) VALUES
(1, 'Adding money'),
(2, 'Withdrawn ');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `personaname` varchar(50) NOT NULL DEFAULT '',
  `avatarfull` varchar(150) NOT NULL DEFAULT '',
  `rights` tinyint(4) NOT NULL DEFAULT '0',
  `wallet_balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_likes` int(11) NOT NULL DEFAULT '0',
  `wallet_total_refilled` decimal(10,2) NOT NULL DEFAULT '0.00',
  `wallet_total_withdrawn` decimal(10,2) NOT NULL DEFAULT '0.00',
  `time_created` datetime NOT NULL,
  `time_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `time_created` (`time_created`),
  KEY `time_updated` (`time_updated`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `personaname`, `avatarfull`, `rights`, `wallet_balance`, `wallet_total_likes`, `wallet_total_refilled`, `wallet_total_withdrawn`, `time_created`, `time_updated`) VALUES
(1, 'admin@niceadminmail.pl', '123', 'AdminProGod', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/96/967871835afdb29f131325125d4395d55386c07a_full.jpg', 0, '0.00', 5, '0.00', '0.00', '2019-07-26 01:53:54', '2021-04-28 08:01:18'),
(2, 'simpleuser@niceadminmail.pl', '123', 'simpleuser', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/86/86a0c845038332896455a566a1f805660a13609b_full.jpg', 0, '125.00', 43, '200.00', '75.00', '2019-07-26 01:53:54', '2021-05-03 07:35:07');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
