USE DreamHomeKlinduhov

GO
--1) Показать список имеющихся владельцев квартир и их объекты недвижимости для продажи. 
SELECT OWNER.FName, OWNER.LName, PROPERTY.City, PROPERTY.Street
FROM OWNER
INNER JOIN PROPERTY
ON OWNER.Owner_no = PROPERTY.Owner_no

/*SELECT * FROM OWNER, PROPERTY
WHERE OWNER.Owner_no = PROPERTY.Owner_no*/

--2) Вывести список объектов недвижимости, по которым заключены контракты.
SELECT *
FROM CONTRACT
INNER JOIN PROPERTY
ON CONTRACT.Property_no = PROPERTY.Property_no

/*SELECT PROPERTY.City AS 'Город', PROPERTY.Street AS 'Улица', CONTRACT.Date_Contract AS 'Дата контракта'
FROM PROPERTY
JOIN CONTRACT ON PROPERTY.Property_no = CONTRACT.Property_no*/

--3) Показать список просмотров квартир и их потенциальных покупателей.
SELECT *
FROM VIEWING
RIGHT JOIN BUYER
ON VIEWING.Buyer_no = BUYER.Buyer_no

/*SELECT * FROM VIEWING, BUYER
WHERE VIEWING.Buyer_no = BUYER.Buyer_no*/

--4) Вывести список покупателей и отделения, в которые они обращались.
SELECT *
FROM BUYER
LEFT JOIN BRANCH
ON BUYER.Branch_no = BRANCH.Branch_no

/*SELECT * FROM BUYER, BRANCH
WHERE BUYER.Branch_no = BRANCH.Branch_no*/

--5) Показать список отделений и список персонала.
SELECT *
FROM BRANCH
FULL OUTER JOIN STAFF
ON BRANCH.Branch_no = STAFF.Branch_no

/*SELECT * FROM BRANCH, STAFF
WHERE STAFF.Branch_no = BRANCH.Branch_no*/

--6) Вывести данные о покупателях, и отделениях, в которые они обратились. Использовать соединение во фразе Where.
SELECT * FROM BUYER, BRANCH
WHERE BUYER.Branch_no = BRANCH.Branch_no