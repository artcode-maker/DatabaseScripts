USE DreamHomeKlinduhov
set language 'English'
GO

--1. �������� ��������� ��� ������ ������� ����������� ��������� ��� �������� ���������
/*CREATE PROCEDURE #GetSalary @Branch_no SMALLINT AS
BEGIN
	SELECT * FROM STAFF
	WHERE STAFF.Branch_no = @Branch_no
END

EXECUTE #GetSalary 2*/

--2. ������� ��������� ��� ��������� ���������� ����� ���������� ������ � ��� ������, ���� �� 
--��� ��������� ���� �� ���� ������ ������������� � ������� Property (����� ���������� � ������� 
--��������� ���������� ����� ���������� � ��������� ��� ���������).
/*CREATE PROCEDURE #UpperSalaryByStaffId @Staff_no SMALLINT, @Percent FLOAT AS
BEGIN
	UPDATE STAFF SET Salary = Salary * @Percent
	WHERE STAFF.Staff_no IN (SELECT Staff_no FROM PROPERTY) AND STAFF.Staff_no = @Staff_no
END

EXECUTE #UpperSalaryByStaffId 4, 1.1*/

--3. �������� �������� ��������� ��� ���������� ��� �������� ������������� (��������� ���� �� �������� �������).
/*CREATE PROCEDURE #IndexPrice @UpPercentPrice FLOAT AS
BEGIN
	UPDATE PROPERTY SET Selling_Price = Selling_Price * @UpPercentPrice
END

EXECUTE #IndexPrice 1.1*/

--4. �������� �������� ��������� ��� ������ ������ �������� �������������, ������������������ � 
--������� PROPERTY �� �������� ��� �������� ����.
/*CREATE PROCEDURE #ListProperty @DateReg VARCHAR(20) AS
BEGIN
	SET @DateReg = CONVERT(DATETIME, @DateReg)
	SELECT * FROM PROPERTY
	WHERE Date_registration = TRY_CONVERT(DATETIME, @DateReg)
END

EXECUTE #ListProperty '11.12.2018'*/

--5. �������� �������� ��������� ��� �������� ���������� ��������, ��������� ������������ ����������� 
--(� ��������� ���������� ����� ����������).
/*CREATE PROCEDURE #CountStaffSells @Staff_no SMALLINT AS
BEGIN
	SELECT COUNT(CONTRACT.Property_no) AS '���������� ��������� ��������'
	FROM CONTRACT, PROPERTY
	WHERE PROPERTY.Property_no = CONTRACT.Property_no AND PROPERTY.Staff_no = @Staff_no
END

EXECUTE #CountStaffSells 1*/

--6. �������� ��������� ��� ������ �������� �������������, ��������������� ����������� ���������� 
--(� ��������� �������� ���������� ���������� � ���� ��������� ����������: ���������� ������, ����, ����� �������).
/*CREATE PROCEDURE #ChooseProperty @Rooms INT, @Floor_n INT, @The_area VARCHAR(20) AS
BEGIN
	SELECT * FROM PROPERTY
	WHERE Rooms = @Rooms AND Floor_n = @Floor_n AND The_area LIKE @The_area + '/%'
END

EXECUTE #ChooseProperty 3, 1, '65'*/

--7. �������� ��������� ��� ��������� �� �������� ��� �������� ������� ���������� ����� ��� �����������,
-- ������� ������� ������������ ���������� �������� ������������� � ����� ���������. 
--������������� ����� ������ �����������, ���������� ����� ������� ���� ��������.
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
