USE DreamHomeKlinduhov
set language 'English'
GO


--1. Создайте триггер для удаления из таблиц PROPERTY и VIEWING объекта собственности, 
--по которому заключается контракт. Выполнить удаление данных о владельце этого объекта. 
--Проверьте работоспособность триггера.
CREATE TRIGGER BUYER_DELETED_IF_CONTRACT
ON CONTRACT AFTER INSERT
AS
  declare @pr_no smallint;
  declare @own_no smallint;
  select @pr_no = Property_no FROM INSERTED;
  select @own_no = Owner_no FROM PROPERTY where  Property_no = @pr_no;
  DELETE FROM VIEWING WHERE Property_no = @pr_no; 
  DELETE FROM PROPERTY WHERE Property_no = @pr_no; 
  DELETE FROM OWNER WHERE Owner_no = @own_no; 

INSERT INTO CONTRACT (Property_no, Buyer_no, Date_Contract, Service_Cost, Notary)
VALUES 
(3006, 4, CONVERT(DATETIME, '05.10.2020'), 1000, 'Нотариальная контора Октябрьского района г.Витебска')

--2. Создайте триггер для вывода сообщения о превышении количества объектов собственности, 
--закрепленных за сотрудником, при вводе нового объекта в таблицу PROPERTY 
--(количество объектов не должно быть больше трех). Проверьте работоспособность триггера.
CREATE TRIGGER COUNT_OF_PROPERTY_FOR_STAFF
ON PROPERTY FOR INSERT
AS
DECLARE @CountStaff INT = (SELECT TOP 1 COUNT(Staff_no) FROM PROPERTY GROUP BY Staff_no ORDER BY COUNT(Staff_no) DESC)
DECLARE @NumStaff INT = (SELECT TOP 1 Staff_no FROM PROPERTY GROUP BY Staff_no ORDER BY COUNT(Staff_no) DESC)
IF 
	@CountStaff > 3
	ROLLBACK TRANSACTION
	PRINT 'ОШИБКА! Количество объектов не должно быть больше трех'


INSERT INTO PROPERTY (Property_no, Date_registration, Postcode, City, Street, House, Flat, Floor_type, Floor_n, Rooms, The_area, Balcony, Ptel, Selling_Price, Branch_no, Staff_no, Owner_no)
VALUES (3010, CONVERT(DATETIME, '01-03-2020'), '210033', 'Витебск', 'Могилёвская', '15', 52, '5П', 3, 1, '34/20/13', 'Б', 'T', 60000, 1, 3, 1)

--3. Создайте триггер для снижения стоимости квартиры на 5%, если в поле Comments таблицы VIEWING вводится значение “требует ремонта”.
--Проверьте работоспособность триггера.
CREATE TRIGGER PriceDropDown
ON VIEWING AFTER INSERT
AS
IF (SELECT Comments FROM INSERTED WHERE Comments = 'требует ремонта') = 'требует ремонта'
	UPDATE PROPERTY
	SET Selling_Price = Selling_Price * 0.95
	WHERE Property_no = (SELECT Property_no FROM INSERTED)
	PRINT 'Стоимость квартиры снижена на 5%'


INSERT INTO VIEWING (Date_View, Comments, Property_no, Buyer_no)
VALUES 
(CONVERT(DATETIME, '01.17.2020'), 'требует ремонта', 3008, 7)

--4. Создайте триггер для увеличения зарплаты сотрудника на 1% при каждой продаже
CREATE TRIGGER UpperSalary
ON CONTRACT AFTER INSERT
AS
UPDATE STAFF
SET Salary = Salary * 1.01
WHERE Staff_no = (SELECT Staff_no FROM PROPERTY WHERE Property_no = (SELECT Property_no FROM INSERTED))
PRINT 'З/П сотрудника увеличена на 1%'

INSERT INTO CONTRACT (Property_no, Buyer_no, Date_Contract, Service_Cost, Notary)
VALUES 
(3009, 1, CONVERT(DATETIME, '05.04.2020'), 10000, 'Нотариальная контора Октябрьского района г.Витебска')


--5. Создайте триггер для удаления всех подчиненных записей в таблице VIEWING при удалении записи из главной таблицы PROPERTY. 
--Если из таблицы PROPERTY удаляется какой-либо объект, то предварительно должны быть удалены все записи подчиненной таблицы VIEWING, 
--у которых значение поля Property_no соответствует значению поля Property_no удаляемой из таблицы PROPERTY записи.
CREATE TRIGGER DeleteViewing
ON PROPERTY FOR DELETE
AS
DELETE FROM VIEWING
WHERE Property_no = (SELECT Property_no FROM DELETED)
PRINT 'Объект из тадблицы VIEWING также удален'

DELETE FROM PROPERTY WHERE Property_no = 3001