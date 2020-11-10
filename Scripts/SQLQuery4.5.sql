USE DreamHomeKlinduhov

--� ������� View Designer ������� ������: ������� ������ ���������, ��������� � �������� ������������ � �. �����, ���� ������� ���� ��������. ������������� ������� ������������ �� ���� ���������� ���������.  
SELECT        STAFF.Fname AS Expr1, STAFF.Staff_no, BRANCH.Branch_no, PROPERTY.Property_no, PROPERTY.Selling_Price, CONTRACT.Date_Contract
FROM            BRANCH INNER JOIN
                         PROPERTY ON BRANCH.Branch_no = PROPERTY.Branch_no INNER JOIN
                         STAFF ON BRANCH.Branch_no = STAFF.Branch_no AND PROPERTY.Staff_no = STAFF.Staff_no AND PROPERTY.Staff_no = STAFF.Staff_no INNER JOIN
                         CONTRACT ON PROPERTY.Property_no = CONTRACT.Property_no
WHERE        (PROPERTY.Selling_Price < 100000)
ORDER BY CONTRACT.Date_Contract

--1) ������� ������ �������, ����������� ������������, � ������� � ���� Comment �������� �������� �������� ��������.
SELECT * FROM VIEWING
WHERE Comments = '������� �������'

--2) ������ ������������� ������� � �������� �������� �� ����� 60 ������, ������������� �� ������-��������� ������, ���� ������� �� ��������� 100000$.
SELECT * FROM PROPERTY
WHERE (City = '�������' AND CAST(LEFT(The_area, 2) AS INT) >= 60 AND Floor_n >= 2 AND Floor_n <= 4 AND Selling_Price <= 100000) --char - �������, ����� �����-�� �������

-- 3) ������ ������������� ������� � ��������, � ������� ������� ����� �� ����� 10 ������.
/*SELECT * FROM PROPERTY
WHERE (City = '�������' AND CAST(RIGHT(The_area, 1) AS INT) < 10 AND Rooms = 1)*/

--4) �������� �������, ��������� ������ ������� �� ��������� ����� (�������� ��������� ���������, ���� � ���� Comments ������� VIEWING �������� �������� ���������)??????
SELECT VIEWING.Property_no, LNAME FROM VIEWING, STAFF
WHERE Comments LIKE '_�������' AND DATEDIFF(MONTH, Date_View, GETDATE()) < 25 AND Staff_no IN (SELECT Staff_no FROM BRANCH, PROPERTY WHERE PROPERTY.Branch_no = BRANCH.Branch_no)

--5) ������� ���������� ����� ����������� � ������ �� ���������.
SELECT AVG(Salary), STAFF.Branch_no FROM STAFF LEFT JOIN BRANCH ON STAFF.Branch_no = BRANCH.Branch_no
GROUP BY STAFF.Branch_no

--6) ������� ���� ������������� ������� � ���������.
SELECT AVG(Selling_Price) FROM PROPERTY
WHERE (Rooms = 3 AND Balcony IS NOT NULL)

--7) ������� ���������� �������, ������������ �� �������.
SELECT COUNT(Property_no) FROM PROPERTY

--8) ������� ���������� �������, ������������ �� ������� � ������ ������.
SELECT COUNT(City), City FROM PROPERTY
GROUP BY City

--9) ����������, ������� �������������, �������������, ������������� � �.�. ������� ���������� �� �������.
SELECT COUNT(Rooms), Rooms FROM PROPERTY
WHERE Rooms = 1 OR Rooms = 2 OR Rooms = 3
GROUP BY Rooms

--10) ���������� ������������� �������, ���� ������� �� ��������� ������� ���� ������������� ��������.
SELECT COUNT(*) AS '���������� �������', Selling_Price FROM PROPERTY
WHERE Rooms = 1 AND ((SELECT AVG(Selling_Price) FROM PROPERTY WHERE Rooms = 1) > Selling_Price)
GROUP BY Selling_Price

--11) ����� ����� ������� ������������� ��������.
SELECT MIN(Selling_Price) FROM PROPERTY WHERE Rooms = 1

--12) ������� ���������� �������, ��������� ������ �������.
SELECT COUNT(PROPERTY.Property_no) AS '���������� ��������� �������', STAFF.LNAME FROM CONTRACT, PROPERTY, STAFF
WHERE CONTRACT.Property_no = PROPERTY.Property_no AND STAFF.Staff_no = PROPERTY.Staff_no
GROUP BY STAFF.LNAME

--13) ������� ������ �������, � ������� ���� � ��� �� ������ ������������ ����� ������ ����.
SELECT COUNT(VIEWING.Property_no), STAFF.LNAME FROM VIEWING, PROPERTY, STAFF
WHERE VIEWING.Property_no = PROPERTY.Property_no AND STAFF.Staff_no = PROPERTY.Staff_no
GROUP BY STAFF.LNAME
HAVING COUNT(VIEWING.Property_no) > 1

--14) ������� ������ ����������� ��������, ��� ���������� ����� ���� ������� ���������� ����� ����������� ���������, � ������� �� ��������.
SELECT * FROM STAFF WHERE Salary > ALL(SELECT AVG(Salary) FROM STAFF, BRANCH WHERE BRANCH.Branch_no = STAFF.Branch_no GROUP BY BRANCH.Branch_no)

--15) ������� ��� �������� �������� ������������ �� ������� Property, ��������������� ����������� ������� ����������.
SELECT BUYER.LName, PROPERTY.City, BUYER.Max_Price, PROPERTY.Selling_Price
FROM PROPERTY INNER JOIN BRANCH 
ON PROPERTY.Branch_no = BRANCH.Branch_no INNER JOIN BUYER 
ON BRANCH.Branch_no = BUYER.Branch_no AND PROPERTY.Selling_Price <= BUYER.Max_Price

--16) �������� �� 10% �������� �������, ��������� �� ����� ����� �������� �� ��������� �����.
UPDATE STAFF
SET Salary = Salary * 1.1
WHERE STAFF.Staff_no = ANY(SELECT Staff_no FROM PROPERTY WHERE Property_no = ANY(SELECT Property_no FROM CONTRACT WHERE DATEDIFF(MONTH, Date_Contract, GETDATE()) <= 1))

--17) � ������� ������� UPDATE ��������� �� 10% ���� ������������� �������, ������� �� ���� ������� � ������� ���� � ������� �����������.
UPDATE PROPERTY
SET Selling_Price = Selling_Price * 1.1
WHERE Property_no IN (SELECT Property_no FROM PROPERTY WHERE DATEDIFF(MONTH, Date_registration, GETDATE()) >= 12)

--18) ������� PROPERTY_1 ������ ��� �������� ������ �� �������� ������������� ��� ��������� ������������ 
--(��������� � ������� VIEWING � �������� �������� ��������� � ���� Comments). 
--� ������� ������� INSERT �������� ������ �� ���� ��������� � ������� PROPERTY_1.
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
(SELECT Property_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Branch_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Staff_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Owner_no FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Date_registration FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Postcode FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT City FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Street FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT House FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Flat FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Floor_type FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Floor_n FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Rooms FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT The_area FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Balcony FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Ptel FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')),
(SELECT Selling_Price FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')))
--SELECT * FROM PROPERTY WHERE Property_no IN (SELECT Property_no FROM VIEWING WHERE Comments LIKE '_�������')