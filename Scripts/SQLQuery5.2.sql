USE DreamHomeKlinduhov
set language 'English'
GO

--1. Создайте процедуру для вывода окладов сотрудников заданного как параметр отделения
/*CREATE PROCEDURE #GetSalary @Branch_no SMALLINT AS
BEGIN
	SELECT * FROM STAFF
	WHERE STAFF.Branch_no = @Branch_no
END

EXECUTE #GetSalary 2*/

--2. Создать процедуру для повышения заработной платы сотрудника только в том случае, если за 
--ним закреплен хотя бы один объект собственности в таблице Property (номер сотрудника и процент 
--повышения заработной платы передаются в процедуру как параметры).
/*CREATE PROCEDURE #UpperSalaryByStaffId @Staff_no SMALLINT, @Percent FLOAT AS
BEGIN
	UPDATE STAFF SET Salary = Salary * @Percent
	WHERE STAFF.Staff_no IN (SELECT Staff_no FROM PROPERTY) AND STAFF.Staff_no = @Staff_no
END

EXECUTE #UpperSalaryByStaffId 4, 1.1*/

--3. Создайте хранимую процедуру для индексации цен объектов собственности (увеличьте цену на заданный процент).
/*CREATE PROCEDURE #IndexPrice @UpPercentPrice FLOAT AS
BEGIN
	UPDATE PROPERTY SET Selling_Price = Selling_Price * @UpPercentPrice
END

EXECUTE #IndexPrice 1.1*/

--4. Создайте хранимую процедуру для вывода списка объектов собственности, зарегистрированных в 
--таблице PROPERTY на заданную как параметр дату.
/*CREATE PROCEDURE #ListProperty @DateReg VARCHAR(20) AS
BEGIN
	SET @DateReg = CONVERT(DATETIME, @DateReg)
	SELECT * FROM PROPERTY
	WHERE Date_registration = TRY_CONVERT(DATETIME, @DateReg)
END

EXECUTE #ListProperty '11.12.2018'*/

--5. Создайте хранимую процедуру для подсчета количества объектов, проданных определенным сотрудником 
--(в процедуру передается номер сотрудника).
/*CREATE PROCEDURE #CountStaffSells @Staff_no SMALLINT AS
BEGIN
	SELECT COUNT(CONTRACT.Property_no) AS 'Количество проданных объектов'
	FROM CONTRACT, PROPERTY
	WHERE PROPERTY.Property_no = CONTRACT.Property_no AND PROPERTY.Staff_no = @Staff_no
END

EXECUTE #CountStaffSells 1*/

--6. Создайте процедуру для выбора объектов собственности, удовлетворяющих требованиям покупателя 
--(в процедуру передать требования покупателя в виде следующих параметров: количество комнат, этаж, общую площадь).
/*CREATE PROCEDURE #ChooseProperty @Rooms INT, @Floor_n INT, @The_area VARCHAR(20) AS
BEGIN
	SELECT * FROM PROPERTY
	WHERE Rooms = @Rooms AND Floor_n = @Floor_n AND The_area LIKE @The_area + '/%'
END

EXECUTE #ChooseProperty 3, 1, '65'*/

--7. Создайте процедуру для повышения на заданный как параметр процент заработной платы тех сотрудников,
-- которые продали максимальное количество объектов собственности в своем отделении. 
--Предусмотрите вывод списка сотрудников, заработная плата которых была повышена.
CREATE PROCEDURE #UpperSalaryBestStaff @UpPercentSalary FLOAT AS
BEGIN
	DECLARE @MaxStaff SMALLINT = (SELECT TOP 1 STAFF.Staff_no/*, COUNT(PROPERTY.Staff_no) AS Staffs*/ 
		FROM CONTRACT, PROPERTY, BRANCH, STAFF 
		WHERE PROPERTY.Property_no = CONTRACT.Property_no AND PROPERTY.Staff_no = STAFF.Staff_no AND BRANCH.Branch_no = STAFF.Branch_no
		GROUP BY STAFF.Staff_no
		ORDER BY COUNT(PROPERTY.Staff_no) DESC)
	SELECT * FROM STAFF WHERE STAFF.Staff_no = @MaxStaff
	UPDATE STAFF SET Salary = Salary * @UpPercentSalary
		WHERE STAFF.Staff_no = @MaxStaff
	SELECT * FROM STAFF WHERE STAFF.Staff_no = @MaxStaff
END

EXECUTE #UpperSalaryBestStaff 1.1
