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
IF OBJECT_ID('Career')
	IS NOT NULL DROP TABLE Career
GO
IF OBJECT_ID('ProfileSkill')
	IS NOT NULL DROP TABLE ProfileSkill
GO 
IF OBJECT_ID('Skill')
	IS NOT NULL DROP TABLE Skill
GO 

IF OBJECT_ID('SvcProfile')
	IS NOT NULL DROP TABLE SvcProfile
GO
IF OBJECT_ID('SvcType')
	IS NOT NULL DROP TABLE SvcType
GO 
IF OBJECT_ID('Profile')
	IS NOT NULL DROP TABLE Profile
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
	pictureURL VARCHAR(255),
	portfolioURL VARCHAR(255),
	highestEducation VARCHAR(30),
	relocationYN VARCHAR(10) default 'yes',
	country VARCHAR(30),
	province VARCHAR(30),
	city VARCHAR(30),
	-- CONSTRAINT chkHighestEducation CHECK (highestEducation IN ('??')),
	CONSTRAINT chkRelocationYN CHECK (relocationYN IN ('yes','no'))
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


CREATE TABLE Skill
(
	skillID	INTEGER IDENTITY(1,1) PRIMARY KEY,
	category VARCHAR(50) NOT NULL,
	skillName VARCHAR(50) NOT NULL,
	description VARCHAR(255),
);
GO

CREATE TABLE ProfileSkill
(
	profileID INTEGER NOT NULL,
	skillID INTEGER NOT NULL,
	FOREIGN KEY(profileID) REFERENCES Profile(profileID),
	FOREIGN KEY(skillID) REFERENCES Skill(skillID)
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


INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL, 
					portfolioURL, highestEducation, relocationYN, country, province, city)
VALUES('nicholas@gmail.com', 'start$', 'Nicholas', 'Kim', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg',
		'http://portfolio.com/nicholas.html', 'certificate', 'yes', 'Canada', 'BC', 'Vancouver');


INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL, 
					portfolioURL, highestEducation, relocationYN, country, province, city)
VALUES('terry@gmail.com', 'end*', 'Terry', 'Kim', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg',
		'http://portfolio.com/nicholas.html', 'certificate', 'yes', 'Canada', 'BC', 'Vancouver');


INSERT INTO Profile( email, password, firstName, lastName, linkedinURL, pictureURL, 
					portfolioURL, highestEducation, relocationYN, country, province, city)
VALUES('mkjin@gmail.com', 'continue*', 'Meekyung', 'Jin', 
		'https://www.linkedin.com/contacts/view?id=li_356484256&trk=contacts-contacts-list-contact_name-0',
		'http://img.cdn.ca/123.jpg',
		'http://portfolio.com/nicholas.html', 'certificate', 'yes', 'Canada', 'BC', 'Vancouver');



INSERT INTO Skill( category, skillName, description )
VALUES ( 'Design', 'CSS', 'Style sheet language used for describing the look and formatting of a document');
INSERT INTO Skill( category, skillName, description )
VALUES ('Programming', 'C#', 'A multi-paradigm programming language skill encompassing strong typing');
INSERT INTO Skill( category, skillName, description )
VALUES ('DB', 'SQL Server', ' SQL Server is a relational database management system developed by Microsoft.');
INSERT INTO Skill( category, skillName, description )
VALUES ('Programming', 'JAVA', 'Java is a general-purpose computer programming language');

INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 1, 1 );
INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 1, 2 );
INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 1, 3 );
INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 2, 1 );
INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 2, 3 );
INSERT INTO ProfileSkill( profileID, skillID )
VALUES( 3, 4 );


INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 1, 'Game', 'OneTwoThree Company', 'Project Manager', 5, 'I worked well' );
INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 1, 'Education', 'ABC Company', 'Programer', 2, 'I worked well' );
INSERT INTO Career( profileID, industry, company, jobTitle, years, description )
VALUES( 3, 'Game', 'ZZZ Company', 'DBA', 2, 'I worked well' );


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
SELECT * FROM Career;
SELECT * FROM Skill;
SELECT * FROM ProfileSkill
SELECT * FROM SvcType;
SELECT * FROM SvcProfile;