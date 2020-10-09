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

ALTER TABLE Animal ADD StaffID int(10) NULL;

ALTER TABLE Animal ADD CONSTRAINT FOREIGN KEY FK_Animal_Staff (StaffID) REFERENCES Staff(StaffID);

ALTER TABLE Animal DROP CONSTRAINT FK_Animal_Staff;
ALTER TABLE Animal DROP INDEX FK_Animal_Staff;

ALTER TABLE Animal DROP StaffID