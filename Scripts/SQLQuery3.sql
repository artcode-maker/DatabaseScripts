USE DreamHomeKlinduhov

GO

SELECT *
INTO BUYER_1 FROM BUYER
WHERE City = '�������';

GO

SELECT *
INTO BUYER_2 FROM BUYER
WHERE Buyer_no IN (SELECT Buyer_no FROM CONTRACT)

GO

DELETE FROM OWNER
WHERE Owner_no = 10

GO

UPDATE PROPERTY
SET Selling_Price = Selling_Price * 0.98
WHERE Ptel IS NULL