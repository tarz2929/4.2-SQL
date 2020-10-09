-- drop the tables created using PHPMyAdmin UI
DROP TABLE IF EXISTS Animal;
DROP TABLE IF EXISTS Species;

-- Create a new Staff Table
CREATE TABLE Staff (
    StaffID int(10) PRIMARY KEY AUTO_INCREMENT,
    FirstName varchar(20) NOT NULL,
    LastName varchar(30) NOT NULL
);

-- Create the Species table with code
CREATE TABLE IF NOT EXISTS Species (
    SpeciesID int(10) PRIMARY KEY AUTO_INCREMENT,
    CommonName varchar(50) NOT NULL,
    ScientificName varchar(80) NOT NULL,
    Class varchar(15) NOT NULL,
    TaxonomyID int(10) NOT NULL,
    Diet char(1) NOT NULL,
    Habitat varchar(50) NULL,
    RedListStatus char(2) NOT NULL
);

-- Create the Animal table with a Foreign Key
CREATE TABLE IF NOT EXISTS Animal (
    AnimalID int(10) PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
	SpeciesID int(10) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Origin varchar(50) NOT NULL,
    WeightLbs int(10) NULL,
    DateOfBirth date NULL,
    DateOfDeparture date NULL,
    DepartureCirumstances varchar(30) NULL,
    CONSTRAINT FK_Animal_Species FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);

-- Create the Species table with check constraints
CREATE TABLE IF NOT EXISTS Species (
    SpeciesID int(10) PRIMARY KEY AUTO_INCREMENT,
    CommonName varchar(50) NOT NULL,
    ScientificName varchar(80) NOT NULL,
    Class varchar(15) NOT NULL,
    TaxonomyID int(10) NOT NULL,
    Diet char(1) NOT NULL,
    Habitat varchar(50) NULL,
    RedListStatus char(2) NOT NULL,
    CONSTRAINT CK_Species_Diet CHECK (Diet IN ('C', 'H', 'O')),
    CONSTRAINT CK_Species_RedListStatus CHECK (RedListStatus IN ('NE', 'DD', 'LC', 'NT', 'VU', 'EN', 'CR', 'EW', 'EX'))
);

-- Create the Animal table with a check constraint
CREATE TABLE IF NOT EXISTS Animal (
    AnimalID int(10) PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
	SpeciesID int(10) NOT NULL,
    Gender CHAR(1) NOT NULL CHECK(Gender IN('M', 'F')),
    Origin varchar(50) NOT NULL,
    WeightLbs int(10) NULL,
    DateOfBirth date NULL,
    DateOfDeparture date NULL,
    DepartureCirumstances varchar(30) NULL,
    CONSTRAINT FK_Animal_Species FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);

-- Create the Animal table with a check constraint and Staff foreign key
CREATE TABLE IF NOT EXISTS Animal (
    AnimalID int(10) PRIMARY KEY AUTO_INCREMENT,
    Name varchar(30) NOT NULL,
	SpeciesID int(10) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Origin varchar(50) NOT NULL,
    WeightLbs int(10) NULL,
    DateOfBirth date NULL,
    DateOfDeparture date NULL,
    DepartureCirumstances varchar(30) NULL,
    CONSTRAINT CK_Animal_Gender CHECK(Gender IN('M', 'F')),
    CONSTRAINT FK_Animal_Species FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);

ALTER TABLE Animal ADD StaffID int(10) NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT FOREIGN KEY FK_Animal_Staff (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE Animal DROP CONSTRAINT FK_Animal_Staff;
ALTER TABLE Animal DROP INDEX FK_Animal_Staff;

ALTER TABLE Animal DROP StaffID;

INSERT INTO `Species` (`SpeciesID`, `CommonName`, `ScientificName`, `Class`, `TaxonomyID`, `Diet`, `Habitat`, `RedListStatus`) 
VALUES (NULL, 'Indian Elephant', 'Elephas Maximus Indicus', 'Mammal', '99487', 'H', 'Savannah', 'EN');

-- Doesn't need the SpeciesID to work
INSERT INTO `Species` (`CommonName`, `ScientificName`, `Class`, `TaxonomyID`, `Diet`, `Habitat`, `RedListStatus`) VALUES ('Indian Elephant', 'Elephas Maximus Indicus', 'Mammal', '99487', 'H', 'Savannah', 'EN')

-- Select everything from Animal
SELECT * FROM Animal

-- Select everything from Animal where the species id = 4 (groundhog)
SELECT * FROM Animal WHERE SpeciesID=4;

-- Select the count of ground hogs from the Animal table
SELECT COUNT(AnimalID) AS Total FROM Animal WHERE SpeciesID=4

-- Select the name of all of the ground hogs
SELECT Name FROM Animal WHERE SpeciesID=4

-- Select the names of all of the ground hogs in ascending alphabetical order
SELECT Name FROM Animal WHERE SpeciesID=4 ORDER BY Name ASC

-- Select the names of all of the ground hogs in descending alphabetical order
SELECT Name FROM Animal WHERE SpeciesID=4 ORDER BY Name DESC

-- Select the first and last names of all staff; in last name descending order but first name ascending order
SELECT FirstName, LastName 
FROM Staff
ORDER BY FirstName ASC, LastName DESC;

-- Select the name from the animal table and scientific name from the species table
-- where the animal is a ground hog
SELECT A.Name, S.ScientificName 
FROM Animal as A, Species as S
WHERE A.SpeciesID = S.SpeciesID
	AND A.SpeciesID=4;

-- give me all of the scientific names of the animals but don't repeate yourself
SELECT DISTINCT S.ScientificName 
FROM Animal as A, Species as S
WHERE A.SpeciesID = S.SpeciesID;


