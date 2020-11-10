USE DreamHomeKlinduhov

--1) ������� ������ ����������� (�������, ���, ���� ������ �� ������ � �����). 
SELECT Fname, LNAME, Date_Joined, Salary
FROM STAFF

--2) ������� ������ ��������� � �� ������ ���������. 
SELECT Branch_no, Btel_no
FROM BRANCH

--3) ������� ������ ������� � ����, ��� ��������� ������� ������������, ��������� ���������.
SELECT ListCity.City '�����', ListCity.Street '�����'
FROM PROPERTY AS ListCity

--4) ������� ��� ���������� � �����������.
SELECT *
FROM BUYER

--5) ����������� ���� ���������� ��������� � ��������� �����, ��������� ���������.
SELECT Date_Contract '���� ��������', Service_Cost '��������� �����'
FROM CONTRACT

--6) ������� ��� ������� ������������ ��� ������� � �. ��������. 
SELECT *
FROM PROPERTY
WHERE (City = '�������')

--7) ������� ��� ������� ������������ ��� �������, � ������� �������� ����� ������������� �� -��.
SELECT *
FROM PROPERTY
WHERE Street LIKE '%��'

--8) ������� �������� ������� ������������� �������, ������������ ��� ������� � �������.
SELECT *
FROM PROPERTY
WHERE City = '������' AND Rooms = 3

--9) ������� ��� ������ �� ������ ����������� ��������� �4.
SELECT Date_Joined '���� ������'
FROM STAFF
WHERE Branch_no = 4

--10) ������� �������� �������� �������������, ������������� ������� ��������� (������� ��� � ������� ���������).
SELECT DISTINCT OWNER.FName '���', OWNER.LName '�������', PROPERTY.Property_no '����� ������������'
FROM OWNER, PROPERTY
WHERE PROPERTY.Owner_no = OWNER.Owner_no

--11) �������� ������ ��������� ��������, ������� ���������� ������������� �������� c ����������.
SELECT *
FROM PROPERTY
WHERE Rooms = 3 AND Ptel IS NOT NULL

--12) �������� ������ ���������� ������� � �. ����������, ������������ � ���������� �������.
SELECT *
FROM OWNER
WHERE City = '����������'
ORDER BY LName ASC

--13) ������� ������� ������������, ������������ �� ����� ������� �� ��������.
SELECT *
FROM VIEWING
ORDER BY Date_View DESC

--14) ���������� �������� ��������, ������������ �� ������� �� �����������, � �� ����� �� ��������.
SELECT *
FROM STAFF
ORDER BY Fname ASC, Lname DESC
/*
GO

ALTER TABLE CONTRACT
ADD Notary shortstring NOT NULL DEFAULT '����������'

GO*/

--15) ���������� ������ ��������� �� �������, �������� ������������ ������� � ��������� �������� (������������ ����������). ������������� �� �������� ������������ �������.
SELECT CONTRACT.Contract_no '����� ��������', CONTRACT.Notary '������������ �������', OWNER.FName
FROM CONTRACT, OWNER, PROPERTY
WHERE (CONTRACT.Property_no = PROPERTY.Property_no) AND (PROPERTY.Owner_no = OWNER.Owner_no)
ORDER BY CONTRACT.Notary