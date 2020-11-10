USE DreamHomeKlinduhov
set language 'English'
GO
--1) Выведите список сотрудников, за которыми не закреплен ни один из объектов недвижимости.
SELECT STAFF.Staff_no AS 'Номер сотрудника', STAFF.Fname + ' ' + STAFF.LNAME AS 'ФИО'
FROM STAFF
WHERE Staff_no NOT IN (SELECT PROPERTY.Staff_no FROM PROPERTY)

--2) Выведите список трехкомнатных квартир, цена которых превышает среднюю цену трехкомнатной квартиры, используется запрос:
SELECT PROPERTY.Property_no AS 'Номер квартиры'
FROM PROPERTY
WHERE Rooms = 3 AND (PROPERTY.Selling_Price > (SELECT AVG(PROPERTY.Selling_Price) FROM PROPERTY))

--3) Выведите список владельцев собственности, чьи объекты были осмотрены в определенный день;
SELECT OWNER.Fname + ' ' + OWNER.LNAME AS 'ФИО'
FROM OWNER
WHERE Owner_no IN (SELECT PROPERTY.Owner_no FROM PROPERTY WHERE Property_no IN (SELECT VIEWING.Property_no FROM VIEWING WHERE Date_View = CONVERT(DATETIME, '01.17.2019')))

--4) Выведите список объектов собственности, которые были осмотрены покупателями (присутствуют в таблице VIEWING);
SELECT * FROM PROPERTY
WHERE PROPERTY.Property_no IN (SELECT VIEWING.Property_no FROM VIEWING)

--5) Найдите всех сотрудников, чья заработная плата выше заработной платы любого из сотрудников отделения компании под номером 3;
SELECT * FROM STAFF
WHERE (Salary > (SELECT AVG(Salary) FROM STAFF WHERE STAFF.Branch_no = 3))

--6) Выведите данные об объектах собственности из таблицы PROPERTY только в том случае, если хотя бы один из них был осмотрен покупателями, и было получено согласие на приобретение;
SELECT * FROM PROPERTY
WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_огласен')

--7) Повысить на 10% зарплату агентов, продавших не менее одной квартиры за последний месяц.
UPDATE STAFF
SET Salary = Salary * 1.1
WHERE Staff_no IN (SELECT Staff_no FROM PROPERTY, CONTRACT WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no))

--8) С помощью команды UPDATE уменьшить на 10% цены однокомнатных квартир, которые не были проданы в течение года с момента регистрации.
UPDATE PROPERTY
SET Selling_Price = Selling_Price * 0.9
WHERE (SELECT DATEDIFF(MONTH, Date_registration, GETDATE())) > 11

--9) Показать список шифров владельцев собственности (Owner_no), предлагающих несколько трехкомнатных квартир для продажи.
SELECT Owner_no FROM OWNER
WHERE Owner_no IN (SELECT Owner_no FROM PROPERTY WHERE Rooms = 3)

--10) Показать весь список людей (Фамилия, Имя), хранящихся в БД с типовой классификацией (‘сотрудник’, ‘покупатель’, ‘владелец’).
SELECT (STAFF.Fname + ' ' + STAFF.LNAME) AS 'ФИО' FROM STAFF
UNION
SELECT (BUYER.Fname + ' ' + BUYER.LNAME) FROM BUYER
UNION
SELECT (OWNER.Fname + ' ' + OWNER.LNAME) FROM OWNER

--11) Вывести список владельцев объектов недвижимости, у которых адреса проживания и адрес объекта недвижимости совпадают. Использовать множественные операции.
SELECT OWNER.City, OWNER.Street, OWNER.House FROM OWNER
INTERSECT
SELECT PROPERTY.City, PROPERTY.Street, PROPERTY.House FROM PROPERTY

SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS 'ФИО' FROM OWNER
WHERE City IN (SELECT OWNER.City FROM OWNER
INTERSECT
SELECT PROPERTY.City FROM PROPERTY)

--12) Вывести список владельцев объектов недвижимости, у которых адреса проживания и адрес объекта недвижимости не совпадают. Запрос написать 2-мя способами: использовать множественные операции, используя Exist.
SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS 'ФИО' FROM OWNER
WHERE NOT EXISTS (SELECT OWNER.City FROM OWNER
INTERSECT
SELECT PROPERTY.City FROM PROPERTY)

SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS 'ФИО' FROM OWNER
WHERE NOT EXISTS (SELECT OWNER.City FROM OWNER
EXCEPT
SELECT PROPERTY.City FROM PROPERTY)

