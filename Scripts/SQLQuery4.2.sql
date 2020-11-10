USE DreamHomeKlinduhov

GO
--1) �������� ������ ��������� ���������� ������� � �� ������� ������������ ��� �������. 
SELECT OWNER.FName, OWNER.LName, PROPERTY.City, PROPERTY.Street
FROM OWNER
INNER JOIN PROPERTY
ON OWNER.Owner_no = PROPERTY.Owner_no

/*SELECT * FROM OWNER, PROPERTY
WHERE OWNER.Owner_no = PROPERTY.Owner_no*/

--2) ������� ������ �������� ������������, �� ������� ��������� ���������.
SELECT *
FROM CONTRACT
INNER JOIN PROPERTY
ON CONTRACT.Property_no = PROPERTY.Property_no

/*SELECT PROPERTY.City AS '�����', PROPERTY.Street AS '�����', CONTRACT.Date_Contract AS '���� ���������'
FROM PROPERTY
JOIN CONTRACT ON PROPERTY.Property_no = CONTRACT.Property_no*/

--3) �������� ������ ���������� ������� � �� ������������� �����������.
SELECT *
FROM VIEWING
RIGHT JOIN BUYER
ON VIEWING.Buyer_no = BUYER.Buyer_no

/*SELECT * FROM VIEWING, BUYER
WHERE VIEWING.Buyer_no = BUYER.Buyer_no*/

--4) ������� ������ ����������� � ���������, � ������� ��� ����������.
SELECT *
FROM BUYER
LEFT JOIN BRANCH
ON BUYER.Branch_no = BRANCH.Branch_no

/*SELECT * FROM BUYER, BRANCH
WHERE BUYER.Branch_no = BRANCH.Branch_no*/

--5) �������� ������ ��������� � ������ ���������.
SELECT *
FROM BRANCH
FULL OUTER JOIN STAFF
ON BRANCH.Branch_no = STAFF.Branch_no

/*SELECT * FROM BRANCH, STAFF
WHERE STAFF.Branch_no = BRANCH.Branch_no*/

--6) ������� ������ � �����������, � ����������, � ������� ��� ����������. ������������ ���������� �� ����� Where.
SELECT * FROM BUYER, BRANCH
WHERE BUYER.Branch_no = BRANCH.Branch_no