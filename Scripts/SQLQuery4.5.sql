USE DreamHomeKlinduhov

--С помощью View Designer создать запрос: Вывести список отделений, персонала и объектов недвижимости в г. Минск, цена которых ниже заданной. Отсортировать объекты недвижимости по дате заключения контракта.  
SELECT        STAFF.Fname AS Expr1, STAFF.Staff_no, BRANCH.Branch_no, PROPERTY.Property_no, PROPERTY.Selling_Price, CONTRACT.Date_Contract
FROM            BRANCH INNER JOIN
                         PROPERTY ON BRANCH.Branch_no = PROPERTY.Branch_no INNER JOIN
                         STAFF ON BRANCH.Branch_no = STAFF.Branch_no AND PROPERTY.Staff_no = STAFF.Staff_no AND PROPERTY.Staff_no = STAFF.Staff_no INNER JOIN
                         CONTRACT ON PROPERTY.Property_no = CONTRACT.Property_no
WHERE        (PROPERTY.Selling_Price < 100000)
ORDER BY CONTRACT.Date_Contract

--1) Вывести адреса квартир, осмотренных покупателями, у которых в поле Comment занесено значение ‘требует ремонта’.
SELECT * FROM VIEWING
WHERE Comments = 'требует ремонта'

--2) Список трехкомнатных квартир в Витебске площадью не менее 60 метров, расположенных на втором-четвертом этажах, цена которых не превышает 100000$.
SELECT * FROM PROPERTY
WHERE (City = 'Витебск' AND CAST(LEFT(The_area, 2) AS INT) >= 60 AND Floor_n >= 2 AND Floor_n <= 4 AND Selling_Price <= 100000) --char - площадь, нужна какая-то фнукция

-- 3) Список однокомнатных квартир в Витебске, у которых площадь кухни не менее 10 метров.
/*SELECT * FROM PROPERTY
WHERE (City = 'Витебск' AND CAST(RIGHT(The_area, 1) AS INT) < 10 AND Rooms = 1)*/

--4) Перечень квартир, проданных каждым агентом за последний месяц (квартира считается проданной, если в поле Comments таблицы VIEWING занесено значение ‘согласен’)??????
SELECT VIEWING.Property_no, LNAME FROM VIEWING, STAFF
WHERE Comments LIKE '_огласен' AND DATEDIFF(MONTH, Date_View, GETDATE()) < 25 AND Staff_no IN (SELECT Staff_no FROM BRANCH, PROPERTY WHERE PROPERTY.Branch_no = BRANCH.Branch_no)

--5) Среднюю заработную плату сотрудников в каждом из отделений.
SELECT AVG(Salary), STAFF.Branch_no FROM STAFF LEFT JOIN BRANCH ON STAFF.Branch_no = BRANCH.Branch_no
GROUP BY STAFF.Branch_no

--6) Среднюю цену трехкомнатных квартир с балконами.
SELECT AVG(Selling_Price) FROM PROPERTY
WHERE (Rooms = 3 AND Balcony IS NOT NULL)

--7) Вывести количество квартир, выставленных на продажу.
SELECT COUNT(Property_no) FROM PROPERTY

--8) Вывести количество квартир, выставленных на продажу в каждом городе.
SELECT COUNT(City), City FROM PROPERTY
GROUP BY City

--9) Определить, сколько однокомнатных, двухкомнатных, трехкомнатных и т.д. квартир выставлено на продажу.
SELECT COUNT(Rooms), Rooms FROM PROPERTY
WHERE Rooms = 1 OR Rooms = 2 OR Rooms = 3
GROUP BY Rooms

--10) Количество однокомнатных квартир, цены которых не превышают средней цены однокомнатной квартиры.
SELECT COUNT(*) AS 'Количество квартир', Selling_Price FROM PROPERTY
WHERE Rooms = 1 AND ((SELECT AVG(Selling_Price) FROM PROPERTY WHERE Rooms = 1) > Selling_Price)
GROUP BY Selling_Price

--11) Найти самую дешевую однокомнатную квартиру.
SELECT MIN(Selling_Price) FROM PROPERTY WHERE Rooms = 1

--12) Вывести количество квартир, проданных каждым агентом.
SELECT COUNT(PROPERTY.Property_no) AS 'количество проданных квартир', STAFF.LNAME FROM CONTRACT, PROPERTY, STAFF
WHERE CONTRACT.Property_no = PROPERTY.Property_no AND STAFF.Staff_no = PROPERTY.Staff_no
GROUP BY STAFF.LNAME

--13) Вывести список агентов, у которых один и тот же объект осматривался более одного раза.
SELECT COUNT(VIEWING.Property_no), STAFF.LNAME FROM VIEWING, PROPERTY, STAFF
WHERE VIEWING.Property_no = PROPERTY.Property_no AND STAFF.Staff_no = PROPERTY.Staff_no
GROUP BY STAFF.LNAME
HAVING COUNT(VIEWING.Property_no) > 1

--14) Вывести данные сотрудников компании, чья заработная плата выше средней заработной платы сотрудников отделения, в котором он работает.
SELECT * FROM STAFF WHERE Salary > ALL(SELECT AVG(Salary) FROM STAFF, BRANCH WHERE BRANCH.Branch_no = STAFF.Branch_no GROUP BY BRANCH.Branch_no)

--15) Вывести все варианты объектов недвижимости из таблицы Property, удовлетворяющие требованиям каждого покупателя.
SELECT BUYER.LName, PROPERTY.City, BUYER.Max_Price, PROPERTY.Selling_Price
FROM PROPERTY INNER JOIN BRANCH 
ON PROPERTY.Branch_no = BRANCH.Branch_no INNER JOIN BUYER 
ON BRANCH.Branch_no = BUYER.Branch_no AND PROPERTY.Selling_Price <= BUYER.Max_Price

--16) Повысить на 10% зарплату агентов, продавших не менее одной квартиры за последний месяц.
UPDATE STAFF
SET Salary = Salary * 1.1
WHERE STAFF.Staff_no = ANY(SELECT Staff_no FROM PROPERTY WHERE Property_no = ANY(SELECT Property_no FROM CONTRACT WHERE DATEDIFF(MONTH, Date_Contract, GETDATE()) <= 1))

--17) С помощью команды UPDATE уменьшить на 10% цены однокомнатных квартир, которые не были проданы в течение года с момента регистрации.
UPDATE PROPERTY
SET Selling_Price = Selling_Price * 1.1
WHERE Property_no IN (SELECT Property_no FROM PROPERTY WHERE DATEDIFF(MONTH, Date_registration, GETDATE()) >= 12)

--18) Таблица PROPERTY_1 служит для хранения данных об объектах собственности уже выбранных покупателями 
--(находятся в таблице VIEWING и содержат значение “согласен” в поле Comments). 
--С помощью команды INSERT вставить данные об этих квартирах в таблицу PROPERTY_1.
GO
CREATE TABLE PROPERTY_1
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
	Ptel PhoneNumber DEFAULT ('T'),
	Selling_Price MONEY NOT NULL,
	FOREIGN KEY (Branch_no) REFERENCES BRANCH (Branch_no),
	FOREIGN KEY (Staff_no) REFERENCES STAFF (Staff_no),
	FOREIGN KEY (Owner_no) REFERENCES OWNER (Owner_no)
)
GO

INSERT INTO PROPERTY_1 (Property_no, Branch_no, Staff_no, Owner_no, Date_registration, Postcode, City, Street, House, Flat, Floor_type, Floor_n, Rooms, The_area, Balcony, Ptel, Selling_Price)
VALUES (
(SELECT Property_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Branch_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Staff_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Owner_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Date_registration FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Postcode FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT City FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Street FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT House FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Flat FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Floor_type FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Floor_n FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Rooms FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT The_area FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Balcony FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Ptel FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')),
(SELECT Selling_Price FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')))
--SELECT * FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')