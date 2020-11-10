USE DreamHomeKlinduhov
GO

--1) Вычисления средней зарплаты сотрудников по каждому из отделений компании;
SELECT AVG(STAFF.Salary) AS 'Средняя зарплата', BRANCH.Branch_no AS 'Номер отделения'
FROM STAFF, BRANCH
WHERE BRANCH.Branch_no = STAFF.Branch_no
GROUP BY BRANCH.Branch_no

--2) Подсчета количества трехкомнатных квартир, предлагаемых в Витебске и Полоцке;
SELECT COUNT(*) AS 'Количество квартир', City AS 'Город'
FROM PROPERTY
WHERE (PROPERTY.Rooms = 3)
GROUP BY PROPERTY.City
HAVING PROPERTY.City IN ('Витебск', 'Полоцк')

--3) Выведите список и номера телефонов отделений, которые предлагают более одной трехкомнатной квартиры;
SELECT BRANCH.Branch_no AS 'Номер отделения', BRANCH.Btel_no AS 'Номер телефона'
FROM BRANCH, PROPERTY
WHERE BRANCH.Branch_no = PROPERTY.Branch_no AND PROPERTY.Rooms = 3
GROUP BY BRANCH.Branch_no, BRANCH.Btel_no
HAVING COUNT(PROPERTY.Rooms) > 1

--4) Дата последнего оформления покупки квартиры до 1 сентября 2019 года;
SELECT TOP 1 CONTRACT.Date_Contract AS 'Дата договора',
DATEDIFF(day, CONTRACT.Date_Contract, '2019-09-01 23:59:59.9999999') AS 'Количество дней'
FROM CONTRACT
GROUP BY Date_Contract
ORDER BY CONTRACT.Date_Contract DESC

--5) Количество покупателей по городам с именем ‘Светлана’;
SELECT COUNT(BUYER.Fname) AS 'Количество Светлан', PROPERTY.City AS 'Город'
FROM BUYER, PROPERTY, CONTRACT
WHERE (BUYER.Buyer_no = CONTRACT.Buyer_no) AND (CONTRACT.Property_no = PROPERTY.Property_no) AND BUYER.Fname = 'Светлана'
GROUP BY PROPERTY.City

--6) Суммарная стоимость всех проданных объектов недвижимости;
SELECT SUM(PROPERTY.Selling_Price) AS 'Стоимость'
FROM PROPERTY, CONTRACT
WHERE CONTRACT.Property_no = PROPERTY.Property_no

--7) Количество различных городов, содержащихся в таблице Branch;
SELECT DISTINCT BRANCH.City AS 'Города'
FROM BRANCH


-- РЕШЕНЫ

--8) Определите количество объектов, находящихся в ведении каждого из сотрудников компании c упорядочением отделений по убыванию;
SELECT COUNT(PROPERTY.Property_no) AS 'Количество объектов', STAFF.Fname + ' ' + STAFF.LNAME AS 'ФИО', BRANCH.Branch_no AS 'Номер отдела'
FROM PROPERTY, STAFF, BRANCH
WHERE (STAFF.Branch_no = BRANCH.Branch_no) AND (BRANCH.Branch_no = PROPERTY.Branch_no) AND (STAFF.Staff_no = PROPERTY.Staff_no)
GROUP BY STAFF.Fname, STAFF.LNAME, BRANCH.Branch_no
--HAVING STAFF.Staff_no = PROPERTY.Property_no
ORDER BY BRANCH.Branch_no DESC

--9) Найти сотрудника с наибольшей суммарной стоимостью всех проданных квартир;
SELECT TOP 1 STAFF.Staff_no AS 'Номер сотрудника', MAX(PROPERTY.Selling_Price) AS 'Максимальная стоимость'
FROM STAFF, CONTRACT, PROPERTY
WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no)
GROUP BY STAFF.Staff_no
ORDER BY MAX(PROPERTY.Selling_Price) DESC

--10) Список сотрудников, которые за заданный период совершили больше одной сделки;
SELECT STAFF.Staff_no AS 'Номер сотрудника', COUNT(CONTRACT.Contract_no) AS 'Количество сделок'
FROM STAFF, CONTRACT, PROPERTY
WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no)
GROUP BY STAFF.Staff_no
HAVING COUNT(CONTRACT.Contract_no) <> 0

--11)  Список сотрудников, которые не совершили ни одной сделки.
SELECT STAFF.Staff_no AS 'Номер сотрудника', COUNT(CONTRACT.Contract_no) AS 'Количество сделок'
  FROM STAFF
  LEFT JOIN CONTRACT
  ON CONTRACT.Property_no IS NULL
GROUP BY STAFF.Staff_no
HAVING COUNT(CONTRACT.Property_no) = 0

--12) Найти отдел, в котором наименьшая суммарная заработная плата.
SELECT TOP 1 BRANCH.Branch_no AS 'Номер отдела', SUM(STAFF.Salary) AS 'Зарплата'
FROM BRANCH, STAFF
WHERE (BRANCH.Branch_no = STAFF.Branch_no)
GROUP BY BRANCH.Branch_no
ORDER BY BRANCH.Branch_no ASC
