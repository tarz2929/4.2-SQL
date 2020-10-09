-- drop the tables created using PHPMyAdmin UI
DROP TABLE IF EXISTS Animal;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS RedListStatus;

-- Create a new Staff Table
CREATE TABLE IF NOT EXISTS Staff (
    StaffID int(10) PRIMARY KEY AUTO_INCREMENT,
    FirstName varchar(20) NOT NULL,
    LastName varchar(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS RedListStatus ( 
    RedListStatusID tinyint(2) PRIMARY KEY AUTO_INCREMENT,
    StatusCode char(2) NOT NULL,
    Description varchar(30) NULL
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
    RedListStatusID tinyint(2) NOT NULL,
    CONSTRAINT CK_Species_Diet CHECK (Diet IN ('C', 'H', 'O')),
    CONSTRAINT FOREIGN KEY FK_Species_RedListStatus (RedListStatusID) REFERENCES RedListStatus(RedListStatusID)
);

-- Create the Animal table with a check constraint and Staff foreigh key
CREATE TABLE IF NOT EXISTS Animal (
    AnimalID int(10) PRIMARY KEY AUTO_INCREMENT,
    StaffID int(10) NOT NULL,
    Name varchar(30) NOT NULL,
	SpeciesID int(10) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Origin varchar(50) NOT NULL,
    WeightLbs float(6,2) NULL,
    DateOfBirth date NULL,
    DateOfDeparture date NULL,
    DepartureCirumstances varchar(30) NULL,
    CONSTRAINT CK_Animal_Gender CHECK (Gender IN('M', 'F')),
    CONSTRAINT FK_Animal_Species FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    CONSTRAINT FK_Animal_Staff FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

INSERT INTO RedListStatus (RedListStatusID, StatusCode, Description)
VALUES
(NULL, 'NE', 'Not Evaluated'),
(NULL, 'DD', 'Data Deficient'),
(NULL, 'LC', 'Least Concern'),
(NULL, 'NT', 'Near Threatened'),
(NULL, 'VU', 'Vulnerable'),
(NULL, 'EN', 'Endangered'),
(NULL, 'CR', 'Critically Endangered'),
(NULL, 'EW', 'Exctinct in the Wild'),
(NULL, 'EX', 'Extinct');


INSERT INTO `Species` (`SpeciesID`, `CommonName`, `ScientificName`, `Class`, `TaxonomyID`, `Diet`, `Habitat`, `RedListStatusID`) 
VALUES 
(NULL, 'Indian Elephant', 'Elephas maximus indicus', 'Mammal', '99487', 'H', 'Tropical', 6),
(NULL, 'Lion', 'Panthera leo', 'Mammal', 9689, 'C', 'Sub-Sahara', 5),
(NULL, 'Tiger', 'Panthera tigris', 'Mammal', 9694, 'C', 'Tropical', 6),
(NULL, 'Groundhog', 'Marmota monax', 'Mammal', 9995, 'O', 'Alpine Meadow', 3);

INSERT INTO `Staff` (`StaffID`, `FirstName`, `LastName`) 
VALUES
(NULL, 'Tammy', 'Lee'),
(NULL, 'Han', 'Solo'),
(NULL, 'Leia', 'Organa'),
(NULL, 'Luke', 'Skywalker'),
(NULL, 'Darth', 'Vader');

INSERT INTO `Animal`(`AnimalID`, `SpeciesID`, `StaffID`, `Name`, `Gender`, `Origin`, `WeightLbs`, `DateOfBirth`, `DateOfDeparture`, `DepartureCirumstances`)
VALUES
(NULL, 1, 1, 'George', 'M', 'Rescue', 963, '2018-09-25', NULL, NULL),
(NULL, 2, 2, 'Simba', 'M', 'Zoo birth', 420, '2017-07-17', NULL, NULL),
(NULL, 3, 4, 'Tigra', 'F', 'Rehabilitated', 500, NULL, NULL, NULL),
(NULL, 4, 3, 'Daisy', 'F', 'Zoo birth', 13, '2020-02-13', NULL, NULL),
(NULL, 4, 3, 'Valerian', 'F', 'Zoo birth', 10, '2020-02-13', NULL, NULL),
(NULL, 4, 3, 'Anenome', 'F', 'Zoo birth', 14, '2020-02-13', NULL, NULL),
(NULL, 4, 3, 'Lupine', 'M', 'Zoo birth', 11, '2020-02-13', NULL, NULL),
(NULL, 4, 3, 'Saxifrage', 'M', 'Zoo birth', 12, '2020-02-13', NULL, NULL);
