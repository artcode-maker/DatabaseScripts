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
	SEX BIT NOT NULL, -- 1 (���), 0 (���)
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
VALUES ('���������', '����', '�����', '�����������', '��������', '5', 13, '23-79-77'),
('������', '������', '�����', '���������', '�������', '21/1', 12, '8(029)662-47-32'),
('����', '�������', '�����', '����������', '�������', '41/2', 96, '23-06-73'),
('����', '���������', '�����', '�����������', '��������', '47/1', 157, '22-29-03'),
('������', '�����', '�����', '���������', '��������', '31', 28, '63-43-98'),
('�����', '���������', '�����', '������������', '����', '90/1', 54, '62-43-64')
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
VALUES ('����', 7),
('�����', 5),
('���� ����', 3),
('�����', 2),
('������ ������', 3),
('��������', 4),
('����', 2),
('�����', 3),
('���� ����', 10),
('�����', 5),
('������ ������', 1),
('��������', 6),
('����', 4),
('�����', 11),
('���� ����', 3),
('�����', 4),
('������ ������', 1),
('��������', 6),
('����', 10),
('�����', 2),
('���� ����', 8),
('�����', 1),
('������ ������', 4),
('��������', 7),
('����', 2),
('�����', 3),
('���� ����', 2),
('�����', 5),
('������ ������', 1),
('��������', 2),
('����', 4),
('�����', 8),
('���� ����', 2),
('�����', 3),
('������ ������', 1),
('��������', 3)
GO
INSERT INTO BEVERAGE (Name_bevr, Count_bevr)
VALUES ('����', 4),
('������', 2),
('�����', 2),
('�������', 3),
('������', 2),
('�������', 2),
('����', 2),
('������', 2),
('�����', 2),
(NULL, NULL),
('������', 3),
('�������', 2),
('����', 5),
('������', 2),
(NULL, NULL),
('�������', 3),
('������', 4),
('�������', 3),
('����', 1),
('������', 2),
('�����', 1),
('�������', 2),
('������', 1),
('�������', 2),
('����', 3),
('������', 1),
('�����', 2),
(NULL, NULL),
('������', 1),
('�������', 2),
('����', 5),
('������', 2),
(NULL, NULL),
('�������', 2),
('������', 1),
('�������', 3)
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
VALUES ('��������', '���������', CONVERT(DATETIME, '10.17.1968'), 1, '����������', '��������', '5', 13, '23-79-77', CONVERT(DATETIME, '01.01.2001'), 2500000),
('������', '�������', CONVERT(DATETIME, '05.05.1972'), 0, '�������', '�������', '21/1', 12, '8(029)662-47-32', CONVERT(DATETIME, '02.10.2002'), 1800000),
('���������', '��������', CONVERT(DATETIME, '02.01.1970'), 0,  '�������', '�������', '24', 49, '62-51-23', CONVERT(DATETIME, '01.15.2001'), 2500000),
('�������', '�����', CONVERT(DATETIME, '09.09.1967'), 1, '�������', '�������', '41/2', 96, '23-06-73', CONVERT(DATETIME, '09.02.1999'), 3000000),
('�������', '�������', CONVERT(DATETIME, '11.07.1965'), 1, '����������', '��������', '47/1', 157, '22-29-03', CONVERT(DATETIME, '02.01.1999'), 1800000),
('������', '������', CONVERT(DATETIME, '11.05.1969'), 1, '�������', '��������', '31', 28, '63-43-98', CONVERT(DATETIME, '10.02.2001'), 2800000),
('���������', '������', CONVERT(DATETIME, '11.05.1969'), 0, '�������', '����', '90/1', 54, '62-43-64', CONVERT(DATETIME, '11.03.2004'), 1800000),
('���������', '�����', CONVERT(DATETIME, '12.07.1967'), 0, '������', '����������', '7', NULL, NULL, CONVERT(DATETIME, '02.02.2002'), 1000000),
('���������', '������', CONVERT(DATETIME, '02.28.1970'), 1, '�������', '������', '28/2', 25, NULL, CONVERT(DATETIME, '05.17.2005'), 1500000)
GO
INSERT INTO DELIVERY (Datetime_delivery, District, Street, House, FLAT, Tel_no, Order_no, Courier_no)
VALUES (CONVERT(DATETIME, '01.02.2020 01:10:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '01.03.2020 01:20:22'), '���������', '�������', '21/1', 12, '8(029)662-47-32', 2, 2),
(CONVERT(DATETIME, '01.04.2020 01:25:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '01.06.2020 02:05:22'), '����������', '��������', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '01.07.2020 01:12:22'), '����������', '��������', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '01.09.2020 01:40:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '01.12.2020 01:30:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '01.15.2020 01:11:22'), '������������', '�������', '21/1', 12, '8(029)662-47-32', 2, 1),
(CONVERT(DATETIME, '01.18.2020 02:00:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '01.20.2020 02:11:22'), '�����������', '��������', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '01.24.2020 01:12:22'), '���������', '��������', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '01.29.2020 01:44:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '02.02.2020 01:32:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '02.03.2020 01:56:22'), '����������', '�������', '21/1', 12, '8(029)662-47-32', 2, 5),
(CONVERT(DATETIME, '02.06.2020 01:15:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '02.08.2020 01:14:22'), '�����������', '��������', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '02.09.2020 01:19:22'), '�����������', '��������', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '02.12.2020 01:21:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 1),
(CONVERT(DATETIME, '02.14.2020 01:28:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '02.16.2020 01:35:22'), '���������', '�������', '21/1', 12, '8(029)662-47-32', 2, 1),
(CONVERT(DATETIME, '02.17.2020 01:38:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '02.18.2020 01:19:22'), '����������', '��������', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '02.20.2020 01:43:22'), '����������', '��������', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '02.25.2020 01:41:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '02.27.2020 01:49:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '03.04.2020 01:47:22'), '������������', '�������', '21/1', 12, '8(029)662-47-32', 2, 6),
(CONVERT(DATETIME, '03.07.2020 01:56:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 3),
(CONVERT(DATETIME, '03.08.2020 01:22:22'), '�����������', '��������', '47/1', 157, '22-29-03', 4, 3),
(CONVERT(DATETIME, '03.10.2020 01:25:22'), '���������', '��������', '31', 28, '63-43-98', 5, 6),
(CONVERT(DATETIME, '03.12.2020 01:29:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 6),
(CONVERT(DATETIME, '03.15.2020 01:35:22'), '�����������', '��������', '5', 13, '23-79-77', 1, 1),
(CONVERT(DATETIME, '03.19.2020 01:39:22'), '����������', '�������', '21/1', 12, '8(029)662-47-32', 2, 5),
(CONVERT(DATETIME, '03.21.2020 01:36:22'), '����������', '�������', '41/2', 96, '23-06-73', 3, 2),
(CONVERT(DATETIME, '03.22.2020 01:27:22'), '�����������', '��������', '47/1', 157, '22-29-03', 4, 6),
(CONVERT(DATETIME, '03.24.2020 01:29:22'), '�����������', '��������', '31', 28, '63-43-98', 5, 5),
(CONVERT(DATETIME, '03.27.2020 01:17:22'), '������������', '����', '90/1', 54, '62-43-64', 6, 1)



-- ����� �������������� ������ �� ������� ������ 
-- �������� �� ������� � ��������� �������� 
-- ������������� ������� �� ������� ����� (�������, ���� ������,�) � ������� ������ 
-- ����� ������� ������, ���� ���������/������� ����� � �������������� 
-- ���������� ������� �� �������
-- ���-�� ������� �� �������
-- ���-�� ������� �� ���� ������

-- ���������� ������� �� �������
/*CREATE PROCEDURE #CountOrdersByDistrict AS
BEGIN
	SELECT DISTINCT District AS '�����', COUNT(*) AS '���������� ������� �� �����' FROM DELIVERY
	GROUP BY District
END

EXECUTE #CountOrdersByDistrict*/

-- ����� �������������� ������ �� ������� ������
/*CREATE PROCEDURE #PopularDish AS
BEGIN
	SELECT DISTINCT Name_dish AS '������������ �����', SUM(Count_dish) AS '���������� ������� �����' FROM DISH 
	GROUP BY Name_dish
	ORDER BY SUM(Count_dish) DESC
END

EXECUTE #PopularDish*/

-- ������� ��� �� �������
-- ���-�� ����������� ������� ������ ��������
-- ������� ����� ���������� ������� ���������
-- ���-�� ��������
-- 50 ����� �������� �������� (���������� ������ �������)
-- ������� ������� �� ������� �����
-- ����� ������������� ������� (������������ � �����������)
