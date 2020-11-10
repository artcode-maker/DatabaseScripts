USE DreamHomeKlinduhov

--1. — помощью SQL запроса создайте представление, содержащее данные о количестве квартир, принадлежащих каждому из владельцев собственности.
--ѕредставление должно включать номер владельца, его данные и количество принадлежащих ему объектов.
CREATE VIEW OWNER_PROP
AS SELECT OWNER.Owner_no, OWNER.LName, COUNT(*) AS ' оличество'
FROM OWNER INNER JOIN PROPERTY ON PROPERTY.Owner_no= OWNER.Owner_no
GROUP BY OWNER.Owner_no, OWNER.LName

--2. — помощью конструктора создайте представление, содержащее данные о количестве однокомнатных, двухкомнатных и трехкомнатных квартир в таблице PROPETY.
CREATE VIEW PROP_FLAT
AS SELECT COUNT(*) ' оличество квартир', Rooms FROM PROPERTY
WHERE Rooms = 1 OR Rooms = 2 OR Rooms = 3
GROUP BY Rooms

--3. —оздайте представление, которое выводит покупателей, с которыми была заключена сделка о покупке квартиры в первом квартале.
CREATE VIEW BUYER_CONT
AS SELECT * FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM CONTRACT WHERE Date_Contract BETWEEN DATEFROMPARTS(2018, 01, 01) AND DATEFROMPARTS(2020, 03, 31))

--4.  — помощью SQL запроса создайте представление, которое выводит данные тех покупателей, которые осматривали квартиры не ранее 10 окт€бр€.
CREATE VIEW BUYER_VIEW
AS SELECT * FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM VIEWING WHERE Date_View BETWEEN DATEFROMPARTS(2018, 10, 10) AND GETDATE())
