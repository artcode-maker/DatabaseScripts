USE DreamHomeKlinduhov

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
/*
GO

ALTER TABLE CONTRACT
ADD Notary shortstring NOT NULL DEFAULT 'Неизвестно'

GO*/

--15) Отобразить список договоров на покупку, название нотариальной конторы и владельца квартиры (использовать псевдонимы). Отсортировать по названию нотариальной конторы.
SELECT CONTRACT.Contract_no 'Номер договора', CONTRACT.Notary 'Нотариальная контора', OWNER.FName
FROM CONTRACT, OWNER, PROPERTY
WHERE (CONTRACT.Property_no = PROPERTY.Property_no) AND (PROPERTY.Owner_no = OWNER.Owner_no)
ORDER BY CONTRACT.Notary