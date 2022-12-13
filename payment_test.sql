-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `payment_test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `country`
--

INSERT INTO `country` (`id`, `code`, `name`) VALUES
(1, 'UA', 'Ukraine'),
(2, 'IN', 'India');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_system`
--

CREATE TABLE `payment_system` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment_system`
--

INSERT INTO `payment_system` (`id`, `name`, `desc`, `link`, `status`) VALUES
(1, 'Interkassa', 'Interkassa', 'https://interkassa.com', 'active'),
(2, 'PayU', 'PayU', 'https://payu.in', 'active'),
(3, 'CardPay', 'CardPay', 'https://cardpay.com', 'active'),
(4, 'Внутренний кошелек', 'Внутренний кошелек', NULL, 'active'),
(5, 'PayPal', 'PayPal', 'https://www.paypal.com', 'active'),
(6, 'GooglePay', 'GooglePay', 'https://googlepay.com', 'active'),
(7, 'ApplePay', 'ApplePay', 'https://applepay.com', 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_type`
--

CREATE TABLE `payment_type` (
  `id` int(11) NOT NULL,
  `payment_system_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `commission` decimal(10,2) NOT NULL DEFAULT '0.00',
  `type` enum('inner','external') NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  `img` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment_type`
--

INSERT INTO `payment_type` (`id`, `payment_system_id`, `name`, `commission`, `type`, `sort`, `img`, `status`) VALUES
(1, 1, 'Оплата картой', '2.50', 'external', 0, 'payment-card.jpg', 'active'),
(2, 1, 'LiqPay', '2.00', 'external', 0, 'liqpay.jpg', 'active'),
(3, 1, 'Терминалы IBOX', '4.00', 'external', 100, 'ibox.jpg', 'active'),
(4, 2, 'Локальные карты Индии', '6.00', 'external', 10, 'inloc.jpg', 'active'),
(5, 2, 'Карты VISA / MasterCard', '3.00', 'external', 0, 'visa-masc.jpg', 'active'),
(6, 2, 'Яндекс.Кошелек', '3.00', 'external', 0, 'yandex.jpg', 'active'),
(7, 2, 'QIWI-кошелек', '3.00', 'external', 0, 'qiwi.jpg', 'active'),
(8, 3, 'Visa / MasterCard', '1.00', 'external', 0, 'visa-masc.jpg', 'active'),
(9, 4, 'Внутренний оплата', '0.00', 'inner', 0, 'inner.jpg', 'active'),
(10, 1, 'Оплата картой ПриватБанка', '2.50', 'external', 0, 'privat.jpg', 'active'),
(11, 5, 'PayPal', '2.00', 'external', 0, 'paypal.jpg', 'active'),
(12, 6, 'GooglePay', '0.00', 'external', 0, 'googlepay.jpg', 'active'),
(13, 7, 'ApplePay', '0.00', 'external', 0, 'applepay.jpg', 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_type_country_allow`
--

CREATE TABLE `payment_type_country_allow` (
  `payment_type_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment_type_country_allow`
--

INSERT INTO `payment_type_country_allow` (`payment_type_id`, `country_id`) VALUES
(10, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `payment_type_country_disallow`
--

CREATE TABLE `payment_type_country_disallow` (
  `payment_type_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment_type_country_disallow`
--

INSERT INTO `payment_type_country_disallow` (`payment_type_id`, `country_id`) VALUES
(12, 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Индексы таблицы `payment_system`
--
ALTER TABLE `payment_system`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `payment_type`
--
ALTER TABLE `payment_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_system_id` (`payment_system_id`);

--
-- Индексы таблицы `payment_type_country_allow`
--
ALTER TABLE `payment_type_country_allow`
  ADD PRIMARY KEY (`payment_type_id`,`country_id`),
  ADD KEY `country_id` (`country_id`);

--
-- Индексы таблицы `payment_type_country_disallow`
--
ALTER TABLE `payment_type_country_disallow`
  ADD PRIMARY KEY (`payment_type_id`,`country_id`),
  ADD KEY `country_id` (`country_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `payment_system`
--
ALTER TABLE `payment_system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `payment_type`
--
ALTER TABLE `payment_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `payment_type`
--
ALTER TABLE `payment_type`
  ADD CONSTRAINT `payment_type_ibfk_1` FOREIGN KEY (`payment_system_id`) REFERENCES `payment_system` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payment_type_country_allow`
--
ALTER TABLE `payment_type_country_allow`
  ADD CONSTRAINT `payment_type_country_allow_ibfk_1` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_type_country_allow_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payment_type_country_disallow`
--
ALTER TABLE `payment_type_country_disallow`
  ADD CONSTRAINT `payment_type_country_disallow_ibfk_1` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_type_country_disallow_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
