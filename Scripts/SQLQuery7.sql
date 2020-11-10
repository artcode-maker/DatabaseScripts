USE DreamHomeKlinduhov

--1. ����������� ������ ���������� ��������� ������� fn_dblog
SELECT * FROM sys.fn_dblog(NULL,NULL);

--�� ����� ������ ������, ������� ���������� ������� fn_dblog ������� ������ �������:
SELECT [CURRENT LSN], 
       Operation, 
       Context, 
       [TRANSACTION ID], 
       [BEGIN TIME]
FROM sys.fn_dblog(NULL, NULL)

--2. ������� ��������� ����������, �������� ��������� �������:
BEGIN TRANSACTION TR0
CREATE TABLE #aaa (cola INT)
	BEGIN TRANSACTION TR1
	INSERT INTO #aaa VALUES (111)
		BEGIN TRANSACTION TR2
		INSERT INTO #aaa VALUES (222)
			BEGIN TRANSACTION TR3
				INSERT INTO #aaa VALUES (333) 
				SELECT * FROM #aaa
				SELECT '����������� ����������', @@TRANCOUNT ROLLBACK TRAN
				SELECT * FROM #aaa
				SELECT '����������� ����������', @@TRANCOUNT

--���������������� ���������� ����������.

-- ��������� ������: ��������� 208, ������� 16, ��������� 0, ������ 25
--                   ������������ ��� ������� "#aaa".

-- ������ ������ ������� ���, ��� ����� ���������� �������������� � ����� ������� ���������� ��� ������ TR0
-- � ������� ������� #aaa ����������� �� ���������. ��� ���� ROLLBACK ��������� ���������� � �������� @@TRANCOUNT
-- ���� ��������, ��� ������������� ROLLBACK � ����� ��������� ���������� ��������� ������������� COMMIT ���
-- �������� ���������� ����������.


--3. �������� ������ ������ �������� � �������������� ������ COMMIT � ROLLBACK ��� ������� � ����� ����������.

-- ����� ����������:
BEGIN TRANSACTION TR
	SELECT Salary AS '�� ��' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS '�� �����' FROM STAFF
COMMIT

BEGIN TRANSACTION TR
	SELECT Salary AS '�� ��' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS '�� �����' FROM STAFF
	IF 3000000 > ANY(SELECT Salary FROM STAFF)
		BEGIN
			PRINT '����� ����������'
			ROLLBACK TRANSACTION TR
		END;
	ELSE 
		COMMIT

-- ������� ����������:
	SET IMPLICIT_TRANSACTIONS ON
	SELECT Salary AS '�� ��' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS '�� �����' FROM STAFF
	COMMIT

--4. ��������� ������ ��������������� ������ ���������� � �������� ������ ����������, 
--��������� ������������� IMPLICIT_TRANSACTIONS � ������� COMMIT.

--����� ��������������� ������ ����������
SELECT * FROM BUYER
SELECT * FROM PROPERTY

--�������� ����� �������� ������ ���������� � ��������� ���������
SET IMPLICIT_TRANSACTIONS ON
SELECT * FROM BUYER
SELECT * FROM PROPERTY
COMMIT

--����������� �� �������������� ����������
SET IMPLICIT_TRANSACTIONS OFF