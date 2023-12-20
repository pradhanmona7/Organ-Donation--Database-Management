
DROP DATABASE OrganDonation

CREATE DATABASE OrganDonation;
GO
use OrganDonation
GO
CREATE TABLE Person (
    PersonID VARCHAR(6) not null,
    FirstName VARCHAR(25),
    LastName VARCHAR(25),
    Street VARCHAR(50),
    City VARCHAR(50),
    CONSTRAINT PersonCity_CHK CHECK (City IN ('Boston', 'Worcester', 'Springfield', 'Cambridge', 'Quincy', 'Lowell', 'Salem')),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    Contact CHAR(10),
    CONSTRAINT Contact_CHK CHECK (Contact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    Date_of_Birth DATE,
    CONSTRAINT Person_PK PRIMARY KEY (PersonID),
    Email VARCHAR(40)
)
GO


CREATE TABLE Donor (
    DonorID VARCHAR(6) not null,
    PersonID VARCHAR(6) not null,
    No_of_Organs int,
    BloodType char(2),
    CONSTRAINT BloodType_CHK CHECK (BloodType IN ('A', 'B', 'AB', 'O')),
    TissueType VARCHAR(40),
    DonorType CHAR(20),
    CONSTRAINT DonorType_CHK CHECK (DonorType IN ('Alive', 'Deceased')),
    ConsentStatus VARCHAR(10),
    Height INT,
    [Weight] INT,
    Medical_Checkup_Date DATE,
    CONSTRAINT Donor_PK PRIMARY KEY (DonorID),
    CONSTRAINT Donor_FK FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
)
GO

CREATE TABLE Recipient (
    RecipientID VARCHAR(6) not null,
    PersonID VARCHAR(6) not null,
    Insurance_Number int,
    BloodType char(2),
    CONSTRAINT RecipientBloodType_CHK CHECK (BloodType IN ('A', 'B', 'AB', 'O')),
    TissueType VARCHAR(40),
    Height INT,
    Weight INT,
    CONSTRAINT Recipient_PK PRIMARY KEY (RecipientID),
    CONSTRAINT Recipient_FK FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
)
GO

CREATE TABLE Hospital (
    HospitalID VARCHAR(6) not null,
    HospitalName VARCHAR(40),
    Street VARCHAR(50),
    City VARCHAR(50),
    CONSTRAINT HospitalCity_CHK CHECK (City IN ('Boston', 'Worcester', 'Springfield', 'Cambridge', 'Quincy')),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    HospitalContact CHAR(10),
    CONSTRAINT HospitalContact_CHK CHECK (HospitalContact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT Hospital_PK PRIMARY KEY (HospitalID),
)
GO

CREATE TABLE Doctor (
    DoctorID VARCHAR(6) not null,
    PersonID VARCHAR(6) not null,
    HospitalID VARCHAR(6) not null,
    specialization VARCHAR(20),
    availability CHAR(3),
    years_of_experience int,
    CONSTRAINT Doctor_PK PRIMARY KEY (DoctorID),
    CONSTRAINT Doctor_FK1 FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    CONSTRAINT Doctor_FK2 FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
)
GO

CREATE TABLE Examination (
    ExaminationID VARCHAR(6) not null,
    RecipientID VARCHAR(6) not null,
    DoctorID VARCHAR(6) not null,
    HospitalID VARCHAR(6) not null,
    OrganRequired CHAR(10),
    CONSTRAINT OrganRequired_CHK CHECK (OrganRequired IN ('Kidney', 'Liver', 'Lung', 'Heart', 'Pancrea', 'Intestine')),
    ExaminationDate DATE,
    RecipientOrganSize INT,
    UrgencyLevel CHAR(4),
    CONSTRAINT UrgencyLevel_CHK CHECK (UrgencyLevel IN ('High', 'Low')),
    CONSTRAINT Examination_PK PRIMARY KEY (ExaminationID),
    CONSTRAINT Examination_FK1 FOREIGN KEY (RecipientID) REFERENCES Recipient(RecipientID),
    CONSTRAINT Examination_FK2 FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    CONSTRAINT Examination_FK3 FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
)
GO

CREATE TABLE OrganBank (
    BankID VARCHAR(6) not null,
    BankName VARCHAR(40),
    BankContact CHAR(10),
    CONSTRAINT BankContact_CHK CHECK (BankContact like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    Street VARCHAR(50),
    City VARCHAR(50),
    CONSTRAINT OrganBankCity_CHK CHECK (City IN ('Boston', 'Worcester', 'Springfield', 'Cambridge', 'Quincy')),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    CONSTRAINT Bank_PK PRIMARY KEY (BankID)
)
GO

CREATE TABLE Organ (
    OrganID VARCHAR(6) not null,
    DonorID VARCHAR(6) not null,
    BankID VARCHAR(6) not null,
    OrganType CHAR(10),
    CONSTRAINT OrganType_CHK CHECK (OrganType IN ('Kidney', 'Liver', 'Lung', 'Heart', 'Pancrea', 'Intestine')),
    OrganSize INT,
    CONSTRAINT Organ_PK PRIMARY KEY (OrganID),
    CONSTRAINT Organ_FK1 FOREIGN KEY (DonorID) REFERENCES Donor(DonorID),
    CONSTRAINT Organ_FK2 FOREIGN KEY (BankID) REFERENCES OrganBank(BankID)
)
GO

CREATE TABLE Request (
    RequestID VARCHAR(6) not null,
    HospitalID VARCHAR(6) not null,
    BankID VARCHAR(6) not null,
    ExaminationID VARCHAR(6) not null,
    RequestStatus CHAR(15),
    CONSTRAINT Request_CHK CHECK (RequestStatus IN ('Approved', 'Not Approved', 'Requested')),
    RequestDate DATE,
    CONSTRAINT Request_PK PRIMARY KEY (RequestID),
    CONSTRAINT Request_FK1 FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID),
    CONSTRAINT Request_FK2 FOREIGN KEY (BankID) REFERENCES OrganBank(BankID),
    CONSTRAINT Request_FK3 FOREIGN KEY (ExaminationID) REFERENCES Examination(ExaminationID)
)
GO

CREATE TABLE Transplant (
    TransplantID int not null IDENTITY(10001,1),
    RequestID VARCHAR(6) not null,
    OrganID VARCHAR(6) not null,
    TransplantDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT Transplant_PK PRIMARY KEY (TransplantID),
    CONSTRAINT Transplant_FK1 FOREIGN KEY (RequestID) REFERENCES Request(RequestID),
    CONSTRAINT Transplant_FK2 FOREIGN KEY (OrganID) REFERENCES Organ(OrganID)
)

GO

