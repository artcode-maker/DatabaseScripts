USE DreamHomeKlinduhov
set language 'English'
GO


--1. �������� ������� ��� �������� �� ������ PROPERTY � VIEWING ������� �������������, 
--�� �������� ����������� ��������. ��������� �������� ������ � ��������� ����� �������. 
--��������� ����������������� ��������.
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
(3006, 4, CONVERT(DATETIME, '05.10.2020'), 1000, '������������ ������� ������������ ������ �.��������')

--2. �������� ������� ��� ������ ��������� � ���������� ���������� �������� �������������, 
--������������ �� �����������, ��� ����� ������ ������� � ������� PROPERTY 
--(���������� �������� �� ������ ���� ������ ����). ��������� ����������������� ��������.
CREATE TRIGGER COUNT_OF_PROPERTY_FOR_STAFF
ON PROPERTY FOR INSERT
AS
DECLARE @CountStaff INT = (SELECT TOP 1 COUNT(Staff_no) FROM PROPERTY GROUP BY Staff_no ORDER BY COUNT(Staff_no) DESC)
DECLARE @NumStaff INT = (SELECT TOP 1 Staff_no FROM PROPERTY GROUP BY Staff_no ORDER BY COUNT(Staff_no) DESC)
IF 
	@CountStaff > 3
	ROLLBACK TRANSACTION
	PRINT '������! ���������� �������� �� ������ ���� ������ ����'


INSERT INTO PROPERTY (Property_no, Date_registration, Postcode, City, Street, House, Flat, Floor_type, Floor_n, Rooms, The_area, Balcony, Ptel, Selling_Price, Branch_no, Staff_no, Owner_no)
VALUES (3010, CONVERT(DATETIME, '01-03-2020'), '210033', '�������', '����������', '15', 52, '5�', 3, 1, '34/20/13', '�', 'T', 60000, 1, 3, 1)

--3. �������� ������� ��� �������� ��������� �������� �� 5%, ���� � ���� Comments ������� VIEWING �������� �������� �������� ��������.
--��������� ����������������� ��������.
CREATE TRIGGER PriceDropDown
ON VIEWING AFTER INSERT
AS
IF (SELECT Comments FROM INSERTED WHERE Comments = '������� �������') = '������� �������'
	UPDATE PROPERTY
	SET Selling_Price = Selling_Price * 0.95
	WHERE Property_no = (SELECT Property_no FROM INSERTED)
	PRINT '��������� �������� ������� �� 5%'


INSERT INTO VIEWING (Date_View, Comments, Property_no, Buyer_no)
VALUES 
(CONVERT(DATETIME, '01.17.2020'), '������� �������', 3008, 7)

--4. �������� ������� ��� ���������� �������� ���������� �� 1% ��� ������ �������
CREATE TRIGGER UpperSalary
ON CONTRACT AFTER INSERT
AS
UPDATE STAFF
SET Salary = Salary * 1.01
WHERE Staff_no = (SELECT Staff_no FROM PROPERTY WHERE Property_no = (SELECT Property_no FROM INSERTED))
PRINT '�/� ���������� ��������� �� 1%'

INSERT INTO CONTRACT (Property_no, Buyer_no, Date_Contract, Service_Cost, Notary)
VALUES 
(3009, 1, CONVERT(DATETIME, '05.04.2020'), 10000, '������������ ������� ������������ ������ �.��������')


--5. �������� ������� ��� �������� ���� ����������� ������� � ������� VIEWING ��� �������� ������ �� ������� ������� PROPERTY. 
--���� �� ������� PROPERTY ��������� �����-���� ������, �� �������������� ������ ���� ������� ��� ������ ����������� ������� VIEWING, 
--� ������� �������� ���� Property_no ������������� �������� ���� Property_no ��������� �� ������� PROPERTY ������.
CREATE TRIGGER DeleteViewing
ON PROPERTY FOR DELETE
AS
DELETE FROM VIEWING
WHERE Property_no = (SELECT Property_no FROM DELETED)
PRINT '������ �� �������� VIEWING ����� ������'

DELETE FROM PROPERTY WHERE Property_no = 3001