USE DreamHomeKlinduhov
set language 'English'
GO
--1) �������� ������ �����������, �� �������� �� ��������� �� ���� �� �������� ������������.
SELECT STAFF.Staff_no AS '����� ����������', STAFF.Fname + ' ' + STAFF.LNAME AS '���'
FROM STAFF
WHERE Staff_no NOT IN (SELECT PROPERTY.Staff_no FROM PROPERTY)

--2) �������� ������ ������������� �������, ���� ������� ��������� ������� ���� ������������� ��������, ������������ ������:
SELECT PROPERTY.Property_no AS '����� ��������'
FROM PROPERTY
WHERE Rooms = 3 AND (PROPERTY.Selling_Price > (SELECT AVG(PROPERTY.Selling_Price) FROM PROPERTY))

--3) �������� ������ ���������� �������������, ��� ������� ���� ��������� � ������������ ����;
SELECT OWNER.Fname + ' ' + OWNER.LNAME AS '���'
FROM OWNER
WHERE Owner_no IN (SELECT PROPERTY.Owner_no FROM PROPERTY WHERE Property_no IN (SELECT VIEWING.Property_no FROM VIEWING WHERE Date_View = CONVERT(DATETIME, '01.17.2019')))

--4) �������� ������ �������� �������������, ������� ���� ��������� ������������ (������������ � ������� VIEWING);
SELECT * FROM PROPERTY
WHERE PROPERTY.Property_no IN (SELECT VIEWING.Property_no FROM VIEWING)

--5) ������� ���� �����������, ��� ���������� ����� ���� ���������� ����� ������ �� ����������� ��������� �������� ��� ������� 3;
SELECT * FROM STAFF
WHERE (Salary > (SELECT AVG(Salary) FROM STAFF WHERE STAFF.Branch_no = 3))

--6) �������� ������ �� �������� ������������� �� ������� PROPERTY ������ � ��� ������, ���� ���� �� ���� �� ��� ��� �������� ������������, � ���� �������� �������� �� ������������;
SELECT * FROM PROPERTY
WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')

--7) �������� �� 10% �������� �������, ��������� �� ����� ����� �������� �� ��������� �����.
UPDATE STAFF
SET Salary = Salary * 1.1
WHERE Staff_no IN (SELECT Staff_no FROM PROPERTY, CONTRACT WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no))

--8) � ������� ������� UPDATE ��������� �� 10% ���� ������������� �������, ������� �� ���� ������� � ������� ���� � ������� �����������.
UPDATE PROPERTY
SET Selling_Price = Selling_Price * 0.9
WHERE (SELECT DATEDIFF(MONTH, Date_registration, GETDATE())) > 11

--9) �������� ������ ������ ���������� ������������� (Owner_no), ������������ ��������� ������������� ������� ��� �������.
SELECT Owner_no FROM OWNER
WHERE Owner_no IN (SELECT Owner_no FROM PROPERTY WHERE Rooms = 3)

--10) �������� ���� ������ ����� (�������, ���), ���������� � �� � ������� �������������� (����������, ������������, ����������).
SELECT (STAFF.Fname + ' ' + STAFF.LNAME) AS '���' FROM STAFF
UNION
SELECT (BUYER.Fname + ' ' + BUYER.LNAME) FROM BUYER
UNION
SELECT (OWNER.Fname + ' ' + OWNER.LNAME) FROM OWNER

--11) ������� ������ ���������� �������� ������������, � ������� ������ ���������� � ����� ������� ������������ ���������. ������������ ������������� ��������.
SELECT OWNER.City, OWNER.Street, OWNER.House FROM OWNER
INTERSECT
SELECT PROPERTY.City, PROPERTY.Street, PROPERTY.House FROM PROPERTY

SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS '���' FROM OWNER
WHERE City IN (SELECT OWNER.City FROM OWNER
INTERSECT
SELECT PROPERTY.City FROM PROPERTY)

--12) ������� ������ ���������� �������� ������������, � ������� ������ ���������� � ����� ������� ������������ �� ���������. ������ �������� 2-�� ���������: ������������ ������������� ��������, ��������� Exist.
SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS '���' FROM OWNER
WHERE NOT EXISTS (SELECT OWNER.City FROM OWNER
INTERSECT
SELECT PROPERTY.City FROM PROPERTY)

SELECT (OWNER.Fname + ' ' + OWNER.LNAME) AS '���' FROM OWNER
WHERE NOT EXISTS (SELECT OWNER.City FROM OWNER
EXCEPT
SELECT PROPERTY.City FROM PROPERTY)

