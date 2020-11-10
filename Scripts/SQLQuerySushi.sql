CREATE DATABASE SushiRestaurant
SET LANGUAGE 'English'
--SET LANGUAGE 'Russian'
GO
USE SushiRestaurant
--USE DreamHomeKlinduhov
GO

CREATE TABLE CUSTOMER
(
	Customer_no SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname VARCHAR(20) NOT NULL,
	LNAME VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	District VARCHAR(20) NOT NULL,
	Street VARCHAR(20) NOT NULL,
	House VARCHAR(7) NOT NULL,
	FLAT SMALLINT NULL,
	Tel_no VARCHAR(20)
)

CREATE TABLE ORDERS
(
	Order_no SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Price MONEY NOT NULL,
	Customer_no SMALLINT NOT NULL
	CONSTRAINT FK_Customer_no FOREIGN KEY (Customer_no) REFERENCES CUSTOMER
)

CREATE TABLE COURIER
(
	Courier_no SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname VARCHAR(20) NOT NULL,
	LNAME VARCHAR(20) NOT NULL,
	DOB DATE NOT NULL,
	SEX BIT NOT NULL, -- 1 (муж), 0 (жен)
	City VARCHAR(20) NOT NULL,
	Street VARCHAR(20) NOT NULL,
	House VARCHAR(20) NOT NULL,
	Flat INT NULL,
	STel_no VARCHAR(20) NULL,
	Date_Joined DATE NOT NULL,
	Salary MONEY NOT NULL
)

CREATE TABLE DELIVERY
(
	Delivery_no SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Datetime_delivery DATETIME NOT NULL,
	District VARCHAR(20) NOT NULL,
	Street VARCHAR(20) NOT NULL,
	House VARCHAR(7) NOT NULL,
	FLAT SMALLINT NULL,
	Tel_no VARCHAR(20),
	Order_no SMALLINT,
	Courier_no SMALLINT,
	CONSTRAINT FK_Order_no FOREIGN KEY (Order_no) REFERENCES ORDERS,
	CONSTRAINT FK_Courier_no FOREIGN KEY (Courier_no) REFERENCES COURIER
)

CREATE TABLE BEVERAGE
(
	Beverage_id SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name_bevr VARCHAR(20) NULL,
	Count_bevr INT NULL
)

CREATE TABLE DISH
(
	Dish_id SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name_dish VARCHAR(20) NOT NULL,
	Count_dish INT NOT NULL
)

CREATE TABLE MENU
(
	Menu_id SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Datetime_menu DATETIME NOT NULL,
	Order_no SMALLINT,
	Beverage_id SMALLINT NULL,
	Dish_id SMALLINT,
	CONSTRAINT FK_MENU_Order_no FOREIGN KEY (Order_no) REFERENCES ORDERS,
	CONSTRAINT FK_Beverage_id FOREIGN KEY (Beverage_id) REFERENCES BEVERAGE,
	CONSTRAINT FK_Dish_id FOREIGN KEY (Dish_id) REFERENCES DISH
)


/*
CREATE TABLE INGREDIENT
(
	Ingredient_id SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name_ingr VARCHAR(20) NOT NULL,
	Count_ingr VARCHAR(20) NOT NULL
)

CREATE TABLE COMPOSITION
(
	CountComp INT NOT NULL
)

CREATE TABLE WAREHOUSE
(
	Warehouse_id SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	PriceIngr MONEY NOT NULL,
	CountIngr INT NOT NULL
)*/

GO
INSERT INTO CUSTOMER (Fname, LNAME, City, District, Street, House, FLAT, Tel_no)
VALUES ('Валенитин', 'Корж', 'Минск', 'Октябрьский', 'Парковая', '5', 13, '23-79-77'),
('Сергей', 'Петров', 'Минск', 'Советский', 'Чкалова', '21/1', 12, '8(029)662-47-32'),
('Иван', 'Сидоров', 'Минск', 'Московский', 'Чкалова', '41/2', 96, '23-06-73'),
('Олег', 'Кожемякин', 'Минск', 'Фрунзенский', 'Школьная', '47/1', 157, '22-29-03'),
('Степан', 'Разин', 'Минск', 'Ленинский', 'Гагарина', '31', 28, '63-43-98'),
('Ольга', 'Рюриковна', 'Минск', 'Первомайский', 'Лазо', '90/1', 54, '62-43-64')
GO
INSERT INTO ORDERS (Price, Customer_no)
VALUES (120, 1),
(110, 2),
(60, 3),
(80, 4),
(220, 5),
(143, 6),
(10, 1),
(340, 2),
(600, 3),
(86, 4),
(128, 5),
(143, 6),
(100, 2),
(110, 2),
(67, 3),
(81, 1),
(220, 5),
(123, 2),
(220, 2),
(110, 2),
(60, 3),
(80, 4),
(220, 5),
(143, 6),
(100, 2),
(340, 2),
(60, 3),
(86, 4),
(220, 4),
(143, 6),
(164, 2),
(110, 2),
(67, 3),
(81, 1),
(23, 2),
(123, 4)
GO
INSERT INTO DISH (Name_dish, Count_dish)
VALUES ('Суши', 7),
('Роллы', 5),
('Мисо ширу', 3),
('Рамен', 2),
('Сакано сарада', 3),
('Ниватори', 4),
('Суши', 2),
('Роллы', 3),
('Мисо ширу', 10),
('Рамен', 5),
('Сакано сарада', 1),
('Ниватори', 6),
('Суши', 4),
('Роллы', 11),
('Мисо ширу', 3),
('Рамен', 4),
('Сакано сарада', 1),
('Ниватори', 6),
('Суши', 10),
('Роллы', 2),
('Мисо ширу', 8),
('Рамен', 1),
('Сакано сарада', 4),
('Ниватори', 7),
('Суши', 2),
('Роллы', 3),
('Мисо ширу', 2),
('Рамен', 5),
('Сакано сарада', 1),
('Ниватори', 2),
('Суши', 4),
('Роллы', 8),
('Мисо ширу', 2),
('Рамен', 3),
('Сакано сарада', 1),
('Ниватори', 3)
GO
INSERT INTO BEVERAGE (Name_bevr, Count_bevr)
VALUES ('Кола', 4),
('Спрайт', 2),
('Фанта', 2),
('Бонаква', 3),
('Дарида', 2),
('Миринда', 2),
('Кола', 2),
('Спрайт', 2),
('Фанта', 2),
(NULL, NULL),
('Дарида', 3),
('Миринда', 2),
('Кола', 5),
('Спрайт', 2),
(NULL, NULL),
('Бонаква', 3),
('Дарида', 4),
('Миринда', 3),
('Кола', 1),
('Спрайт', 2),
('Фанта', 1),
('Бонаква', 2),
('Дарида', 1),
('Миринда', 2),
('Кола', 3),
('Спрайт', 1),
('Фанта', 2),
(NULL, NULL),
('Дарида', 1),
('Миринда', 2),
('Кола', 5),
('Спрайт', 2),
(NULL, NULL),
('Бонаква', 2),
('Дарида', 1),
('Миринда', 3)
GO
INSERT INTO MENU (Order_no, Beverage_id, Dish_id, Datetime_menu)
VALUES (1, 1, 1, CONVERT(DATETIME, '01.02.2020 01:10:22')),
(2, 2, 2, CONVERT(DATETIME, '01.03.2020 01:10:22')),
(3, 3, 3, CONVERT(DATETIME, '01.04.2020 01:10:22')),
(4, 4, 4, CONVERT(DATETIME, '01.06.2020 01:10:22')),
(5, 5, 5, CONVERT(DATETIME, '01.07.2020 01:10:22')),
(6, 6, 6, CONVERT(DATETIME, '01.09.2020 01:10:22')),
(7, 7, 7, CONVERT(DATETIME, '01.12.2020 01:10:22')),
(8, 8, 8, CONVERT(DATETIME, '01.15.2020 01:10:22')),
(9, 9, 9, CONVERT(DATETIME, '01.18.2020 01:10:22')),
(10, NULL, 10, CONVERT(DATETIME, '01.20.2020 01:10:22')),
(11, 11, 11, CONVERT(DATETIME, '01.24.2020 01:10:22')),
(12, 12, 12, CONVERT(DATETIME, '01.29.2020 01:10:22')),
(13, 13, 13, CONVERT(DATETIME, '02.02.2020 01:10:22')),
(14, 14, 14, CONVERT(DATETIME, '02.03.2020 01:10:22')),
(15, NULL, 15, CONVERT(DATETIME, '02.06.2020 01:10:22')),
(16, 16, 16, CONVERT(DATETIME, '02.08.2020 01:10:22')),
(17, 17, 16, CONVERT(DATETIME, '02.09.2020 01:10:22')),
(18, 18, 18, CONVERT(DATETIME, '02.12.2020 01:10:22')),
(19, 19, 18, CONVERT(DATETIME, '02.14.2020 01:10:22')),
(20, 20, 20, CONVERT(DATETIME, '02.16.2020 01:10:22')),
(21, 21, 21, CONVERT(DATETIME, '02.17.2020 01:10:22')),
(22, 22, 22, CONVERT(DATETIME, '02.18.2020 01:10:22')),
(23, 23, 23, CONVERT(DATETIME, '02.20.2020 01:10:22')),
(24, 24, 24, CONVERT(DATETIME, '02.25.2020 01:10:22')),
(25, 25, 25, CONVERT(DATETIME, '02.27.2020 01:10:22')),
(26, 26, 26, CONVERT(DATETIME, '03.04.2020 01:10:22')),
(27, 27, 27, CONVERT(DATETIME, '03.07.2020 01:10:22')),
(28, NULL, 28, CONVERT(DATETIME, '03.08.2020 01:10:22')),
(29, 29, 29, CONVERT(DATETIME, '03.10.2020 01:10:22')),
(30, 30, 30, CONVERT(DATETIME, '03.12.2020 01:10:22')),
(31, 31, 31, CONVERT(DATETIME, '03.15.2020 01:10:22')),
(32, 32, 32, CONVERT(DATETIME, '03.19.2020 01:10:22')),
(33, NULL, 33, CONVERT(DATETIME, '03.21.2020 01:10:22')),
(34, 34, 34, CONVERT(DATETIME, '03.22.2020 01:10:22')),
(35, 35, 35, CONVERT(DATETIME, '03.24.2020 01:10:22')),
(36, 36, 36, CONVERT(DATETIME, '03.27.2020 01:10:22'))
/*
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, NULL, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 23),
(14, 14, 14),
(15, NULL, 3),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20),
(21, 21, 21),
(22, 22, 22),
(23, 23, 23),
(24, 24, 24),
(25, 25, 25),
(26, 26, 26),
(27, 27, 27),
(28, NULL, 6),
(29, 29, 29),
(30, 30, 30),
(31, 31, 31),
(32, 32, 32),
(33, NULL, 33),
(34, 34, 34),
(35, 35, 35),
(36, 36, 36)*/

GO
INSERT INTO COURIER (LName, Fname, DOB, Sex, City, Street, House, Flat, STel_no, Date_Joined, Salary)
VALUES ('Батуркин', 'Александр', CONVERT(DATETIME, '10.17.1968'), 1, 'Новополоцк', 'Парковая', '5', 13, '23-79-77', CONVERT(DATETIME, '01.01.2001'), 2500000),
('Чубаро', 'Наталья', CONVERT(DATETIME, '05.05.1972'), 0, 'Витебск', 'Чкалова', '21/1', 12, '8(029)662-47-32', CONVERT(DATETIME, '02.10.2002'), 1800000),
('Коваленко', 'Светлана', CONVERT(DATETIME, '02.01.1970'), 0,  'Витебск', 'Чкалова', '24', 49, '62-51-23', CONVERT(DATETIME, '01.15.2001'), 2500000),
('Логинов', 'Вадим', CONVERT(DATETIME, '09.09.1967'), 1, 'Витебск', 'Чкалова', '41/2', 96, '23-06-73', CONVERT(DATETIME, '09.02.1999'), 3000000),
('Суворов', 'Виталий', CONVERT(DATETIME, '11.07.1965'), 1, 'Новополоцк', 'Школьная', '47/1', 157, '22-29-03', CONVERT(DATETIME, '02.01.1999'), 1800000),
('Жарков', 'Герман', CONVERT(DATETIME, '11.05.1969'), 1, 'Витебск', 'Гагарина', '31', 28, '63-43-98', CONVERT(DATETIME, '10.02.2001'), 2800000),
('Ганущенко', 'Галина', CONVERT(DATETIME, '11.05.1969'), 0, 'Витебск', 'Лазо', '90/1', 54, '62-43-64', CONVERT(DATETIME, '11.03.2004'), 1800000),
('Сотникова', 'Ольга', CONVERT(DATETIME, '12.07.1967'), 0, 'Полоцк', 'Вокзальная', '7', NULL, NULL, CONVERT(DATETIME, '02.02.2002'), 1000000),
('Янчиленко', 'Сергей', CONVERT(DATETIME, '02.28.1970'), 1, 'Россоны', 'Ленина', '28/2', 25, NULL, CONVERT(DATETIME, '05.17.2005'), 1500000)
GO
INSERT INTO DELIVERY (Datetime_delivery, District, Street, House, FLAT, Tel_no, Order_no, Courier_no)
VALUES (CONVERT(DATETIME, '01.02.2020 01:10:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '01.03.2020 01:20:22'), 'Советский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 2),
(CONVERT(DATETIME, '01.04.2020 01:25:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '01.06.2020 02:05:22'), 'Московский', 'Школьная', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '01.07.2020 01:12:22'), 'Московский', 'Гагарина', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '01.09.2020 01:40:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '01.12.2020 01:30:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '01.15.2020 01:11:22'), 'Первомайский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 1),
(CONVERT(DATETIME, '01.18.2020 02:00:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '01.20.2020 02:11:22'), 'Октябрьский', 'Школьная', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '01.24.2020 01:12:22'), 'Ленинский', 'Гагарина', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '01.29.2020 01:44:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '02.02.2020 01:32:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '02.03.2020 01:56:22'), 'Московский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 5),
(CONVERT(DATETIME, '02.06.2020 01:15:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '02.08.2020 01:14:22'), 'Октябрьский', 'Школьная', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '02.09.2020 01:19:22'), 'Октябрьский', 'Гагарина', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '02.12.2020 01:21:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 1),
(CONVERT(DATETIME, '02.14.2020 01:28:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '02.16.2020 01:35:22'), 'Советский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 1),
(CONVERT(DATETIME, '02.17.2020 01:38:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '02.18.2020 01:19:22'), 'Московский', 'Школьная', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '02.20.2020 01:43:22'), 'Московский', 'Гагарина', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '02.25.2020 01:41:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '02.27.2020 01:49:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '03.04.2020 01:47:22'), 'Первомайский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 6),
(CONVERT(DATETIME, '03.07.2020 01:56:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '03.08.2020 01:22:22'), 'Октябрьский', 'Школьная', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '03.10.2020 01:25:22'), 'Ленинский', 'Гагарина', '31', 28, '63-43-98', 5, 6),
(CONVERT(DATETIME, '03.12.2020 01:29:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '03.15.2020 01:35:22'), 'Октябрьский', 'Парковая', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '03.19.2020 01:39:22'), 'Московский', 'Чкалова', '21/1', 12, '8(029)662-47-32', 2, 5),
(CONVERT(DATETIME, '03.21.2020 01:36:22'), 'Московский', 'Чкалова', '41/2', 96, '23-06-73', 3, 2),
(CONVERT(DATETIME, '03.22.2020 01:27:22'), 'Октябрьский', 'Школьная', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '03.24.2020 01:29:22'), 'Октябрьский', 'Гагарина', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '03.27.2020 01:17:22'), 'Первомайский', 'Лазо', '90/1', 54, '62-43-64', 6, 1)



-- самые востребованные товары по районам города 
-- разбросы по времени и географии доставки 
-- распределение заказов по времени суток (месяцам, дням недели,…) и районам города 
-- будет большим плюсом, если диаграммы/графики будут и интерактивными 
-- Количество заказов по месяцам
-- Кол-во заказов по времени
-- Кол-во заказов по дням недели

-- Количество заказов по районам
/*CREATE PROCEDURE #CountOrdersByDistrict AS
BEGIN
	SELECT DISTINCT District AS 'Район', COUNT(*) AS 'Количество заказов на район' FROM DELIVERY
	GROUP BY District
END

EXECUTE #CountOrdersByDistrict*/

-- Самые востребованные товары по районам города
/*CREATE PROCEDURE #PopularDish AS
BEGIN
	SELECT DISTINCT Name_dish AS 'Наименование блюда', SUM(Count_dish) AS 'Количество заказов блюда' FROM DISH 
	GROUP BY Name_dish
	ORDER BY SUM(Count_dish) DESC
END

EXECUTE #PopularDish*/

-- Средний чек по месяцам
-- Кол-во выполненных заказов каждым курьером
-- Среднее время выполнения заказов курьерами
-- Кол-во клиентов
-- 50 самых активных клиентов (заказавших больше заказов)
-- Клиенты которые не сделали заказ
-- Время приготовления заказов (максимальное и минимальное)
