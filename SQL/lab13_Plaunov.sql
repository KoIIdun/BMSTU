USE master;

DROP DATABASE IF EXISTS DB13_1

CREATE DATABASE DB13_1 ON(
    NAME=DB13_1DB,
    FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\DB13_1db.mdf',
    SIZE=10,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=5%
)
LOG ON(
    NAME=DB13_1LOG,
    FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\DB13_1log.ldf',
    SIZE=5MB,
    MAXSIZE=25MB,
    FILEGROWTH=5MB
)

DROP DATABASE IF EXISTS DB13_2

CREATE DATABASE DB13_2 ON(
    NAME=DB13_2DB,
    FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\DB13_2db.mdf',
    SIZE=10,
    MAXSIZE=UNLIMITED,
    FILEGROWTH=5%
)
LOG ON(
    NAME=DB13_2LOG,
    FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.LOCAL\MSSQL\DATA\DB13_2log.mdf',
    SIZE=5MB,
    MAXSIZE=25MB,
    FILEGROWTH=5MB
)
GO

USE DB13_1

DROP TABLE IF EXISTS Workers


CREATE TABLE Workers (
	WorkerId INT PRIMARY KEY NOT NULL,
	Name VARCHAR(20) NOT NULL,
	Salary FLOAT NOT NULL,
	Bonus INT NOT NULL,
    CONSTRAINT const CHECK (WorkerId < 100)
);
GO

USE DB13_2

DROP TABLE IF EXISTS Workers

CREATE TABLE Workers (
	WorkerId INT PRIMARY KEY NOT NULL,
	Name VARCHAR(20) NOT NULL,
	Salary FLOAT NOT NULL,
	Bonus INT NOT NULL,
    CONSTRAINT const CHECK (WorkerId >= 100)
);
GO

USE DB13_1

DROP VIEW IF EXISTS WorkersView

GO

CREATE VIEW WorkersView AS
SELECT * FROM DB13_1.dbo.Workers
UNION ALL
SELECT * FROM DB13_2.dbo.Workers
GO


USE DB13_2
DROP VIEW IF EXISTS WorkersView
GO

CREATE VIEW WorkersView AS
SELECT * FROM DB13_1.dbo.Workers
UNION ALL
SELECT * FROM DB13_2.dbo.Workers
GO


INSERT INTO WorkersView
	VALUES (1, 'Ivan', 6000.0, 20), 
		   (2, 'Anna', 8000.0, 5),
		   (100, 'Alex', 3500.0, 13),
		   (101, 'Steve', 2700.0, 3)
GO


SELECT * FROM WorkersView
SELECT * FROM DB13_1.dbo.Workers
SELECT * FROM DB13_2.dbo.Workers
GO

DELETE FROM WorkersView WHERE WorkerId=100
SELECT * FROM WorkersView
SELECT * FROM DB13_2.dbo.Workers
GO
UPDATE WorkersView SET WorkerId = 3 WHERE WorkerId = 101
SELECT * FROM WorkersView
SELECT * FROM DB13_1.dbo.Workers
SELECT * FROM DB13_2.dbo.Workers
GO