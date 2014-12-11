-- DATABASE ----------------------------
USE master
GO 

IF EXISTS (SELECT * FROM sysdatabases WHERE name='Employees')
  DROP DATABASE Employees
GO

CREATE DATABASE Employees
GO

USE Employees
GO

-- DELETE OLD TABLES  ----------------------------
IF OBJECT_ID('Skill')
	IS NOT NULL DROP TABLE Skill
GO 
IF OBJECT_ID('Career')
	IS NOT NULL DROP TABLE JobTitle
GO 
IF OBJECT_ID('PreferredLocation')
	IS NOT NULL DROP TABLE PreferredLocation
GO 
IF OBJECT_ID('SvcProfile')
	IS NOT NULL DROP TABLE SvcProfile
GO 
IF OBJECT_ID('Profile')
	IS NOT NULL DROP TABLE Profile
GO 
IF OBJECT_ID('SvcType')
	IS NOT NULL DROP TABLE SvcType
GO 

-- CREATE TABLES  ----------------------------
CREATE TABLE Profile
(
	profileID INTEGER IDENTITY(1,1) PRIMARY KEY,
	email VARCHAR(100) NOT NULL,
	password VARCHAR(20) NOT NULL,
	firstName VARCHAR(30) NOT NULL,
	lastName VARCHAR(30) NOT NULL,
	linkedinURL VARCHAR(255),
	pictureURL VARCHAR(255)
);
GO 

CREATE TABLE Skill
(
	skillID	INTEGER IDENTITY(1,1) PRIMARY KEY,
	profileID INTEGER NOT NULL,
	category VARCHAR(255) NOT NULL,
	skillName VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	FOREIGN KEY(profileID) REFERENCES Profile(profileID) 
);
GO

CREATE TABLE Career
(
	careerID INTEGER IDENTITY(1,1) PRIMARY KEY,
	profileID INTEGER NOT NULL,
	industry VARCHAR(50) NOT NULL,
	company VARCHAR(50) NOT NULL,
	jobTitle VARCHAR(50) NOT NULL,
	years INTEGER NOT NULL,
	description VARCHAR(255),
	FOREIGN KEY(profileID) REFERENCES Profile(profileID)
);
GO

CREATE TABLE PreferredLocation
(
	preferredLocationID INTEGER IDENTITY(1,1) PRIMARY KEY,
	profileID INTEGER NOT NULL,
	country VARCHAR(50) NOT NULL,
	province VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	description	VARCHAR(255),
	FOREIGN KEY(profileID) REFERENCES Profile(profileID)
);
GO

CREATE TABLE SvcType
(
	svcTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
	svcName VARCHAR(50) NOT NULL,
	svcCharge MONEY NOT NULL,
	svcWeeks INTEGER NOT NULL,
	description	VARCHAR(255)
);
GO

CREATE TABLE SvcProfile
(
	svcProfileID INTEGER IDENTITY(1,1) PRIMARY KEY,
	profileID INTEGER NOT NULL,
	svcTypeID INTEGER NOT NULL,
	billingDate DATETIME DEFAULT GETDATE() NOT NULL,
	billingCode VARCHAR(100) NOT NULL,	
	billingMethod VARCHAR(50) NOT NULL,
	svcStartDate DATETIME,
	svcEndDate DATETIME,
	FOREIGN KEY(profileID) REFERENCES Profile(profileID),
	FOREIGN KEY(svcTypeID) REFERENCES SvcType(svcTypeID)
);
GO

-- INSERT SAMPLE DATA ----------------------------
INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL)
VALUES('nicholas@gmail.com', 'start$', 'Nicholas', 'Kim', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg');
INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL)
VALUES('terry@gmail.com', 'end*', 'Terry', 'Kim', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg');
INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL)
VALUES('mkjin@gmail.com', 'continue*', 'Meekyung', 'Jin', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg');


INSERT INTO Skill( profileID, category, skillName, description )
VALUES ( 1, 'Design', 'CSS', 'I love design .');
INSERT INTO Skill( profileID, category, skillName, description )
VALUES ( 1, 'Programming', 'C#', 'I am good at c#.');
INSERT INTO Skill( profileID, category, skillName, description )
VALUES ( 1, 'DB', 'SQL Server', 'I am good at SQL Server .');
INSERT INTO Skill( profileID, category, skillName, description )
VALUES ( 2, 'Programming', 'C#', 'I am good at c#.');


INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 1, 'Game', 'OneTwoThree Company', 'Project Manager', 5, 'I worked well' );
INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 1, 'Education', 'ABC Company', 'Programer', 2, 'I worked well' );
INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 3, 'Game', 'ZZZ Company', 'DBA', 2, 'I worked well' );



INSERT INTO PreferredLocation( profileID, country, province, city, description )
VALUES( 1, 'Canada', 'BC', 'Vancouver', 'I live in Vancouver');
INSERT INTO PreferredLocation( profileID, country, province, city, description )
VALUES( 1, 'Kenya', 'TG', 'Bambaya', 'I love animals');
INSERT INTO PreferredLocation( profileID, country, province, city, description )
VALUES( 2, 'Canada', 'BC', 'Vancouver', 'I live in Vancouver');
INSERT INTO PreferredLocation( profileID, country, province, city, description )
VALUES( 2, 'Kenya', 'TG', 'Bambaya', 'I love animals');


INSERT INTO SvcType( svcName, svcCharge, svcWeeks, description )
VALUES( 'Basic Service', 99.99, 4, 'Our First Service');
INSERT INTO SvcType( svcName, svcCharge, svcWeeks, description )
VALUES( 'Short Service', 60.99, 2, 'Short Service');
INSERT INTO SvcType( svcName, svcCharge, svcWeeks, description )
VALUES( 'Long Service', 110.99, 6, 'Short Service');

INSERT INTO SvcProfile( profileID, svcTypeID, billingCode, billingMethod, svcStartDate, svcEndDate )
VALUES( 1, 1, 'A000000000001', 'VISA Card',  '2014-12-10 00:00:00', '2015-01-06 00:00:00') ; 

INSERT INTO SvcProfile( profileID, svcTypeID, billingCode, billingMethod, svcStartDate, svcEndDate )
VALUES( 2, 1, 'A000000000002', 'VISA Card',  '2014-12-10 00:00:00', '2015-01-06 00:00:00') ; 

INSERT INTO SvcProfile( profileID, svcTypeID, billingCode, billingMethod, svcStartDate, svcEndDate )
VALUES( 3, 1, 'A000000000003', 'VISA Card',  '2014-12-10 00:00:00', '2015-01-06 00:00:00') ; 


-- SHOW DATA  ----------------------------
SELECT * FROM Profile;
SELECT * FROM Skill;
SELECT * FROM Career;
SELECT * FROM PreferredLocation;
SELECT * FROM SvcType;
SELECT * FROM SvcProfile;