USE DreamHomeKlinduhov

-- ������� ���������� � �������, ��������, ��� ������� ������ ��� �����-������ �����.
DECLARE @Property_no SMALLINT, @City SHORTSTRING, @Street SHORTSTRING, @House SHORTSTRING, @Flat INT, @Rooms INT, @The_area SHORTSTRING
CREATE TABLE CUR_PROPERTY
(
	Property_no SMALLINT,
	City SHORTSTRING,
	Street SHORTSTRING,
	House SHORTSTRING,
	Flat INT,
	Rooms INT,
	The_area SHORTSTRING
)

-- ��������� ������
DECLARE Cur CURSOR
FOR SELECT Property_no, City, Street, House, Flat, Rooms, The_area
	FROM PROPERTY

-- ��������� ������ � ���������� ������ ������ ������
OPEN Cur
FETCH FROM Cur INTO @Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area
    INSERT INTO CUR_PROPERTY (Property_no, City, Street, House, Flat, Rooms, The_area)
	VALUES (@Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area)

-- ������� ����, � ������� ���������� ������ ������ � ����� ������� CUR_PROPERTY
WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH FROM Cur INTO @Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area
	-- ��������� �� ���������� �� �������������� ����� �������. ���� ���, �� ���������� � �������. ����� BREAK.
	IF @@FETCH_STATUS = -1 BREAK
    INSERT INTO CUR_PROPERTY (Property_no, City, Street, House, Flat, Rooms, The_area)
	VALUES (@Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area)
END

-- ��������� � ���������� ������
CLOSE Cur
DEALLOCATE Cur

-- ��������� ������ � ����� ������� CUR_PROPERTY
SELECT * FROM CUR_PROPERTY