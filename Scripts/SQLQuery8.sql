USE DreamHomeKlinduhov

-- Создаем переменные и таблицу, например, для выборки данных для каких-нибудь целей.
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

-- Объявляем курсор
DECLARE Cur CURSOR
FOR SELECT Property_no, City, Street, House, Flat, Rooms, The_area
	FROM PROPERTY

-- Открываем курсор и записываем первую партию данных
OPEN Cur
FETCH FROM Cur INTO @Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area
    INSERT INTO CUR_PROPERTY (Property_no, City, Street, House, Flat, Rooms, The_area)
	VALUES (@Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area)

-- Создаем цикл, в котором записываем партии данных в новую таблицу CUR_PROPERTY
WHILE @@FETCH_STATUS = 0
BEGIN
	FETCH FROM Cur INTO @Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area
	-- Проверяем не закончился ли результирующий набор курсора. Если нет, то записываем в таблицу. Иначе BREAK.
	IF @@FETCH_STATUS = -1 BREAK
    INSERT INTO CUR_PROPERTY (Property_no, City, Street, House, Flat, Rooms, The_area)
	VALUES (@Property_no, @City, @Street, @House, @Flat, @Rooms, @The_area)
END

-- Закрываем и уничтожаем курсор
CLOSE Cur
DEALLOCATE Cur

-- Проверяем записи в новой таблице CUR_PROPERTY
SELECT * FROM CUR_PROPERTY