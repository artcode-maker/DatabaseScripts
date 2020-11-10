USE DreamHomeKlinduhov

--1. � ������� SQL ������� �������� �������������, ���������� ������ � ���������� �������, ������������� ������� �� ���������� �������������.
--������������� ������ �������� ����� ���������, ��� ������ � ���������� ������������� ��� ��������.
CREATE VIEW OWNER_PROP
AS SELECT OWNER.Owner_no, OWNER.LName, COUNT(*) AS '����������'
FROM OWNER INNER JOIN PROPERTY ON PROPERTY.Owner_no= OWNER.Owner_no
GROUP BY OWNER.Owner_no, OWNER.LName

--2. � ������� ������������ �������� �������������, ���������� ������ � ���������� �������������, ������������� � ������������� ������� � ������� PROPETY.
CREATE VIEW PROP_FLAT
AS SELECT COUNT(*) '���������� �������', Rooms FROM PROPERTY
WHERE Rooms = 1 OR Rooms = 2 OR Rooms = 3
GROUP BY Rooms

--3. �������� �������������, ������� ������� �����������, � �������� ���� ��������� ������ � ������� �������� � ������ ��������.
CREATE VIEW BUYER_CONT
AS SELECT * FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM CONTRACT WHERE Date_Contract BETWEEN DATEFROMPARTS(2018, 01, 01) AND DATEFROMPARTS(2020, 03, 31))

--4.  � ������� SQL ������� �������� �������������, ������� ������� ������ ��� �����������, ������� ����������� �������� �� ����� 10 �������.
CREATE VIEW BUYER_VIEW
AS SELECT * FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM VIEWING WHERE Date_View BETWEEN DATEFROMPARTS(2018, 10, 10) AND GETDATE())
