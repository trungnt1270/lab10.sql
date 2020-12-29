USE AdventureWorks2014
GO

CREATE PROC sp_DisplayEmployeeHireYear
	@HireYear int
AS
SELECT * FROM HumanResources.Employee
WHERE DATEPART(yy,HireDate)=@HireYear
GO

EXECUTE sp_DisplayEmployeeHireYear 2008


CREATE PROC sp_EmployeesHireYearCount
	@HireYear int,
	@Count int OUTPUT
AS
SELECT @Count=Count(*) FROM HumanResources.Employee
WHERE DATEPART(YY,HireDate)=@HireYear
GO

DECLARE @Number int
EXECUTE sp_EmployeesHireYearCount 2008, @Number output
PRINT @Number
GO

CREATE PROC sp_EmployeesHireYearCount2
	@HireYear int
AS
DECLARE @Count int
SELECT @Count=Count(*) FROM HumanResources.Employee
WHERE DATEPART(YY,HireDate)=@HireYear
RETURN @Count
GO

DECLARE @Number int
EXECUTE @Number = sp_EmployeesHireYearCount2 2008
PRINT @Number
GO


USE master
IF(DB_ID('lab10')IS NOT NULL)
	DROP DATABASE lab10
ELSE
	CREATE DATABASE lab10
GO

USE lab10
GO

CREATE TABLE Toys(
	ProductCode varchar(5) PRIMARY KEY,
	Name varchar(30),
	Category varchar(30),
	Manufacturer varchar(40),
	AgeRange varchar(15),
	UnitPrice money,
	Netweight int,
	QtyOnHand int
)

INSERT INTO Toys(ProductCode,Name,Category,Manufacturer,AgeRange,UnitPrice,Netweight,QtyOnHand)
VALUES  ('T0001','Toy1','Doll','BJD','2-10',100,80,30),
		('T0002','Toy2','Doll','BJD','2-10',100,1000,40),
		('T0003','Toy3','Doll','BJD','2-10',100,500,50),
		('T0004','Toy4','Doll','BJD','2-10',100,700,60),
		('T0005','Toy5','Doll','BJD','2-10',100,80,70),
		('T0006','Toy6','Doll','BJD','2-10',100,50,80),
		('T0007','Toy7','Doll','BJD','2-10',100,2000,90),
		('T0008','Toy8','Doll','BJD','2-10',100,300,100),
		('T0009','Toy9','Doll','BJD','2-10',100,450,20),
		('T0010','Toy10','Doll','BJD','2-10',100,360,50),
		('T0011','Toy11','Doll','BJD','2-10',100,150,80),
		('T0012','Toy12','Doll','BJD','2-10',100,80,90),
		('T0013','Toy13','Doll','BJD','2-10',100,80,40),
		('T0014','Toy14','Doll','BJD','2-10',100,80,60),
		('T0015','Toy15','Doll','BJD','2-10',100,80,20)
--2
CREATE PROCEDURE HeavyToys
AS
SELECT * FROM Toys
WHERE Netweight>500
GO

EXECUTE HeavyToys

--3
CREATE PROCEDURE PriceIncrease
AS
UPDATE Toys
SET UnitPrice = UnitPrice + 5
GO

EXECUTE PriceIncrease

--4
CREATE PROCEDURE QtyOnHand
AS
UPDATE Toys
SET QtyOnHand = QtyOnHand - 5
GO

EXECUTE QtyOnHand

--1.

sp_helptext HeavyToys

SELECT definition FROM sys.sql_modules WHERE object_id=OBJECT_ID('PriceIncrease')

SELECT OBJect_Definition(OBJECT_ID('QtyOnHand')) AS DEFINITION

--2.
sp_depends 'HeavyToys'
sp_depends 'PriceIncrease'
sp_depends 'QtyOnHand'

--3.
ALTER PROCEDURE PriceIncrease
AS
UPDATE Toys
SET UnitPrice = UnitPrice + 5
SELECT UnitPrice FROM Toys
GO

ALTER PROCEDURE QtyOnHand
AS
UPDATE Toys
SET QtyOnHand = QtyOnHand - 5
SELECT QtyOnHand FROM Toys
GO

--4.
CREATE PROCEDURE SpecificPriceIncrease
AS
UPDATE Toys
SET UnitPrice = QtyOnHand + UnitPrice
GO
EXECUTE SpecificPriceIncrease
--5.


--6.
ALTER PROCEDURE SpecificPriceIncrease
AS
UPDATE Toys
SET UnitPrice = QtyOnHand + UnitPrice
EXECUTE HeavyToys
GO
--7.

--8.
DROP PROCEDURE HeavyToys
DROP PROCEDURE PriceIncrease
DROP PROCEDURE QtyOnHand
DROP PROCEDURE SpecificPriceIncrease