USE DreamHomeKlinduhov
set language 'English'
GO

--������� ���������������� �������:
--1. ��� ���������� ��������� ����� ������� �������� � ��������, ��� ��������, ����������� ������ � �������� ������.
/*CREATE FUNCTION CheapestFlat(@Rooms INT, @City VARCHAR(20))
RETURNS MONEY
AS
BEGIN
RETURN (SELECT MIN(Selling_Price) AS '����� ������� ��������'
		FROM PROPERTY 
		WHERE Rooms = @Rooms AND City = @City) END

SELECT dbo.CheapestFlat(1, '�������') AS '����� ������� ��������'*/

--2. ������ ������� ������������.
/*CREATE FUNCTION SquarProp(@Propert_no SMALLINT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @SpaceStr VARCHAR(20) = (SELECT The_area FROM PROPERTY WHERE Property_no = @Propert_no)
	DECLARE @LenStr INT = LEN(@SpaceStr)
	DECLARE @IndChar INT = PATINDEX('%/%',@SpaceStr)
	DECLARE @RevStr VARCHAR(20) = REVERSE(@SpaceStr)
	DECLARE @IndCharRev INT = PATINDEX('%/%', @RevStr)
	DECLARE @LivSpace VARCHAR(20) = SUBSTRING(@SpaceStr, 1, (@IndChar - 1))
	DECLARE @UtilityRoom VARCHAR(20) = SUBSTRING(@SpaceStr, @IndChar + 1, (@LenStr - @IndChar - @IndCharRev))
	DECLARE @Kitch VARCHAR(20) = RIGHT(@SpaceStr, (@IndCharRev - 1))
	RETURN (CONVERT(FLOAT, @LivSpace) + CONVERT(FLOAT, @UtilityRoom) + CONVERT(FLOAT, @Kitch))
END

SELECT dbo.SquarProp(3001) AS '������� ��������'*/

--3. �������� � ������ A ��� ��������� B �� ������ ���������.
/*CREATE FUNCTION StrFunc(@StrVal VARCHAR(20), @SubStr VARCHAR(5))
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @LenStr INT = LEN(@SubStr)
	DECLARE @SubStrSpaCe VARCHAR(5) = SPACE(@LenStr)
	DECLARE @StrValRet VARCHAR(20) = REPLACE(@StrVal, @SubStr, @SubStrSpaCe)
	RETURN (@StrValRet)
END

SELECT dbo.StrFunc('Hello', 'ell') AS '��������������� ������'*/

--4. ������ ������� (������������ datediff)
/*CREATE FUNCTION DateOfBirth (@DateBirth VARCHAR(20))
--RETURNS DATE
RETURNS INT
AS
BEGIN
	DECLARE @YearBirth INT = DATEDIFF(YEAR, @DateBirth, GETDATE())
	--DECLARE @YearBirth2 INT = FLOOR(@YearBirth)
	--DECLARE @MonthBirth INT = DATEDIFF(MONTH, @DateBirth, GETDATE())
	DECLARE @DayBirth INT = DATEDIFF(DAY, @DateBirth, GETDATE())
	DECLARE @YearBirth2 INT = FLOOR(@DayBirth / 365)
	RETURN @YearBirth2 --DATEFROMPARTS(@YearBirth, @MonthBirth, @DayBirth)
END

SELECT dbo.DateOfBirth('1988-07-14') AS '������ �������'*/

--5. ���������� ���
/*CREATE FUNCTION LeapYear(@Nyear VARCHAR(20))
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @Retr VARCHAR(20)
	DECLARE @NyearConv INT = CONVERT(INT, @Nyear)
	DECLARE @NyearNew INT = CONVERT(INT, @Nyear) + 1
	DECLARE @NyearCountDays INT = DATEDIFF(DAY, DATEFROMPARTS(@Nyear, 01, 01), DATEFROMPARTS(@NyearNew, 01, 01))
	IF @NyearCountDays = 365 SET @Retr = '��� �� ����������'
	ELSE SET @Retr = '��� ����������'
	RETURN @Retr
END

SELECT dbo.LeapYear('1988') AS '����� ���?'*/

--6. ���������� ���� � ������.
CREATE FUNCTION CountDays(@Month INT)
RETURNS INT
AS
BEGIN
	DECLARE @CountDaysOfMonth INT
	DECLARE @Nyear INT = YEAR(GETDATE())
	IF @Month != 12 
		SET @CountDaysOfMonth = DATEDIFF(DAY, DATEFROMPARTS(@Nyear, @Month, 01), DATEFROMPARTS(@Nyear, @Month + 1, 01))
	ELSE 
		SET @CountDaysOfMonth = DATEDIFF(DAY, DATEFROMPARTS(@Nyear, @Month, 01), DATEFROMPARTS(@Nyear + 1, 01, 01))
	RETURN @CountDaysOfMonth
END

SELECT dbo.CountDays(02) AS '������� ���� � ������?'