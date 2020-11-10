--DROP DATABASE DreamHomeKlinduhov
--GO
CREATE DATABASE DreamHomeKlinduhov
GO
USE DreamHomeKlinduhov
EXEC sp_addtype PhoneNumber, 'CHAR (17)', NULL
EXEC sp_addtype postcode, 'CHAR (6)', NULL 
EXEC sp_addtype member_no, 'SMALLINT'
EXEC sp_addtype shortstring, 'VARCHAR(20)'
GO

CREATE TABLE BRANCH
(
	Branch_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Postcode CHAR(12) NOT NULL,
	City CHAR(20) NOT NULL,
	Street VARCHAR(20) NOT NULL,
	House VARCHAR(10) NOT NULL,
	Btel_no PhoneNumber NOT NULL,
	Fax_no PhoneNumber NULL
)

GO

CREATE TABLE OWNER
(
	Owner_no member_no IDENTITY(1, 1) NOT NULL,
	FName shortstring NOT NULL,
	LName shortstring NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House NCHAR(6) NOT NULL,
	Flat SMALLINT NULL,
	Otel_no PhoneNumber NULL
)

GO

CREATE TABLE BUYER
(
	Buyer_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname shortstring NOT NULL,
	LName shortstring NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House NCHAR(6) NOT NULL,
	Flat SMALLINT NULL,
	Htel_no PhoneNumber NULL,
	Wtel_no PhoneNumber NULL,
	Prof_rooms TINYINT NOT NULL,
	Branch_no member_no NOT NULL,
	Max_Price MONEY NOT NULL
	CONSTRAINT FK_Branch_no FOREIGN KEY (Branch_no) REFERENCES BRANCH
	ON UPDATE CASCADE,
	CHECK (Htel_no IS NOT NULL OR Wtel_no IS NOT NULL)
)

GO

ALTER TABLE OWNER
ADD CONSTRAINT PK_Owner PRIMARY KEY
NONCLUSTERED(Owner_no)

GO

CREATE TABLE STAFF
(
	Staff_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Fname shortstring NOT NULL,
	LNAME shortstring NOT NULL,
	DOB DATETIME NOT NULL,
	SEX NVARCHAR(1) NOT NULL,
	City shortstring NOT NULL,
	Street shortstring NOT NULL,
	House shortstring NOT NULL,
	Flat INT NULL,
	STel_no PhoneNumber NULL,
	Date_Joined DATETIME,
	Position shortstring NOT NULL,
	Salary MONEY NOT NULL,
	Branch_no member_no NULL,
	FOREIGN KEY (Branch_no) REFERENCES BRANCH (Branch_no),
	CONSTRAINT CK_STAFF_SEX CHECK(SEX = 'æ' OR SEX = 'ì')
)

GO

CREATE TABLE PROPERTY
(
	Property_no member_no NOT NULL PRIMARY KEY,
	Branch_no member_no NOT NULL,
	Staff_no member_no NOT NULL,
	Owner_no member_no NOT NULL,
	Date_registration DATETIME NOT NULL,
	Postcode postcode NOT NULL,
	City SHORTSTRING NOT NULL,
	Street SHORTSTRING NOT NULL,
	House SHORTSTRING NOT NULL,
	Flat INT NULL,
	Floor_type VARCHAR(3) NULL,
	Floor_n INT,
	Rooms INT NOT NULL,
	The_area SHORTSTRING NOT NULL,
	Balcony VARCHAR(5),
	Ptel PhoneNumber NULL,
	Selling_Price MONEY NOT NULL,
	FOREIGN KEY (Branch_no) REFERENCES BRANCH (Branch_no),
	FOREIGN KEY (Staff_no) REFERENCES STAFF (Staff_no),
	FOREIGN KEY (Owner_no) REFERENCES OWNER (Owner_no),
	CONSTRAINT CK_PROPERTY_Rooms CHECK(Rooms > 0 AND Rooms < 1000)
)

GO

ALTER TABLE PROPERTY
ADD CONSTRAINT FK_STAFF FOREIGN KEY (Staff_no) REFERENCES staff
ON UPDATE CASCADE


GO


CREATE TABLE VIEWING
(
	Property_no member_no NOT NULL,
	Buyer_no member_no NOT NULL,
	Date_View DATETIME NOT NULL,
	Comments VARCHAR(50),
	FOREIGN KEY (Property_no) REFERENCES PROPERTY (Property_no),
	FOREIGN KEY (Buyer_no) REFERENCES BUYER (Buyer_no),
	PRIMARY KEY(Property_no, Buyer_no)
)

GO

ALTER TABLE PROPERTY ADD CONSTRAINT DF_Ptel DEFAULT ('T') FOR Ptel

GO

CREATE INDEX INDEX_STAFF_Fname ON STAFF (FName)
CREATE INDEX INDEX_STAFF_Position ON STAFF (Position)
CREATE INDEX INDEX_VIEWING_Date_View ON VIEWING (Date_View)

GO

CREATE TABLE CONTRACT
(
	Contract_no member_no IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Property_no member_no NOT NULL,
	Buyer_no member_no NOT NULL,
	Date_Contract DATETIME NOT NULL,
	Service_Cost MONEY,
	FOREIGN KEY (Property_no) REFERENCES PROPERTY (Property_no),
	FOREIGN KEY (Buyer_no) REFERENCES BUYER (Buyer_no)
)