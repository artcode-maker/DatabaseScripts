USE DreamHomeKlinduhov

--1. Просмотрите журнал транзакций используя функцию fn_dblog
SELECT * FROM sys.fn_dblog(NULL,NULL);

--Из всего набора данных, который возвращает функция fn_dblog выведем только колонки:
SELECT [CURRENT LSN], 
       Operation, 
       Context, 
       [TRANSACTION ID], 
       [BEGIN TIME]
FROM sys.fn_dblog(NULL, NULL)

--2. Создать вложенные транзакции, выполнив следующие команды:
BEGIN TRANSACTION TR0
CREATE TABLE #aaa (cola INT)
	BEGIN TRANSACTION TR1
	INSERT INTO #aaa VALUES (111)
		BEGIN TRANSACTION TR2
		INSERT INTO #aaa VALUES (222)
			BEGIN TRANSACTION TR3
				INSERT INTO #aaa VALUES (333) 
				SELECT * FROM #aaa
				SELECT 'Вложенность транзакций', @@TRANCOUNT ROLLBACK TRAN
				SELECT * FROM #aaa
				SELECT 'Вложенность транзакций', @@TRANCOUNT

--Проанализировать полученные результаты.

-- Возникает ошибка: Сообщение 208, уровень 16, состояние 0, строка 25
--                   Недопустимое имя объекта "#aaa".

-- Данная ошибка вызвана тем, что откат транзакций осуществляется к самой внешней транзакции под именем TR0
-- и поэтому таблица #aaa оказывается не созданной. При этом ROLLBACK завершает транзакцию и обнуляет @@TRANCOUNT
-- Хочу отметить, что использование ROLLBACK в самой вложенной транзакции исключает использование COMMIT для
-- закрытия оставшихся транзакций.


--3. Написать пример пакета запросов с использованием команд COMMIT и ROLLBACK для неявных и явных транзакций.

-- Явные транзакции:
BEGIN TRANSACTION TR
	SELECT Salary AS 'ЗП До' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS 'ЗП После' FROM STAFF
COMMIT

BEGIN TRANSACTION TR
	SELECT Salary AS 'ЗП До' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS 'ЗП После' FROM STAFF
	IF 3000000 > ANY(SELECT Salary FROM STAFF)
		BEGIN
			PRINT 'Откат транзакции'
			ROLLBACK TRANSACTION TR
		END;
	ELSE 
		COMMIT

-- Неявная транзакция:
	SET IMPLICIT_TRANSACTIONS ON
	SELECT Salary AS 'ЗП До' FROM STAFF
	UPDATE STAFF
	SET Salary = Salary * 1.1
	WHERE Salary < 120000
	SELECT Salary AS 'ЗП После' FROM STAFF
	COMMIT

--4. Проверить режимы автоматического начала транзакций и неявного начала транзакций, 
--используя переключатель IMPLICIT_TRANSACTIONS и команду COMMIT.

--режим автоматического начала транзакций
SELECT * FROM BUYER
SELECT * FROM PROPERTY

--включаем режим неявного начала транзакций и выполняем тразакцию
SET IMPLICIT_TRANSACTIONS ON
SELECT * FROM BUYER
SELECT * FROM PROPERTY
COMMIT

--переключаем на автоматическую транзакцию
SET IMPLICIT_TRANSACTIONS OFF