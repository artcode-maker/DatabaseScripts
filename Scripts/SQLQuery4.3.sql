USE DreamHomeKlinduhov
GO

--1) ���������� ������� �������� ����������� �� ������� �� ��������� ��������;
SELECT AVG(STAFF.Salary) AS '������� ��������', BRANCH.Branch_no AS '����� ���������'
FROM STAFF, BRANCH
WHERE BRANCH.Branch_no = STAFF.Branch_no
GROUP BY BRANCH.Branch_no

--2) �������� ���������� ������������� �������, ������������ � �������� � �������;
SELECT COUNT(*) AS '���������� �������', City AS '�����'
FROM PROPERTY
WHERE (PROPERTY.Rooms = 3)
GROUP BY PROPERTY.City
HAVING PROPERTY.City IN ('�������', '������')

--3) �������� ������ � ������ ��������� ���������, ������� ���������� ����� ����� ������������� ��������;
SELECT BRANCH.Branch_no AS '����� ���������', BRANCH.Btel_no AS '����� ��������'
FROM BRANCH, PROPERTY
WHERE BRANCH.Branch_no = PROPERTY.Branch_no AND PROPERTY.Rooms = 3
GROUP BY BRANCH.Branch_no, BRANCH.Btel_no
HAVING COUNT(PROPERTY.Rooms) > 1

--4) ���� ���������� ���������� ������� �������� �� 1 �������� 2019 ����;
SELECT TOP 1 CONTRACT.Date_Contract AS '���� ��������',
DATEDIFF(day, CONTRACT.Date_Contract, '2019-09-01 23:59:59.9999999') AS '���������� ����'
FROM CONTRACT
GROUP BY Date_Contract
ORDER BY CONTRACT.Date_Contract DESC

--5) ���������� ����������� �� ������� � ������ ����������;
SELECT COUNT(BUYER.Fname) AS '���������� �������', PROPERTY.City AS '�����'
FROM BUYER, PROPERTY, CONTRACT
WHERE (BUYER.Buyer_no = CONTRACT.Buyer_no) AND (CONTRACT.Property_no = PROPERTY.Property_no) AND BUYER.Fname = '��������'
GROUP BY PROPERTY.City

--6) ��������� ��������� ���� ��������� �������� ������������;
SELECT SUM(PROPERTY.Selling_Price) AS '���������'
FROM PROPERTY, CONTRACT
WHERE CONTRACT.Property_no = PROPERTY.Property_no

--7) ���������� ��������� �������, ������������ � ������� Branch;
SELECT DISTINCT BRANCH.City AS '������'
FROM BRANCH


-- ������

--8) ���������� ���������� ��������, ����������� � ������� ������� �� ����������� �������� c ������������� ��������� �� ��������;
SELECT COUNT(PROPERTY.Property_no) AS '���������� ��������', STAFF.Fname + ' ' + STAFF.LNAME AS '���', BRANCH.Branch_no AS '����� ������'
FROM PROPERTY, STAFF, BRANCH
WHERE (STAFF.Branch_no = BRANCH.Branch_no) AND (BRANCH.Branch_no = PROPERTY.Branch_no) AND (STAFF.Staff_no = PROPERTY.Staff_no)
GROUP BY STAFF.Fname, STAFF.LNAME, BRANCH.Branch_no
--HAVING STAFF.Staff_no = PROPERTY.Property_no
ORDER BY BRANCH.Branch_no DESC

--9) ����� ���������� � ���������� ��������� ���������� ���� ��������� �������;
SELECT TOP 1 STAFF.Staff_no AS '����� ����������', MAX(PROPERTY.Selling_Price) AS '������������ ���������'
FROM STAFF, CONTRACT, PROPERTY
WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no)
GROUP BY STAFF.Staff_no
ORDER BY MAX(PROPERTY.Selling_Price) DESC

--10) ������ �����������, ������� �� �������� ������ ��������� ������ ����� ������;
SELECT STAFF.Staff_no AS '����� ����������', COUNT(CONTRACT.Contract_no) AS '���������� ������'
FROM STAFF, CONTRACT, PROPERTY
WHERE (STAFF.Staff_no = PROPERTY.Staff_no) AND (PROPERTY.Property_no = CONTRACT.Property_no)
GROUP BY STAFF.Staff_no
HAVING COUNT(CONTRACT.Contract_no) <> 0

--11)  ������ �����������, ������� �� ��������� �� ����� ������.
SELECT STAFF.Staff_no AS '����� ����������', COUNT(CONTRACT.Contract_no) AS '���������� ������'
  FROM STAFF
  LEFT JOIN CONTRACT
  ON CONTRACT.Property_no IS NULL
GROUP BY STAFF.Staff_no
HAVING COUNT(CONTRACT.Property_no) = 0

--12) ����� �����, � ������� ���������� ��������� ���������� �����.
SELECT TOP 1 BRANCH.Branch_no AS '����� ������', SUM(STAFF.Salary) AS '��������'
FROM BRANCH, STAFF
WHERE (BRANCH.Branch_no = STAFF.Branch_no)
GROUP BY BRANCH.Branch_no
ORDER BY BRANCH.Branch_no ASC
