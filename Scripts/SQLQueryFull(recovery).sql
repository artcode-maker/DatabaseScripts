set language 'English'
--DROP DATABASE DreamHomeKlinduhov
--GO
CREATE DATABASE DreamHomeKlinduhov
GO
USE DreamHomeKlinduhov
EXEC sp_addtype PhoneNumber, 'CHAR (17)', NULL
EXEC sp_addtype postcode, 'CHAR (6)', NULL 
EXEC sp_addtype member_no, 'SMALLINT'
EXEC sp_addtype shortstring, 'VARCHAR(20)'
GO

CREATE TABLE BRANCH
(
	Branch_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Postcode CHAR(12) NOT NULL,
	City CHAR(20) NOT NULL,
	Street VARCHAR(20) NOT NULL,
	House VARCHAR(10) NOT NULL,
	Btel_no PhoneNumber NOT NULL,
	Fax_no PhoneNumber NULL
)

GO

CREATE TABLE OWNER
(
	Owner_no member_no IDENTITY(1, 1) NOT NULL,
	FName shortstring NOT NULL,
	LName shortstring NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House NCHAR(6) NOT NULL,
	Flat SMALLINT NULL,
	Otel_no PhoneNumber NULL
)

GO

CREATE TABLE BUYER
(
	Buyer_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname shortstring NOT NULL,
	LName shortstring NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House NCHAR(6) NOT NULL,
	Flat SMALLINT NULL,
	Htel_no PhoneNumber NULL,
	Wtel_no PhoneNumber NULL,
	Prof_rooms TINYINT NOT NULL,
	Branch_no member_no NOT NULL,
	Max_Price MONEY NOT NULL
	CONSTRAINT FK_Branch_no FOREIGN KEY (Branch_no) REFERENCES BRANCH
	ON UPDATE CASCADE,
	CHECK (Htel_no IS NOT NULL OR Wtel_no IS NOT NULL)
)

GO

ALTER TABLE OWNER
ADD CONSTRAINT PK_Owner PRIMARY KEY
NONCLUSTERED(Owner_no)

GO

CREATE TABLE STAFF
(
	Staff_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname shortstring NOT NULL,
	LNAME shortstring NOT NULL,
	DOB DATETIME NOT NULL,
	SEX NVARCHAR(1) NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House shortstring NOT NULL,
	Flat INT NULL,
	STel_no PhoneNumber NULL,
	Date_Joined DATETIME,
	Position shortstring NOT NULL,
	Salary MONEY NOT NULL,
	Branch_no member_no NULL,
	FOREIGN KEY (Branch_no) REFERENCES BRANCH (Branch_no),
	CONSTRAINT CK_STAFF_SEX CHECK(SEX = 'ж' OR SEX = 'м')
)

GO

CREATE TABLE PROPERTY
(
	Property_no member_no NOT NULL PRIMARY KEY,
	Branch_no member_no NOT NULL,
	Staff_no member_no NOT NULL,
	Owner_no member_no NOT NULL,
	Date_registration DATETIME NOT NULL,
	Postcode postcode NOT NULL,
	City SHORTSTRING NOT NULL,
	Street SHORTSTRING NOT NULL,
	House SHORTSTRING NOT NULL,
	Flat INT NULL,
	Floor_type VARCHAR(3) NULL,
	Floor_n INT,
	Rooms INT NOT NULL,
	The_area SHORTSTRING NOT NULL,
	Balcony VARCHAR(5),
	Ptel PhoneNumber NULL,
	Selling_Price MONEY NOT NULL,
	FOREIGN KEY (Branch_no) REFERENCES BRANCH (Branch_no),
	FOREIGN KEY (Staff_no) REFERENCES STAFF (Staff_no),
	FOREIGN KEY (Owner_no) REFERENCES OWNER (Owner_no),
	CONSTRAINT CK_PROPERTY_Rooms CHECK(Rooms > 0 AND Rooms < 1000)
)

GO

ALTER TABLE PROPERTY
ADD CONSTRAINT FK_STAFF FOREIGN KEY (Staff_no) REFERENCES staff
ON UPDATE CASCADE


GO


CREATE TABLE VIEWING
(
	Property_no member_no NOT NULL,
	Buyer_no member_no NOT NULL,
	Date_View DATETIME NOT NULL,
	Comments VARCHAR(50),
	FOREIGN KEY (Property_no) REFERENCES PROPERTY (Property_no),
	FOREIGN KEY (Buyer_no) REFERENCES BUYER (Buyer_no),
	PRIMARY KEY(Property_no, Buyer_no)
)

GO

ALTER TABLE PROPERTY ADD CONSTRAINT DF_Ptel DEFAULT ('T') FOR Ptel

GO

CREATE INDEX INDEX_STAFF_Fname ON STAFF (FName)
CREATE INDEX INDEX_STAFF_Position ON STAFF (Position)
CREATE INDEX INDEX_VIEWING_Date_View ON VIEWING (Date_View)

GO

CREATE TABLE CONTRACT
(
	Contract_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Property_no member_no NOT NULL,
	Buyer_no member_no NOT NULL,
	Date_Contract DATETIME NOT NULL,
	Service_Cost MONEY,
	Notary VARCHAR(150) NOT NULL,
	FOREIGN KEY (Property_no) REFERENCES PROPERTY (Property_no),
	FOREIGN KEY (Buyer_no) REFERENCES BUYER (Buyer_no)
)

GO

INSERT INTO BRANCH (Postcode, City, Street, House, Btel_no, Fax_no)
VALUES (210009, 'Витебск', 'Замковая', '4/офис404', '8(01722)37-73-56', '37-73-58'),
(210033, 'Витебск', 'Суворова', '9/11', '8(01722)36-01-80', '33-25-23'),
(211440, 'Новополоцк', 'Молодежная', '18', '8(01744)57-31-29', '57-25-30'),
(211460, 'Россоны', 'Ленина', '3', '8(01759)25-55-20', NULL)

GO

INSERT INTO OWNER (LName, FName, City, Street, House, Flat, Otel_no)
VALUES ('Жерносек', 'Юрий', 'Витебск', 'Терешковой', '28/1', 7, '62-07-94'),
('Панкратова', 'Инна', 'Новополоцк', 'Парковая', '2б', 12, '57-12-48'),
('Амбражевич', 'Сергей', 'Витебск', 'Двинская', '5', 18, '52-14-89'),
('Поскрёбышева', 'Елена', 'Витебск', 'П.Бровки', '26/1', 40, '23-00-72(аб978)'),
('Титов', 'Николай', 'Витебск', 'Интернационалистов', '35', 187, '8(029)633-76-68'),
('Скребкова', 'Алла', 'Новополоцк', 'Молодёжная', '1', 22, '8(029)688-84-46'),
('Николаев', 'Влад', 'Витебск', 'Фрунзе', '33', 214, '8(029)673-07-30'),
('Цалко', 'Сергей', 'Лепель', 'Ленина', '14/2', 4, '25-17-90'),
('Цыркунова', 'Наталья', 'Россоны', 'Цветочная', '90', 15, '26-32-48'),
('Яковлев', 'Андрей', 'Витебск', 'Лазо', '65', NULL, '21-72-25')


GO

INSERT INTO BUYER (LName, Fname, City, Street, House, Flat, Htel_no, Wtel_no, Prof_rooms, Max_Price, Branch_no)
VALUES ('Невердасов', 'Виктор', 'Витебск', 'Московский пр-т', '16/4', 117, '62-08-19', '36-40-80', 2, 110000, 2),
('Кассап', 'Светлана', 'Новополоцк', 'Гайдара', '17а', 4, '57-12-48', NULL, 1, 78000, 3),
('Орлов', 'Александр', 'Минск', 'Либнехта', '93', 15, '8(017)286-13-21', NULL, 3, 14500, 1),
('Сафронова', 'Светлана', 'Витебск', 'пр-т Победы', '3/1', 324, '8(029)661-07-30', '22-67-94', 2, 60000, 4),
('Окорков', 'Вадим', 'Минск', 'Лермонтова', '35', 187, NULL, '8(017)224-84-24', 5, 300000, 1),
('Семёнов', 'Вячеслав', 'Витебск', 'Замковая', '4', 13, '23-00-72(аб964)', NULL, 2, 10500, 1),
('Краснова', 'Жанна', 'Витебск', 'Клиническая', '104', NULL, NULL, '23-50-70', 1, 90000, 2),
('Будда', 'Елена', 'Лепель', 'Ленина', '3', 5, '62-08-19', NULL, 4, 200000, 3),
('Боровая', 'Наталья', 'Орша', 'Смоленская', '12/4', 26, '26-32-48', NULL, 2, 140000, 2),
('Алипов', 'Игорь', 'Витебск', 'Московский пр-т', '22', 4, '21-72-25', NULL, 3, 150000, 2)


GO

INSERT INTO STAFF (LName, Fname, DOB, Sex, City, Street, House, Flat, STel_no, Date_Joined, Position, Salary, Branch_no)
VALUES ('Батуркин', 'Александр', CONVERT(DATETIME, '10.17.1968'), 'м', 'Новополоцк', 'Парковая', '5', 13, '23-79-77', CONVERT(DATETIME, '01.01.2001'), 'менеджер', 2500000, 3),
('Чубаро', 'Наталья', CONVERT(DATETIME, '05.05.1972'), 'ж', 'Витебск', 'Чкалова', '21/1', 12, '8(029)662-47-32', CONVERT(DATETIME, '02.10.2002'), 'торговый агент', 1800000, 1),
('Коваленко', 'Светлана', CONVERT(DATETIME, '02.01.1970'), 'ж',  'Витебск', 'Чкалова', '24', 49, '62-51-23', CONVERT(DATETIME, '01.15.2001'), 'менеджер', 2500000, 3),
('Логинов', 'Вадим', CONVERT(DATETIME, '09.09.1967'), 'м', 'Витебск', 'Чкалова', '41/2', 96, '23-06-73', CONVERT(DATETIME, '09.02.1999'), 'директор', 3000000, 1),
('Суворов', 'Виталий', CONVERT(DATETIME, '11.07.1965'), 'м', 'Новополоцк', 'Школьная', '47/1', 157, '22-29-03', CONVERT(DATETIME, '02.01.1999'), 'торговый агент', 1800000, 3),
('Жарков', 'Герман', CONVERT(DATETIME, '11.05.1969'), 'м', 'Витебск', 'Гагарина', '31', 28, '63-43-98', CONVERT(DATETIME, '10.02.2001'), 'менеджер', 2800000, 2),
('Ганущенко', 'Галина', CONVERT(DATETIME, '11.05.1969'), 'ж', 'Витебск', 'Лазо', '90/1', 54, '62-43-64', CONVERT(DATETIME, '11.03.2004'), 'торговый агент', 1800000, 2),
('Сотникова', 'Ольга', CONVERT(DATETIME, '12.07.1967'), 'ж', 'Полоцк', 'Вокзальная', '7', NULL, NULL, CONVERT(DATETIME, '02.02.2002'), 'маклер', 1000000, 3),
('Янчиленко', 'Сергей', CONVERT(DATETIME, '02.28.1970'), 'м', 'Россоны', 'Ленина', '28/2', 25, NULL, CONVERT(DATETIME, '05.17.2005'), 'торговый агент', 1500000, 4)

GO

INSERT INTO PROPERTY (Property_no, Date_registration, Postcode, City, Street, House, Flat, Floor_type, Floor_n, Rooms, The_area, Balcony, Ptel, Selling_Price, Branch_no, Staff_no, Owner_no)
VALUES (3000, CONVERT(DATETIME, '05-05-2018'), '210033', 'Витебск', 'Смоленская', '11', 57, '5П', 3, 1, '31/18/10', 'Б', 'T', 60000, 1, 3, 1),
(3001, CONVERT(DATETIME, '12.04.2018'), '210035', 'Витебск', 'Бровки', '11', 49, '9К', 9, 1, '37/21/7', 'Бз', NULL, 70000, 2, 3, 5),
(3002, CONVERT(DATETIME, '12.01.2018'), '210029', 'Витебск', 'Строителей', '23/2', 214, '12П', 2, 2, '81/29/9', 'Лз', 'T', 92000, 2, 6, 7),
(3003, CONVERT(DATETIME, '12.05.2018'), '210005', 'Витебск', 'Лазо', '11', 4, '3К', 3, 2, '65/40/7.6', '2Бз', NULL, 15000, 1, 2, 5),
(3004, CONVERT(DATETIME, '12.12.2018'), '211460', 'Россоны', 'Ленина', '32', 20, '5П', 5, 3, '68.4/44.3/9.81', '2Бз', 'T', 100000, 4, 8, 7),
(3005, CONVERT(DATETIME, '12.11.2018'), '211440', 'Новополоцк', 'Школьная', '11', 56, '9П', 3, 1, '36/18/8.2', 'Б', 'T', 75000, 3, 1, 6),
(3006, CONVERT(DATETIME, '12.09.2018'), '211440', 'Новополоцк', 'Молодёжная', '5', 14, '9П', 2, 2, '46/27/6.8', 'Лз', 'T', 60000, 3, 4, 3),
(3007, CONVERT(DATETIME, '12.06.2018'), '211180', 'Полоцк', 'Вокзальная', '5', 15, '5К', 5, 3, '65/38/7', 'Б', 'T', 80000, 3, 7, 2),
(3008, CONVERT(DATETIME, '01.11.2018'), '211460', 'Россоны', 'Советская', '17', 1, '5К',1, 3, '65/38/7', NULL, 'T', 47500, 4, 8, 7)

GO

INSERT INTO VIEWING (Date_View, Comments, Property_no, Buyer_no)
VALUES 
(CONVERT(DATETIME, '01.17.2019'), 'Согласен', 3002, 1),
(CONVERT(DATETIME, '01.17.2019'), 'Согласен', 3003, 1),
(CONVERT(DATETIME, '01.17.2019'), 'не согласен', 3002, 4),
(CONVERT(DATETIME, '01.17.2019'), 'Согласен', 3005, 2),
(CONVERT(DATETIME, '01.17.2019'), 'требует ремонта', 3001, 7)

GO

INSERT INTO CONTRACT (Property_no, Buyer_no, Date_Contract, Service_Cost, Notary)
VALUES 
(3002, 1, CONVERT(DATETIME, '05.10.2019'), 10000, 'Нотариальная контора Октябрьского района г.Витебска'),
(3003, 1, CONVERT(DATETIME, '03.14.2019'), 15000, 'Нотариальная контора Советского района г.Витебска'),
(3005, 2, CONVERT(DATETIME, '01.17.2019'), 80000, 'Нотариальная контора г.Новополоцка'),
(3004, 3, CONVERT(DATETIME, '03.11.2019'), 35000, 'Нотариальная контора г.Россоны'),
(3008, 3, CONVERT(DATETIME, '05.20.2019'), 44000, 'Нотариальная контора г.Россоны')

GO

SELECT *
INTO BUYER_1 FROM BUYER
WHERE City = 'Витебск';

GO

SELECT *
INTO BUYER_2 FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM CONTRACT)

GO

DELETE FROM OWNER
WHERE Owner_no = 10

GO

UPDATE PROPERTY
SET Selling_Price = Selling_Price * 0.98
WHERE Ptel IS NULL

GO

--1) Выбрать список сотрудников (Фамилия, Имя, Дата приема на работу и оклад). 
SELECT Fname, LNAME, Date_Joined, Salary
FROM STAFF

--2) Выбрать список отделений и их номера телефонов. 
SELECT Branch_no, Btel_no
FROM BRANCH

--3) Выбрать список городов и улиц, где продаются объекты недвижимости, используя псевдоним.
SELECT ListCity.City 'Город', ListCity.Street 'Улица'
FROM PROPERTY AS ListCity

--4) Выбрать все информацию о покупателях.
SELECT *
FROM BUYER

--5) Просмотреть даты заключения договоров и стоимость услуг, используя псевдоним.
SELECT Date_Contract 'Дата договора', Service_Cost 'Стоимость услуг'
FROM CONTRACT

--6) Вывести все объекты недвижимости для продажи в г. Витебске. 
SELECT *
FROM PROPERTY
WHERE (City = 'Витебск')

--7) Вывести все объекты недвижимости для продажи, у которых название улицы заканчивается на -ая.
SELECT *
FROM PROPERTY
WHERE Street LIKE '%ая'

--8) Выбрать перечень адресов трехкомнатных квартир, предлагаемых для продажи в Полоцке.
SELECT *
FROM PROPERTY
WHERE City = 'Полоцк' AND Rooms = 3

--9) Вывести дау приема на работу сотрудников отделения №4.
SELECT Date_Joined 'Дата приема'
FROM STAFF
WHERE Branch_no = 4

--10) Выбрать перечень объектов собственности, принадлежащих каждому владельцу (указать Имя и Фамилию владельца).
SELECT DISTINCT OWNER.FName 'Имя', OWNER.LName 'Фамилия', PROPERTY.Property_no 'Номер недвижимости'
FROM OWNER, PROPERTY
WHERE PROPERTY.Owner_no = OWNER.Owner_no

--11) Показать список отделений компании, которые предлагают трехкомнатные квартиры c телефонами.
SELECT *
FROM PROPERTY
WHERE Rooms = 3 AND Ptel IS NOT NULL

--12) Показать список владельцев квартир в г. Новополоцк, отсортировав в алфавитном порядке.
SELECT *
FROM OWNER
WHERE City = 'Новополоцк'
ORDER BY LName ASC

--13) Выбрать объекты недвижимости, отсортировав по датам осмотра по убыванию.
SELECT *
FROM VIEWING
ORDER BY Date_View DESC

--14) Отобразить персонал компании, отсортировав по фамилии по возрастанию, и по имени по убыванию.
SELECT *
FROM STAFF
ORDER BY Fname ASC, Lname DESC

--15) Отобразить список договоров на покупку, название нотариальной конторы и владельца квартиры (использовать псевдонимы). Отсортировать по названию нотариальной конторы.
SELECT CONTRACT.Contract_no 'Номер договора', CONTRACT.Notary 'Нотариальная контора', OWNER.FName
FROM CONTRACT, OWNER, PROPERTY
WHERE (CONTRACT.Property_no = PROPERTY.Property_no) AND (PROPERTY.Owner_no = OWNER.Owner_no)
ORDER BY CONTRACT.Notary