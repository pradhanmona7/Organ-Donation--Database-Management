
-- Non-Clustered Indexes

CREATE NONCLUSTERED INDEX idx_BloodType ON Donor (BloodType);

CREATE NONCLUSTERED INDEX idx_OrganType ON Organ (OrganType);

CREATE NONCLUSTERED INDEX idx_specialization ON Doctor (specialization);

GO



-- UDF 1 to calculate the Age of Person and adding the computed column to the table

ALTER TABLE Person ADD Age INT
GO

CREATE FUNCTION dbo.CalculateAge(@dateOfBirth DATE)
RETURNS INT
AS
BEGIN
    DECLARE @age INT

    SET @age = DATEDIFF(YEAR, @dateOfBirth, GETDATE())
            - CASE WHEN MONTH(@dateOfBirth) > MONTH(GETDATE())
                      OR (MONTH(@dateOfBirth) = MONTH(GETDATE())
                          AND DAY(@dateOfBirth) > DAY(GETDATE()))
                  THEN 1 ELSE 0 END;

    RETURN @age
END

GO

-- Trigger 1

CREATE TRIGGER InsertPersonAge ON Person
AFTER INSERT
AS
BEGIN
    UPDATE Person
    SET Age = dbo.CalculateAge(p.Date_of_Birth)
    FROM Person p
    INNER JOIN inserted ON p.PersonID = inserted.PersonID
END

GO



INSERT INTO Person (PersonID, FirstName, LastName, Street, City, [State], Zip, Contact, Date_of_Birth, Email)
VALUES ('P10001', 'John', 'Doe', '123 Main St', 'Boston', 'MA', '02101', '1234567890', '1980-01-01', 'johndoe@gmail.com'),
('P10002', 'Jane', 'Doe', '456 Elm St', 'Worcester', 'MA', '01602', '2345678901', '1985-05-15', 'janedoe@yahoo.com'),
('P10003', 'Bob', 'Smith', '789 Oak St', 'Springfield', 'MA', '01101', '3456789012', '1978-07-10', 'bsmith@hotmail.com'),
('P10004', 'Samantha', 'Johnson', '10 Maple St', 'Cambridge', 'MA', '02139', '4567890123', '1992-11-23', 'sjohnson@gmail.com'),
('P10005', 'David', 'Lee', '987 Pine St', 'Quincy', 'MA', '02169', '5678901234', '1983-03-07', 'davidlee@yahoo.com'),
('P10006', 'Michael', 'Brown', '111 High St', 'Boston', 'MA', '02108', '6789012345', '1975-12-29', 'mbrown@gmail.com'),
('P10007', 'Stephanie', 'Taylor', '222 Low St', 'Worcester', 'MA', '01603', '7890123456', '1988-08-18', 'staylor@hotmail.com'),
('P10008', 'Christopher', 'Wilson', '333 Broad St', 'Springfield', 'MA', '01103', '8901234567', '1981-02-04', 'cwilson@gmail.com'),
('P10009', 'Sarah', 'Martin', '444 Market St', 'Cambridge', 'MA', '02142', '9012345678', '1990-06-12', 'smartin@yahoo.com'),
('P10010', 'Matthew', 'Garcia', '555 Church St', 'Quincy', 'MA', '02171', '0123456789', '1979-10-27', 'mgarcia@hotmail.com'),
('P10011', 'Emily', 'Jones', '12 South Street', 'Worcester', 'MA', '01602', '5085551234', '1982-09-12', 'emily.jones@example.com'),
('P10012', 'Benjamin', 'Smith', '55 East Street', 'Cambridge', 'MA', '02139', '6175559876', '1991-03-21', 'benjamin.smith@example.com'),
('P10013', 'Victoria', 'Brown', '123 Main Street', 'Springfield', 'MA', '01103', '4135557423', '1986-08-06', 'victoria.brown@example.com'),
('P10014', 'William', 'Johnson', '234 Park Avenue', 'Boston', 'MA', '02108', '6175553210', '1989-12-19', 'william.johnson@example.com'),
('P10015', 'Ethan', 'Davis', '14 Oak Street', 'Quincy', 'MA', '02169', '6175550123', '1992-06-02', 'ethan.davis@example.com'),
('P10016', 'Sophia', 'Lee', '145 Elm Street', 'Worcester', 'MA', '01609', '5085555678', '1990-02-14', 'sophia.lee@example.com'),
('P10017', 'Daniel', 'Garcia', '77 Spring Street', 'Springfield', 'MA', '01109', '4135558765', '1984-11-29', 'daniel.garcia@example.com'),
('P10018', 'Avery', 'Rodriguez', '66 Summer Street', 'Cambridge', 'MA', '02138', '6175552345', '1993-07-11', 'avery.rodriguez@example.com'),
('P10019', 'Madison', 'Smith', '123 Forest Road', 'Boston', 'MA', '02116', '6175554567', '1992-04-03', 'madison.smith@example.com'),
('P10020', 'Joseph', 'White', '100 Main Street', 'Quincy', 'MA', '02169', '6175557890', '1988-10-17', 'joseph.white@example.com'),
('P10021', 'Elizabeth', 'Brown', '50 Elm Street', 'Worcester', 'MA', '01608', '5085553333', '1994-01-28', 'elizabeth.brown@example.com'),
('P10022', 'Oliver', 'Gonzalez', '234 Maple Avenue', 'Springfield', 'MA', '01105', '4135550987', '1987-05-12', 'oliver.gonzalez@example.com'),
('P10023', 'Mia', 'Lopez', '99 Broad Street', 'Cambridge', 'MA', '02142', '6175556543', '1993-08-25', 'mia.lopez@example.com'),
('P10024', 'Noah', 'Wilson', '100 Arlington Street', 'Boston', 'MA', '02116', '6175559876', '1989-02-16', 'noah.wilson@example.com'),
('P10025', 'Cameron', 'Martin', '789 Park Ave', 'Boston', 'MA', '02115', '6172239898', '1995-02-14', 'cmartin@gmail.com'),
('P10026', 'Maddison', 'Harris', '982 Beacon St', 'Worcester', 'MA', '01602', '5085647788', '1986-05-23', 'mharris@hotmail.com'),
('P10027', 'Makayla', 'Robinson', '556 Tremont St', 'Cambridge', 'MA', '02139', '6174282254', '1990-07-01', 'mrobinson@gmail.com'),
('P10028', 'Connor', 'Phillips', '95 Newbury St', 'Springfield', 'MA', '01103', '4137451234', '1999-11-06', 'cphillips@hotmail.com'),
('P10029', 'Lila', 'Turner', '415 Massachusetts Ave', 'Boston', 'MA', '02115', '6173124242', '1992-03-17', 'lturner@gmail.com'),
('P10030', 'Bryce', 'Scott', '1447 Commonwealth Ave', 'Worcester', 'MA', '01609', '5089821522', '1997-09-12', 'bscott@hotmail.com'),
('P10031', 'Avery', 'Anderson', '103 Oxford St', 'Cambridge', 'MA', '02138', '6174951212', '1993-01-24', 'aanderson@gmail.com'),
('P10032', 'Brayden', 'Nelson', '88 Commercial St', 'Springfield', 'MA', '01103', '4133693456', '1991-08-08', 'bnelson@hotmail.com'),
('P10033', 'Eva', 'Edwards', '256 Boylston St', 'Boston', 'MA', '02116', '6174235789', '1996-04-30', 'eedwards@gmail.com'),
('P10034', 'Carson', 'Baker', '15 Harvard Ave', 'Worcester', 'MA', '01605', '5088744321', '1989-02-13', 'cbaker@hotmail.com'),
('P10035', 'Reagan', 'Garcia', '382 Commonwealth Ave', 'Cambridge', 'MA', '02139', '6173589966', '1994-12-08', 'rgarcia@gmail.com'),
('P10036', 'Brielle', 'Lopez', '900 Main St', 'Springfield', 'MA', '01103', '4137892345', '1987-11-22', 'blopez@hotmail.com'),
('P10037', 'Landon', 'Rivera', '736 Commonwealth Ave', 'Boston', 'MA', '02215', '6172197532', '1998-06-03', 'lrivera@gmail.com'),
('P10038', 'Isabella', 'Young', '345 Harvard St', 'Worcester', 'MA', '01609', '5086549876', '1990-10-17', 'iyoung@hotmail.com'),
('P10039', 'Avery', 'Perry', 'Fulton St', 'Boston', 'MA', '02110', '8574853029', '1985-07-12', 'averyperry@gmail.com'),
('P10040', 'Jordyn', 'Cohen', 'Riverside Ave', 'Worcester', 'MA', '01608', '5082451098', '1992-03-05', 'jordyncohen@yahoo.com'),
('P10041', 'Sydney', 'Lopez', 'Main St', 'Springfield', 'MA', '01103', '4137684512', '1998-11-19', 'sydney.lopez@hotmail.com'),
('P10042', 'Zion', 'Cruz', 'Cambridge St', 'Cambridge', 'MA', '02141', '6174235437', '1989-05-02', 'zioncruz@gmail.com'),
('P10043', 'Maddison', 'Ward', 'Main St', 'Quincy', 'MA', '02169', '8573367125', '1995-02-23', 'maddison.ward@gmail.com'),
('P10044', 'Armando', 'Reyes', 'Elm St', 'Boston', 'MA', '02114', '6174562390', '1984-09-28', 'armando.reyes@hotmail.com'),
('P10045', 'Ashlynn', 'Hansen', 'Belmont St', 'Worcester', 'MA', '01610', '5087561043', '1991-06-13', 'ashlynnhansen@yahoo.com'),
('P10046', 'Jonah', 'Baker', 'Maple St', 'Springfield', 'MA', '01105', '4135687214', '1997-12-17', 'jonahbaker@gmail.com'),
('P10047', 'Gemma', 'Oliver', 'Harvard St', 'Cambridge', 'MA', '02139', '6173458920', '1994-08-09', 'gemmaoliver@yahoo.com'),
('P10048', 'Brennan', 'Mcdonald', 'Hancock St', 'Quincy', 'MA', '02170', '8575473210', '1988-04-21', 'brennan.mcdonald@gmail.com'),
('P10049', 'Shayna', 'Crawford', 'Newbury St', 'Boston', 'MA', '02116', '6178903245', '1987-10-02', 'shayna.crawford@hotmail.com'),
('P10050', 'Mikayla', 'Pierce', 'Grafton St', 'Worcester', 'MA', '01604', '5086894501', '1993-05-15', 'mikayla.pierce@gmail.com'),
('P10051', 'August', 'Gutierrez', 'State St', 'Springfield', 'MA', '01109', '4137621354', '1986-01-28', 'august.gutierrez@yahoo.com'),
('P10052', 'Jaime', 'Rios', 'Maple Ave', 'Salem', 'MA', '01970', '9786523150', '1990-09-01', 'jaimerios@gmail.com'),
('P10053', 'Ryann', 'Moore', 'Main St', 'Boston', 'MA', '02360', '5083461298', '1989-03-18', 'ryannmoore@yahoo.com'),
('P10054', 'Bridger', 'Mcintyre', 'Concord St', 'Boston', 'MA', '02118', '6174237082', '1990-08-11', 'bridgermcintyre@gmail.com'),
('P10055', 'Aisha', 'Riley', 'Highland Ave', 'Cambridge', 'MA', '02139', '6173459862', '1997-04-02', 'aishariley@yahoo.com'),
('P10056', 'Dominik', 'Higgins', 'Elm St', 'Worcester', 'MA', '01602', '5087652143', '1996-02-08', 'dominikhiggins@hotmail.com'),
('P10057', 'Eva', 'Barnes', 'Main St', 'Springfield', 'MA', '01103', '4135682398', '1985-09-21', 'evabarnes@gmail.com'),
('P10058', 'Makenna', 'Cameron', 'Beacon St', 'Boston', 'MA', '02108', '6173459087', '1994-06-16', 'makennacameron@yahoo.com'),
('P10059', 'Simeon', 'Mckenzie', 'Western Ave', 'Cambridge', 'MA', '02139', '6174561234', '1990-11-28', 'simeon.mckenzie@hotmail.com'),
('P10060', 'Paisley', 'Lucas', 'Ashland St', 'Worcester', 'MA', '01608', '5087563278', '1987-07-05', 'paisley.lucas@gmail.com'),
('P10061', 'Emiliano', 'Roberts', 'Union St', 'Springfield', 'MA', '01105', '4135689823', '1993-03-19', 'emiliano.roberts@yahoo.com'),
('P10062', 'Myah', 'Hartman', 'Tremont St', 'Boston', 'MA', '02116', '6174232190', '1996-01-10', 'myah.hartman@hotmail.com'),
('P10063', 'Kamari', 'Gordon', 'Cambridge St', 'Cambridge', 'MA', '02141', '6173457890', '1985-12-13', 'kamari.gordon@gmail.com'),
('P10064', 'Mae', 'Fisher', 'Harrison Ave', 'Boston', 'MA', '02111', '8573368956', '1991-09-25', 'maefisher@yahoo.com'),
('P10065', 'Nylah', 'Freeman', 'Belmont St', 'Worcester', 'MA', '01610', '5082452301', '1986-05-28', 'nylah.freeman@gmail.com'),
('P10066', 'Kody', 'Mcbride', 'Chestnut St', 'Springfield', 'MA', '01109', '4137621089', '1997-02-11', 'kody.mcbride@hotmail.com'),
('P10067', 'Marisol', 'Lawrence', 'Commonwealth Ave', 'Boston', 'MA', '02116', '6174565432', '1994-08-03', 'marisol.lawrence@yahoo.com'),
('P10068', 'Janae', 'Morales', 'Belmont St', 'Lowell', 'MA', '01851', '9782345678', '1988-09-02', 'janaemorales@hotmail.com'),
('P10069', 'Weston', 'Kim', 'Tremont St', 'Boston', 'MA', '02116', '6174567890', '1991-07-25', 'westonkim@gmail.com'),
('P10070', 'Lena', 'Nguyen', 'Centre St', 'Quincy', 'MA', '02169', '8576543210', '1999-02-14', 'lenanguyen@yahoo.com'),
('P10071', 'Ashlyn', 'Gonzales', 'Union St', 'Boston', 'MA', '01841', '9781234567', '1995-04-06', 'ashlyngonzales@gmail.com'),
('P10072', 'Edgar', 'Mendez', 'Congress St', 'Boston', 'MA', '02109', '6172345678', '1986-12-15', 'edgar.mendez@yahoo.com'),
('P10073', 'Averie', 'Garcia', 'Shawmut Ave', 'Boston', 'MA', '02118', '6179876543', '1994-08-21', 'averiegarcia@hotmail.com'),
('P10074', 'Daxton', 'Martinez', 'Main St', 'Boston', 'MA', '01702', '5083456789', '1997-06-08', 'daxtonmartinez@gmail.com'),
('P10075', 'Lilliana', 'Hernandez', 'Pine St', 'Boston', 'MA', '02740', '5089876543', '1989-01-30', 'lillianahernandez@yahoo.com'),

('P10076', 'Kellen', 'Dixon', 'Columbia St', 'Worcester', 'MA', '01602', '5082931087', '1993-09-26', 'kellendixon@yahoo.com'),
('P10077', 'Amina', 'Garcia', 'Highland Ave', 'Springfield', 'MA', '01109', '4136591042', '1999-06-10', 'aminagarcia@hotmail.com'),
('P10078', 'Efrain', 'Sanchez', 'Brookline St', 'Cambridge', 'MA', '02139', '6174562398', '1986-05-01', 'efrain.sanchez@gmail.com'),
('P10079', 'Harper', 'Miller', 'Cottage St', 'Quincy', 'MA', '02169', '8573367123', '1988-09-16', 'harper.miller@yahoo.com'),
('P10080', 'Raquel', 'Ramos', 'South St', 'Boston', 'MA', '02111', '6178903245', '1995-08-21', 'raquel.ramos@gmail.com'),
('P10081', 'Blaine', 'Watts', 'West St', 'Worcester', 'MA', '01605', '5086894502', '1997-04-03', 'blaine.watts@hotmail.com'),
('P10082', 'Yareli', 'Castillo', 'Chestnut St', 'Springfield', 'MA', '01108', '4135687215', '1992-12-20', 'yareli.castillo@yahoo.com'),
('P10083', 'Maximilian', 'Scott', 'Harvard St', 'Cambridge', 'MA', '02138', '6173458921', '1990-02-18', 'maximilian.scott@gmail.com'),
('P10084', 'Toby', 'Barnes', 'Broadway', 'Quincy', 'MA', '02169', '8575473211', '1984-11-30', 'toby.barnes@yahoo.com'),
('P10085', 'Heidi', 'Murphy', 'Newbury St', 'Boston', 'MA', '02116', '6174587393', '1996-07-11', 'heidi.murphy@gmail.com'),
('P10086', 'Kenya', 'Gonzales', 'Central St', 'Worcester', 'MA', '01609', '5082931088', '1989-03-24', 'kenyagonzales@hotmail.com'),
('P10087', 'Vance', 'Ford', 'Orange St', 'Springfield', 'MA', '01105', '4136591043', '1987-12-09', 'vance.ford@yahoo.com'),

('P10088', 'Kaitlyn', 'Sanchez', 'Hampshire St', 'Cambridge', 'MA', '02139', '6174823167', '1992-07-19', 'kaitlynsanchez@yahoo.com'),
('P10089', 'Keegan', 'Nguyen', 'Central St', 'Worcester', 'MA', '01605', '5086749082', '1998-03-09', 'keegan.nguyen@gmail.com'),
('P10090', 'Abby', 'Price', 'Maple St', 'Springfield', 'MA', '01103', '4136782056', '1986-09-21', 'abbyprice@hotmail.com'),
('P10091', 'Charlie', 'Lee', 'Commonwealth Ave', 'Boston', 'MA', '02215', '6177654983', '1993-02-14', 'charlie.lee@gmail.com'),
('P10092', 'Adalyn', 'Foster', 'Main St', 'Quincy', 'MA', '02169', '8572786145', '1989-11-29', 'adalynfoster@yahoo.com'),
('P10093', 'Brycen', 'Chavez', 'Bow St', 'Cambridge', 'MA', '02138', '6174961734', '1997-08-12', 'brycenchavez@gmail.com'),
('P10094', 'Ryann', 'Sullivan', 'Lake Ave', 'Worcester', 'MA', '01603', '5089247612', '1984-04-17', 'ryannsullivan@hotmail.com'),
('P10095', 'Leland', 'Mendez', 'State St', 'Springfield', 'MA', '01109', '4137361982', '1991-01-07', 'lelandmendez@yahoo.com'),
('P10096', 'Leia', 'Kim', 'Storrow Dr', 'Boston', 'MA', '02114', '6173654201', '1998-07-20', 'leiakim@gmail.com'),
('P10097', 'Griffin', 'Peters', 'Belmont St', 'Worcester', 'MA', '01610', '5083456812', '1985-03-05', 'griffinpeters@yahoo.com'),
('P10098', 'Allie', 'Gonzalez', 'Main St', 'Springfield', 'MA', '01103', '4138521076', '1992-10-22', 'allie.gonzalez@gmail.com'),
('P10099', 'Collin', 'Cunningham', 'Massachusetts Ave', 'Cambridge', 'MA', '02139', '6177842309', '1987-06-08', 'collincunningham@yahoo.com'),
('P10100', 'Gracelyn', 'Wheeler', 'High St', 'Quincy', 'MA', '02169', '8575473106', '1994-02-19', 'gracelyn.wheeler@gmail.com'),
('P10101', 'Emiliano', 'Vargas', 'Storrow Dr', 'Boston', 'MA', '02116', '6174967890', '1991-05-13', 'emilianovargas@hotmail.com'),

('P10102', 'Eliana', 'Liu', 'Beacon St', 'Boston', 'MA', '02108', '6173450903', '1993-08-11', 'eliana.liu@gmail.com'),
('P10103', 'Maximus', 'Hayes', 'Washington St', 'Boston', 'MA', '02118', '6172340982', '1989-11-28', 'maximushayes@yahoo.com'),
('P10104', 'Violet', 'Mcdonald', 'Columbus Ave', 'Boston', 'MA', '02116', '6175679801', '1992-04-09', 'violetmcdonald@gmail.com'),
('P10105', 'Enrique', 'Cruz', 'Cambridge St', 'Cambridge', 'MA', '02141', '6174568732', '1986-07-06', 'enrique.cruz@hotmail.com'),
('P10106', 'Jovanny', 'Foster', 'Belmont St', 'Worcester', 'MA', '01609', '5083420987', '1994-12-21', 'jovannyfoster@yahoo.com'),
('P10107', 'Sofia', 'Sullivan', 'Maple St', 'Springfield', 'MA', '01103', '4138750932', '1997-09-18', 'sofiasullivan@gmail.com'),
('P10108', 'Kole', 'Garza', 'Hancock St', 'Quincy', 'MA', '02169', '8573982016', '1988-02-14', 'kolegarza@hotmail.com'),
('P10109', 'Zaid', 'Howell', 'Harvard St', 'Cambridge', 'MA', '02138', '6173457890', '1991-05-27', 'zaidhowell@gmail.com'),
('P10110', 'Averi', 'Bradley', 'Beacon St', 'Boston', 'MA', '02116', '6174562309', '1990-10-14', 'averi.bradley@yahoo.com'),
('P10111', 'Aryan', 'Fleming', 'Washington St', 'Boston', 'MA', '02118', '6174560913', '1996-08-07', 'aryanfleming@gmail.com'),
('P10112', 'Gabrielle', 'Hunter', 'Columbus Ave', 'Boston', 'MA', '02116', '6172349087', '1987-12-25', 'gabriellehunter@yahoo.com'),
('P10113', 'Emery', 'Dixon', 'State St', 'Springfield', 'MA', '01109', '4133457865', '1993-02-17', 'emery.dixon@gmail.com'),
('P10114', 'Kamila', 'Baker', 'Grafton St', 'Worcester', 'MA', '01604', '5088903451', '1989-09-10', 'kamila.baker@hotmail.com'),

('P10115', 'Ariana', 'Marshall', 'Harrison Ave', 'Boston', 'MA', '02111', '6173458721', '1996-12-05', 'arianamarshall@yahoo.com'),
('P10116', 'Samantha', 'Mcguire', 'Parker St', 'Worcester', 'MA', '01610', '5086782341', '1991-07-18', 'samanthamcguire@hotmail.com'),
('P10117', 'Kamari', 'Peterson', 'Main St', 'Springfield', 'MA', '01103', '4135681092', '1989-02-09', 'kamaripeterson@gmail.com'),
('P10118', 'Eliana', 'Ramirez', 'Gardner St', 'Cambridge', 'MA', '02139', '6174568790', '1988-06-27', 'elianaramirez@yahoo.com'),
('P10119', 'Luka', 'Barnes', 'Quincy St', 'Quincy', 'MA', '02170', '8572431098', '1998-11-03', 'luka.barnes@gmail.com'),

('P10120', 'Jaidyn', 'Liu', 'Main St', 'Cambridge', 'MA', '02138', '6172351098', '1923-09-22', 'jaidynliu@gmail.com'),
('P10121', 'Mona', 'Northeast', 'Narrow St', 'Quincy', 'MA', '02170', '6156651098', '1930-09-22', 'monadidi@ymail.com');

select * from Person;



ALTER TABLE DONOR ALTER COLUMN CONSENTSTATUS VARCHAR(25)

INSERT INTO Donor(DonorID, PersonID, No_of_Organs, BloodType, TissueType, DonorType, ConsentStatus, Height, Weight, Medical_Checkup_Date)
VALUES ('DN1001', 'P10002', 2, 'A', 'tissue3', 'Alive', 'Consent Given', 175, 75, '2022-01-01'),
       ('DN1002', 'P10005', 1, 'O', 'tissue5', 'Deceased', 'Consent Given', 165, 60, '2021-12-01'),
       ('DN1003', 'P10006', 1, 'AB', 'tissue5', 'Alive', 'Consent Not Given', 185, 90, '2022-02-15'),
       ('DN1004', 'P10009', 2, 'B', 'tissue3', 'Deceased', 'Consent Given', 170, 70, '2022-03-01'),
       ('DN1005', 'P10011', 1, 'A', 'tissue1', 'Alive', 'Consent Given', 160, 55, '2021-11-15'),
       ('DN1006', 'P10014', 1, 'O', 'tissue6', 'Deceased', 'Consent Given', 180, 80, '2022-04-01'),
       ('DN1007', 'P10016', 1, 'B', 'tissue2', 'Alive', 'Consent Not Given', 175, 75, '2022-02-01'),
       ('DN1008', 'P10019', 2, 'AB', 'tissue6', 'Deceased', 'Consent Given', 185, 90, '2021-12-15'),
       ('DN1009', 'P10021', 1, 'A', 'tissue3', 'Alive', 'Consent Not Given', 165, 60, '2022-03-15'),
       ('DN1010', 'P10024', 3, 'B', 'tissue4', 'Deceased', 'Consent Given', 175, 70, '2022-01-15'),
       ('DN1011', 'P10028', 3, 'O', 'tissue1', 'Alive', 'Consent Given', 170, 65, '2022-04-15'),
       ('DN1012', 'P10031', 3, 'A', 'tissue2', 'Deceased', 'Consent Given', 175, 80, '2022-02-15'),
       ('DN1013', 'P10035', 1, 'AB', 'tissue4', 'Alive', 'Consent Not Given', 180, 85, '2021-11-01'),
       ('DN1014', 'P10038', 1, 'O', 'tissue1', 'Deceased', 'Consent Given', 170, 70, '2022-03-01'),
       ('DN1015', 'P10040', 2, 'O', 'tissue1', 'Alive', 'Consent Not Given', 165, 55, '2022-01-01'),
       ('DN1016', 'P10042', 3, 'A', 'tissue1', 'Deceased', 'Consent Given', 175, 75, '2022-02-01'),
       ('DN1017', 'P10047', 3, 'B', 'tissue5', 'Alive', 'Consent Given', 180, 80, '2021-12-01'),
       ('DN1018', 'P10050', 2, 'AB', 'tissue6', 'Deceased', 'Consent Given', 165, 60, '2022-04-01'),
       ('DN1019', 'P10052', 1, 'O', 'tissue6', 'Alive', 'Consent Given', 175, 70, '2022-02-15'),
       ('DN1020', 'P10055', 1, 'A', 'tissue3', 'Deceased', 'Consent Given', 170, 65, '2021-11-15'),
       ('DN1021', 'P10058', 2, 'AB', 'tissue6', 'Alive', 'Consent Not Given', 175, 80,'2021-09-08'),
       ('DN1022', 'P10060', 2, 'AB', 'tissue4', 'Alive', 'Consent Given', 175, 70, '2022-02-01'),
       ('DN1023', 'P10063', 4, 'A', 'tissue5', 'Deceased', 'Consent Given', 170, 65, '2022-03-01'),
       ('DN1024', 'P10069', 4, 'B', 'tissue3', 'Alive', 'Consent Given', 165, 60, '2022-04-01'),
       ('DN1025', 'P10072', 2, 'B', 'tissue2', 'Deceased', 'Consent Given', 180, 80, '2022-01-01'),
       ('DN1026', 'P10076', 3, 'O', 'tissue1', 'Alive', 'Consent Not Given', 175, 75, '2022-02-15'),
       ('DN1027', 'P10079', 2, 'AB', 'tissue5', 'Deceased', 'Consent Given', 165, 55, '2021-12-15'),
       ('DN1028', 'P10081', 2, 'A', 'tissue1', 'Alive', 'Consent Given', 170, 70, '2022-03-15'),
       ('DN1029', 'P10084', 3, 'A', 'tissue3', 'Deceased', 'Consent Given', 175, 80, '2022-04-15'),
       ('DN1030', 'P10086', 1, 'AB', 'tissue2', 'Alive', 'Consent Given', 180, 85, '2022-01-15'),
       ('DN1031', 'P10089', 1, 'O', 'tissue1', 'Deceased', 'Consent Given', 170, 70, '2022-02-15'),
       ('DN1032', 'P10091', 2, 'B', 'tissue3', 'Alive', 'Consent Not Given', 175, 75, '2021-11-01'),
       ('DN1033', 'P10093', 3, 'AB', 'tissue2', 'Deceased', 'Consent Given', 165, 60, '2022-03-01'),
       ('DN1034', 'P10097', 2, 'O', 'tissue4', 'Alive', 'Consent Given', 175, 70, '2022-02-01'),
       ('DN1035', 'P10100', 2, 'A', 'tissue6', 'Deceased', 'Consent Given', 170, 65, '2021-12-01');

SELECT * FROM Donor
GO


INSERT INTO Recipient (RecipientID, PersonID, Insurance_Number, BloodType, TissueType, Height, Weight)
VALUES ('RP1001', 'P10003', 123456, 'A', 'tissue1', 175, 75),
       ('RP1002', 'P10004', 234567, 'O', 'tissue5', 180, 80),
       ('RP1003', 'P10007', 345678, 'AB', 'tissue5', 185, 90),
        ('RP1004', 'P10008', 456789, 'AB', 'tissue5', 175, 75),
        ('RP1005', 'P10010', 567890, 'B', 'tissue1', 170, 70),
        ('RP1006', 'P10012', 678901, 'O', 'tissue4', 160, 60),
        ('RP1007', 'P10013', 789012, 'A', 'tissue3', 180, 80),
        ('RP1008', 'P10015', 890123, 'B', 'tissue1', 165, 55),
        ('RP1009', 'P10017', 901234, 'B', 'tissue2', 175, 75),
        ('RP1010', 'P10018', 123450, 'A', 'tissue3', 175, 70),
        ('RP1011', 'P10022', 234561, 'A', 'tissue3', 165, 60),
        ('RP1012', 'P10023', 345672, 'AB', 'tissue2', 165, 65),
        ('RP1013', 'P10025', 456783, 'B', 'tissue4', 170, 80),
        ('RP1014', 'P10027', 567894, 'O', 'tissue1', 175, 55),
        ('RP1015', 'P10029', 678905, 'A', 'tissue2', 160, 70),
        ('RP1016', 'P10030', 789016, 'AB', 'tissue6', 170, 75),
        ('RP1017', 'P10032', 890127, 'B', 'tissue5', 180, 80),
        ('RP1018', 'P10034', 901238, 'O', 'tissue1', 165, 55),
        ('RP1019', 'P10036', 123459, 'A', 'tissue2', 170, 70),
        ('RP1020', 'P10037', 234570, 'AB', 'tissue6', 175, 75),
        ('RP1021', 'P10039', 345681, 'B', 'tissue3', 170, 70),
        ('RP1022', 'P10041', 456792, 'O', 'tissue1', 165, 55),
        ('RP1023', 'P10043', 567803, 'A', 'tissue1', 180, 70),
        ('RP1024', 'P10045', 678914, 'AB', 'tissue4', 165, 75),
        ('RP1025', 'P10049', 789025, 'B', 'tissue1', 170, 80),
        ('RP1026', 'P10051', 890136, 'O', 'tissue2', 175, 50),
        ('RP1027', 'P10053', 901247, 'O', 'tissue6', 175, 70),
        ('RP1028', 'P10054', 123458, 'AB', 'tissue1', 165, 75),
        ('RP1029', 'P10056', 234569, 'B', 'tissue3', 170, 55),
        ('RP1030', 'P10057', 345680, 'B', 'tissue2', 175, 80),
        ('RP1031', 'P10059', 345681, 'B', 'tissue2', 170, 60),
        ('RP1032', 'P10061', 456792, 'O', 'tissue4', 160, 55),
        ('RP1033', 'P10062', 567803, 'A', 'tissue5', 180, 80),
        ('RP1034', 'P10065', 678914, 'AB', 'tissue6', 165, 65),
        ('RP1035', 'P10067', 789025, 'B', 'tissue5', 170, 60),
        ('RP1036', 'P10068', 890136, 'O', 'tissue2', 165, 60),
        ('RP1037', 'P10071', 901247, 'A', 'tissue4', 160, 60),
        ('RP1038', 'P10073', 123458, 'AB', 'tissue2', 165, 75),
        ('RP1039', 'P10077', 234569, 'AB', 'tissue4', 175, 75),
        ('RP1040', 'P10078', 345680, 'O', 'tissue2', 180, 80),
        ('RP1041', 'P10080', 345681, 'B', 'tissue4', 170, 50),
        ('RP1042', 'P10082', 456792, 'A', 'tissue1', 170, 70),
        ('RP1043', 'P10083', 567803, 'A', 'tissue2', 180, 60),
        ('RP1044', 'P10085', 678914, 'AB', 'tissue6', 165, 55),
        ('RP1045', 'P10087', 789025, 'B', 'tissue5', 170, 70),
        ('RP1046', 'P10090', 890136, 'O', 'tissue4', 175, 50),
        ('RP1047', 'P10095', 901247, 'A', 'tissue3', 160, 60),
        ('RP1048', 'P10098', 123458, 'B', 'tissue2', 165, 75);
        
select * from Recipient

GO


--UDF 2 to send Email to Recipients who are not eligible(Age above 80)

CREATE OR ALTER FUNCTION dbo.CheckEligibilityAndSendEmail (@PersonID VARCHAR(6))
RETURNS VARCHAR(1000)
AS
BEGIN
    DECLARE @EmailMessage VARCHAR(1000)
    DECLARE @Age INT
    
    -- Get the person's age from the Person table
    SELECT @Age = Age
    FROM Person
    WHERE PersonID = @PersonID
    
    IF (@Age > 80)
    BEGIN
        -- Check if the person is also listed in the Recipient table
        IF EXISTS (SELECT * FROM Recipient WHERE PersonID = @PersonID)
        BEGIN
            -- Send email to the person informing them that they are not eligible to receive an organ
            SELECT @EmailMessage = 'Dear ' + FirstName + ', '
                                 + 'Unfortunately, you are not eligible to receive an organ due to your age. '
                                 + 'Please contact your healthcare provider for more information. '
                                 + 'Thank you.'
            FROM Person
            WHERE PersonID = @PersonID

        END
    END
    
    RETURN @EmailMessage
END



GO

--Trigger 2

CREATE OR ALTER TRIGGER CheckEligibilityTrigger
ON Recipient
AFTER INSERT
AS
BEGIN
    -- Loop through the inserted rows
    DECLARE @PersonID VARCHAR(6)
    DECLARE @RowCount INT
    SET @RowCount = @@ROWCOUNT
    WHILE (@RowCount > 0)
    BEGIN
        -- Get the PersonID for the current row
        SELECT TOP 1 @PersonID = PersonID
        FROM inserted
        
        -- Call the CheckEligibilityAndSendEmail function for the current row
        DECLARE @EmailMessage VARCHAR(1000)
        SELECT @EmailMessage = dbo.CheckEligibilityAndSendEmail(@PersonID)
        
        -- Print the email message
        PRINT @EmailMessage
        
        -- Decrement the row count and move to the next row
        SET @RowCount = @RowCount - 1
    END
END

GO


INSERT INTO Recipient (RecipientID, PersonID, Insurance_Number, BloodType, TissueType, Height, Weight)
VALUES ('RP1049', 'P10120', 127658, 'AB', 'tissue2', 155, 65);
INSERT INTO Recipient (RecipientID, PersonID, Insurance_Number, BloodType, TissueType, Height, Weight)
VALUES ('RP1050', 'P10121', 337658, 'A', 'tissue2', 167, 76);




INSERT INTO OrganBank (BankID, BankName, BankContact, Street, City, State, Zip)
VALUES
('OB001', 'New England Organ Bank', '8004466362', '60 1st Ave', 'Worcester', 'MA', '01612'),
('OB002', 'LifeChoice Donor Services', '8008745215', '8 Griffin Rd N', 'Boston', 'MA', '02116'),
('OB003', 'Connecticut Organ Recovery Center', '8008745215', '920 Research Pkwy', 'Cambridge', 'MA', '02138'),
('OB004', 'Upstate New York Transplant Services', '8003380900', '1275 Broadway', 'Worcester', 'MA', '01602'),
('OB005', 'Legacy Donor Services', '5034138179', '18765 SW Boones Ferry Rd', 'Boston', 'MA', '02116'),
('OB006', 'Gift of Life Donor Program', '8003666771', '401 N 3rd St', 'Cambridge', 'MA', '02138'),
('OB007', 'Indiana Donor Network', '8003824602', '3760 Guion Rd', 'Worcester', 'MA', '01602'),
('OB008', 'Lifebanc', '8885585433', '4775 Richmond Rd', 'Boston', 'MA', '02116'),
('OB009', 'LifeShare Of The Carolinas', '8009324483', '5000 D Airport Center Pkwy', 'Cambridge', 'MA', '02138'),
('OB010', 'Mid-America Transplant', '8004812545', '1110 Highlands Plaza Dr', 'Worcester', 'MA', '01602'),
('OB011', 'New Jersey Sharing Network', '8007427365', '691 Central Ave', 'Cambridge', 'MA', '02138'),
('OB012', 'OneLegacy', '8007864077', '221 S Figueroa St', 'Boston', 'MA', '02116'),
('OB013', 'LifeCenter Northwest', '8002754677', '222 2nd Ave N', 'Springfield', 'MA', '01103'),
('OB014', 'Donor Alliance', '3033294747', '200 Spruce St', 'Springfield', 'MA', '01103'),
('OB015', 'LifeNet Health', '8008477831', '1864 Concert Dr', 'Worcester', 'MA', '01602'),
('OB016', 'Lifesharing', '6195437225', '4265 Fairmount Ave', 'Springfield', 'MA', '01103'),
('OB017', 'Louisiana Organ Procurement Agency', '8005214483', '6820 Jefferson Hwy', 'Boston', 'MA', '02116'),
('OB018', 'Carolina Donor Services', '8002002672', '3621 Lyckan Pkwy', 'Springfield', 'MA', '01103'),
('OB019', 'Gift of Hope Organ Donor Network', '6307582600', '425 Spring Lake Dr', 'Worcester', 'MA', '01602'),
('OB020', 'Life Alliance Organ Recovery Agency', '8003775370', '3599 NW 79th Ave', 'Boston', 'MA', '02116');


SELECT * FROM OrganBank

INSERT INTO Organ (OrganID, DonorID, BankID, OrganType, OrganSize)
VALUES ('OR1001', 'DN1001', 'OB001', 'Kidney', 10),
       ('OR1002', 'DN1002', 'OB002', 'Liver', 15),
       ('OR1004', 'DN1004', 'OB004', 'Liver', 15),
       ('OR1005', 'DN1005', 'OB005', 'Pancrea', 30),
       ('OR1006', 'DN1006', 'OB006', 'Intestine', 35),
       ('OR1008', 'DN1008', 'OB008', 'Liver', 15),
       ('OR1010', 'DN1010', 'OB010', 'Heart', 25),
       ('OR1011', 'DN1011', 'OB011', 'Pancrea', 30),
       ('OR1012', 'DN1012', 'OB012', 'Intestine', 35),
       ('OR1014', 'DN1014', 'OB014', 'Liver', 15),
       ('OR1016', 'DN1016', 'OB016', 'Heart', 25),
       ('OR1017', 'DN1017', 'OB017', 'Pancrea', 30),
       ('OR1018', 'DN1018', 'OB018', 'Intestine', 35),
       ('OR1019', 'DN1011', 'OB019', 'Kidney', 10),
       ('OR1020', 'DN1020', 'OB020', 'Liver', 15),
       ('OR1022', 'DN1022', 'OB020', 'Heart', 25),
       ('OR1023', 'DN1023', 'OB020', 'Pancrea', 30),
       ('OR1024', 'DN1024', 'OB014', 'Intestine', 35),
       ('OR1025', 'DN1025', 'OB015', 'Kidney', 10),
       ('OR1027', 'DN1027', 'OB017', 'Lung', 20),
       ('OR1028', 'DN1028', 'OB008', 'Heart', 25),
       ('OR1029', 'DN1029', 'OB009', 'Pancrea', 30),
       ('OR1030', 'DN1030', 'OB010', 'Intestine', 35),
       ('OR1031', 'DN1031', 'OB011', 'Kidney', 10),
       ('OR1033', 'DN1033', 'OB013', 'Lung', 20),
       ('OR1034', 'DN1034', 'OB004', 'Heart', 25),
       ('OR1035', 'DN1035', 'OB015', 'Pancrea', 30),
       ('OR1036', 'DN1026', 'OB020', 'Kidney', 10),
       ('OR1037', 'DN1033', 'OB011', 'Liver', 15),
       ('OR1038', 'DN1018', 'OB014', 'Heart', 20),
       ('OR1039', 'DN1027', 'OB005', 'Pancrea', 30),
       ('OR1040', 'DN1010', 'OB009', 'Intestine', 35),
       ('OR1041', 'DN1021', 'OB012', 'Kidney', 11),
       ('OR1042', 'DN1032', 'OB018', 'Liver', 15),
       ('OR1043', 'DN1023', 'OB017', 'Heart', 25),
       ('OR1044', 'DN1024', 'OB016', 'Pancrea', 30),
       ('OR1045', 'DN1035', 'OB007', 'Intestine', 35),
       ('OR1046', 'DN1016', 'OB019', 'Lung', 20),
       ('OR1047', 'DN1007', 'OB001', 'Heart', 25),
       ('OR1048', 'DN1008', 'OB002', 'Pancrea', 30),
       ('OR1049', 'DN1029', 'OB003', 'Intestine', 35),
       ('OR1050', 'DN1023', 'OB004', 'Kidney', 10),
       ('OR1051', 'DN1001', 'OB005', 'Liver', 15),
       ('OR1052', 'DN1012', 'OB006', 'Heart', 25),
       ('OR1053', 'DN1013', 'OB007', 'Pancrea', 30),
       ('OR1054', 'DN1024', 'OB008', 'Heart', 25),
       ('OR1055', 'DN1025', 'OB009', 'Lung', 20),
       ('OR1056', 'DN1016', 'OB010', 'Liver', 15),
       ('OR1057', 'DN1017', 'OB011', 'Lung', 20),
       ('OR1058', 'DN1028', 'OB012', 'Intestine', 35),
       ('OR1059', 'DN1029', 'OB013', 'Kidney', 10),
       ('OR1060', 'DN1010', 'OB014', 'Liver', 15),
       ('OR1061', 'DN1011', 'OB015', 'Heart', 25),
       ('OR1062', 'DN1012', 'OB016', 'Pancrea', 30),
       ('OR1063', 'DN1023', 'OB017', 'Intestine', 35),
       ('OR1064', 'DN1024', 'OB018', 'Lung', 19),
       ('OR1065', 'DN1015', 'OB019', 'Heart', 25),
       ('OR1066', 'DN1026', 'OB020', 'Pancrea', 30),
       ('OR1067', 'DN1017', 'OB001', 'Intestine', 35),
       ('OR1068', 'DN1034', 'OB002', 'Kidney', 10),
       ('OR1069', 'DN1032', 'OB003', 'Intestine', 35),
       ('OR1070', 'DN1033', 'OB004', 'Heart', 25),
       ('OR1071', 'DN1021', 'OB005', 'Pancrea', 30),
       ('OR1072', 'DN1022', 'OB006', 'Intestine', 35),
       ('OR1073', 'DN1003', 'OB007', 'Lung', 20),
       ('OR1074', 'DN1004', 'OB008', 'Heart', 25),
       ('OR1075', 'DN1015', 'OB009', 'Pancrea', 30),
       ('OR1076', 'DN1026', 'OB010', 'Intestine', 35),
       ('OR1009', 'DN1009', 'OB008', 'Liver', 15),
       ('OR1077', 'DN1019', 'OB009', 'Pancrea', 30);

SELECT * FROM Organ

INSERT INTO Hospital (HospitalID, HospitalName, Street, City, State, Zip, HospitalContact)
VALUES 
('H00001', 'Massachusetts General Hospital', '55 Fruit St', 'Boston', 'MA', '02114', '6177262000'),
('H00002', 'Brigham and Women’s Hospital', '75 Francis St', 'Boston', 'MA', '02115', '6177325500'),
('H00003', 'Tufts Medical Center', '800 Washington St', 'Boston', 'MA', '02111', '6176365000'),
('H00004', 'Beth Israel Deaconess Medical Center', '330 Brookline Ave', 'Boston', 'MA', '02215', '6176677000'),
('H00005', 'Boston Children’s Hospital', '300 Longwood Ave', 'Boston', 'MA', '02115', '6173556000'),
('H00006', 'UMass Memorial Medical Center', '55 Lake Ave N', 'Worcester', 'MA', '01655', '5083341000'),
('H00007', 'St. Vincent Hospital', '123 Summer St', 'Worcester', 'MA', '01608', '5083635000'),
('H00008', 'Baystate Medical Center', '759 Chestnut St', 'Springfield', 'MA', '01199', '4137940000'),
('H00009', 'Mercy Medical Center', '271 Carew St', 'Springfield', 'MA', '01104', '4137489000'),
('H00010', 'Cambridge Health Alliance', '1493 Cambridge St', 'Cambridge', 'MA', '02139', '6176651000'),
('H00011', 'Mount Auburn Hospital', '330 Mount Auburn St', 'Cambridge', 'MA', '02238', '6174923500'),
('H00012', 'Quincy Medical Center', '114 Whitwell St', 'Quincy', 'MA', '02169', '6174790810'),
('H00013', 'South Shore Hospital', '55 Fogg Rd', 'Boston', 'MA', '02190', '7816248800'),
('H00014', 'Lahey Hospital & Medical Center', '41 Mall Rd', 'Boston', 'MA', '01805', '7817445100'),
('H00015', 'Newton-Wellesley Hospital', '2014 Washington St', 'Boston', 'MA', '02462', '6172436000'),
('H00016', 'Beverly Hospital', '85 Herrick St', 'Boston', 'MA', '01915', '9789223000'),
('H00017', 'Lawrence General Hospital', '1 General St', 'Boston', 'MA', '01841', '9786834000'),
('H00018', 'Lowell General Hospital', '295 Varnum Ave', 'Boston', 'MA', '01854', '9789376000'),
('H00019', 'Norwood Hospital', '800 Washington St', 'Boston', 'MA', '02062', '7817694000'),
('H00020', 'Milford Regional Medical Center', '14 Prospect St', 'Boston', 'MA', '01757', '5084731190');

SELECT * from Hospital

INSERT INTO Doctor (DoctorID, PersonID, HospitalID, specialization, availability, years_of_experience)
VALUES
('DR1366','P10101', 'H00001', 'Nephrology', 'yes', 8),
('DR1367','P10102', 'H00002','Cardiology', 'yes', 10),
('DR1368','P10103', 'H00003','Hepatology', 'no', 5),
('DR1369','P10104', 'H00004','Pulmonology', 'yes', 7),
('DR1370','P10105', 'H00005','Endocrinology', 'yes', 12),
('DR1371','P10106', 'H00006','Gastroenterology', 'no', 9),
('DR1372','P10107', 'H00007','Nephrology', 'yes', 15),
('DR1373','P10108', 'H00008','Cardiology', 'yes', 6),
('DR1374','P10109', 'H00009','Hepatology', 'no', 3),
('DR1375','P10110', 'H00010','Pulmonology', 'yes', 11),
('DR1376','P10111', 'H00011','Endocrinology', 'yes', 9),
('DR1377','P10112', 'H00012','Gastroenterology', 'no', 4),
('DR1378','P10113', 'H00013','Nephrology', 'yes', 14),
('DR1379','P10114', 'H00014','Cardiology', 'yes', 7),
('DR1380','P10115', 'H00015','Hepatology', 'no', 2),
('DR1381','P10116', 'H00016','Pulmonology', 'yes', 13),
('DR1382','P10117', 'H00017','Endocrinology', 'yes', 8),
('DR1383','P10118', 'H00018','Gastroenterology', 'no', 6),
('DR1384','P10119', 'H00019','Nephrology', 'yes', 11);

select * from Doctor

INSERT INTO Examination (ExaminationID, RecipientID, DoctorID, HospitalID, OrganRequired, ExaminationDate, RecipientOrganSize, UrgencyLevel)
VALUES
('EX0001', 'RP1001', 'DR1366', 'H00001', 'Kidney', '2023-04-07', 10, 'High'),
('EX0002', 'RP1002', 'DR1368', 'H00002', 'Liver', '2023-04-08', 15, 'Low'),
('EX0003', 'RP1003', 'DR1369', 'H00003', 'Lung', '2023-04-09', 20, 'High'),
('EX0004', 'RP1004', 'DR1367', 'H00004', 'Heart', '2023-04-10', 25, 'Low'),
('EX0005', 'RP1005', 'DR1370', 'H00005', 'Pancrea', '2023-04-11', 30, 'High'),
('EX0006', 'RP1006', 'DR1371', 'H00006', 'Intestine', '2023-04-12', 35, 'Low'),
('EX0007', 'RP1007', 'DR1378', 'H00007', 'Kidney', '2023-04-13', 10, 'High'),
('EX0008', 'RP1008', 'DR1380', 'H00008', 'Liver', '2023-04-14', 15, 'Low'),
('EX0009', 'RP1009', 'DR1375', 'H00009', 'Lung', '2023-04-15', 20, 'High'),
('EX0010', 'RP1010', 'DR1373', 'H00010', 'Heart', '2023-04-16', 25, 'Low'),
('EX0011', 'RP1011', 'DR1376', 'H00011', 'Pancrea', '2023-04-17', 30, 'High'),
('EX0012', 'RP1012', 'DR1377', 'H00012', 'Intestine', '2023-04-18', 35, 'Low'),
('EX0013', 'RP1013', 'DR1378', 'H00013', 'Kidney', '2023-04-19', 8, 'High'),
('EX0014', 'RP1014', 'DR1374', 'H00014', 'Liver', '2023-04-20', 15, 'Low'),
('EX0015', 'RP1015', 'DR1381', 'H00015', 'Lung', '2023-04-21', 19, 'High'),
('EX0016', 'RP1016', 'DR1379', 'H00016', 'Heart', '2023-04-22', 20, 'High'),
('EX0017', 'RP1017', 'DR1382', 'H00017', 'Pancrea', '2023-04-23', 6, 'High'),
('EX0018', 'RP1018', 'DR1383', 'H00018', 'Intestine', '2023-04-24', 35, 'High'),
('EX0019', 'RP1019', 'DR1384', 'H00019', 'Kidney', '2023-04-25', 11, 'High'),
('EX0020', 'RP1020', 'DR1384', 'H00020', 'Kidney', '2022-05-25', 11, 'High'),
('EX0021', 'RP1021', 'DR1381', 'H00015', 'Lung', '2022-04-21', 19, 'High');

SELECT * FROM Examination

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES ('RQ1001', 'H00001', 'OB001', 'EX0002', 'Requested', '2023-04-08');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1002', 'H00001', 'OB002', 'EX0003', 'Requested', '2022-08-08');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1003', 'H00001', 'OB002', 'EX0007', 'Requested', '2021-04-09');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1004', 'H00002', 'OB002', 'EX0012', 'Requested', '2019-04-10');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1005', 'H00002', 'OB003', 'EX0011', 'Requested', '2020-05-11');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1006', 'H00004', 'OB003', 'EX0014', 'Requested', '2021-06-01');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1007', 'H00006', 'OB002', 'EX0016', 'Requested', '2020-05-12');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1008', 'H00002', 'OB003', 'EX0018', 'Requested', '2022-07-18');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1009', 'H00003', 'OB004', 'EX0005', 'Requested', '2019-05-11');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1010', 'H00002', 'OB006', 'EX0020', 'Requested', '2022-09-15');

INSERT INTO Request (RequestID, HospitalID, BankID, ExaminationID, RequestStatus, RequestDate)
VALUES('RQ1011', 'H00004', 'OB006', 'EX0021', 'Requested', '2023-08-16');

SELECT * FROM Request


GO

-- Views

CREATE VIEW Donor_Organ_View AS
SELECT d.DonorID, d.No_of_Organs, d.BloodType, o.OrganType
FROM Donor d
JOIN Organ o ON d.DonorID = o.DonorID;

GO

CREATE VIEW Donor_Count_View AS
SELECT BloodType, COUNT(*) AS Donor_Count
FROM Donor
GROUP BY BloodType;

GO
CREATE VIEW Recipient_Examination_View AS
SELECT r.RecipientID, e.ExaminationID, r.BloodType, r.TissueType, e.OrganRequired, e.RecipientOrganSize
FROM Recipient r
JOIN Examination e ON r.RecipientID = e.RecipientID;

GO

CREATE VIEW Donor_by_City AS
SELECT COUNT(d.DonorID) AS NumberofDonors, p.City
FROM Person p
JOIN Donor d ON p.PersonID=d.PersonID
GROUP BY p.City;

GO

CREATE VIEW Recipient_by_City AS
SELECT COUNT(r.RecipientID) AS NumberofRecipients, p.City
FROM Person p
JOIN Recipient r ON p.PersonID=r.PersonID
GROUP BY p.City;

GO

CREATE VIEW Doctor_by_City AS
SELECT COUNT(dr.DoctorID) AS NumberofDoctors, p.City
FROM Person p
JOIN Doctor dr ON p.PersonID=dr.PersonID
GROUP BY p.City;

GO

CREATE VIEW Hospital_by_City AS
SELECT COUNT(HospitalID) AS NumberofHospitals, City
FROM Hospital
GROUP BY City;

GO

CREATE VIEW OrganTypeCounts AS
SELECT BankID, OrganType, COUNT(*) AS OrganTypeCount
FROM Organ
GROUP BY BankID, OrganType;

GO

SELECT * FROM Donor_Count_View

SELECT * FROM Donor_Organ_View

SELECT * FROM Recipient_Examination_View

SELECT * FROM Donor_by_City

SELECT * FROM Recipient_by_City

SELECT * FROM Doctor_by_City

SELECT * FROM Hospital_by_City

SELECT * FROM OrganTypeCounts

GO

--Stored Procedure 1

CREATE OR ALTER PROCEDURE FindMatchingOrgan @RequestID VARCHAR(6)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @OrganRequired CHAR(10)
DECLARE @OrganSize INT
DECLARE @RecipientBloodType CHAR(2)
DECLARE @RecipientTissueType VARCHAR(40)
DECLARE @OrganID VARCHAR(6)
DECLARE @RecipientID VARCHAR(6) 
DECLARE @MatchFound INT = 0;

select @RequestID AS RequestID

SELECT @RecipientID = e.RecipientID, @OrganRequired = e.OrganRequired, @OrganSize = e.RecipientOrganSize, @RecipientBloodType = r.BloodType, @RecipientTissueType = r.TissueType
FROM Examination e
JOIN Recipient r ON e.RecipientID = r.RecipientID
JOIN Request rq ON e.ExaminationID = rq.ExaminationID AND rq.RequestID=@RequestID

SELECT TOP 1 @OrganID = o.OrganID
FROM Organ o
JOIN Donor d ON o.DonorID = d.DonorID
WHERE o.OrganType = @OrganRequired
AND o.OrganSize = @OrganSize
AND d.BloodType = @RecipientBloodType
AND d.TissueType = @RecipientTissueType
ORDER BY o.OrganSize

SELECT @MatchFound=COUNT(o.OrganID)
FROM Organ o
JOIN Donor d ON o.DonorID = d.DonorID
WHERE o.OrganType = @OrganRequired
AND o.OrganSize = @OrganSize
AND d.BloodType = @RecipientBloodType
AND d.TissueType = @RecipientTissueType

select @OrganID
SELECT @OrganRequired, @OrganSize, @RecipientBloodType, @RecipientTissueType
IF @MatchFound > 0
    BEGIN
    SELECT @RequestID
        SET @MatchFound = 1;
        INSERT INTO Transplant (RequestID, OrganID, TransplantDate) VALUES (@RequestID, @OrganID, GETDATE())
    END
    
    IF @MatchFound = 0
    BEGIN
        PRINT 'No matching organ found.';
        UPDATE Request
        SET RequestStatus = 'Requested'
        WHERE RequestID = @RequestID;
    END

select @OrganID

END


GO

--Trigger 3

CREATE OR ALTER TRIGGER UpdateRequestStatus ON Request
AFTER UPDATE
AS
BEGIN
  IF UPDATE(RequestStatus) -- check if RequestStatus column is being updated
  BEGIN
    DECLARE @RequestID VARCHAR(6)
    DECLARE @RequestStatus VARCHAR(20)
    SELECT @RequestID = RequestID, @RequestStatus = RequestStatus
    FROM inserted
    IF @RequestStatus = 'Approved' -- check if the new status is 'Approved'
    BEGIN
      EXEC FindMatchingOrgan @RequestID -- execute the stored procedure to find matching organizations
    END
  END
END

GO




--Stored Procedure 2

ALTER TABLE Organ ADD OrganStatus VARCHAR(50);
GO

CREATE OR ALTER PROCEDURE UpdateOrganStatusAfterTransplant @OrganID VARCHAR(6)
AS
BEGIN
    -- Check if the organ is present in the Organ table
    IF NOT EXISTS (SELECT * FROM Organ WHERE OrganID = @OrganID)
    BEGIN
        PRINT 'Organ not found'
    END
    
    -- Check if the organ has already been transplanted
    IF EXISTS (SELECT * FROM Transplant  WHERE OrganID = @OrganID) 
    BEGIN
        PRINT 'Organ has already been transplanted'
    
    
    -- Add/update the status column in the Organ table
    UPDATE Organ SET OrganStatus = 'Organ Transplant Completed' WHERE OrganID = @OrganID;
    END
END
GO


--Trigger 4

CREATE OR ALTER TRIGGER UpdateOrganStatus ON Transplant
AFTER INSERT
AS
BEGIN
    DECLARE @OrganID VARCHAR(6);
    
    -- Get the OrganID from the inserted row
    SELECT @OrganID = inserted.OrganID FROM inserted;
    
    -- Call the UpdateOrganStatusAfterTransplant procedure
    EXEC UpdateOrganStatusAfterTransplant @OrganID;
END




GO


SELECT * FROM Request

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1001';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1002';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1003';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1004';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1005';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1006';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1007';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1008';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1009';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1010';

UPDATE Request
SET RequestStatus = 'Approved'
WHERE RequestID = 'RQ1011';


SELECT * FROM Transplant


SELECT * FROM Organ



GO



-- Stored Procedure 3

CREATE OR ALTER PROCEDURE CheckOrganReceived @RecipientID VARCHAR(6)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT t.TransplantID
        FROM Transplant t
        JOIN Request r ON t.RequestID = r.RequestID
        JOIN Examination e ON r.ExaminationID = e.ExaminationID
        JOIN Recipient rec ON e.RecipientID = rec.RecipientID
        JOIN Organ o ON t.OrganID = o.OrganID
        WHERE rec.RecipientID = @RecipientID
    )
    BEGIN
        PRINT 'Organ received by recipient.'
    END
    ELSE
    BEGIN
        PRINT 'Organ not yet received by recipient.'
    END
END

EXEC CheckOrganReceived 'RP1002'

GO


-- Encryption Decryption on Insurance Number of Recipients

SELECT * from [Recipient]
 -- ALTER TABLE [Recipient] DROP COLUMN encrypted_insurance
ALTER TABLE [Recipient] ADD encrypted_insurance VARBINARY(400);

CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Insurance1234';
-- drop master key 

-- very that master key exists
SELECT name KeyName,
  symmetric_key_id KeyID,
  key_length KeyLength,
  algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

go
--Create a self signed certificate and name it InsuranceNo
CREATE CERTIFICATE InsuranceNo  
   WITH SUBJECT = 'Recipient Insurance Number';  
GO  

-- drop CERTIFICATE InsuranceNo  

--Create a symmetric key  with AES 256 algorithm using the certificate
-- as encryption/decryption method

CREATE SYMMETRIC KEY InsuranceNo_SM 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE InsuranceNo;  
GO  
-- drop SYMMETRIC KEY InsuranceNo_SM 

--Now we are ready to encrypt the password and also decrypt

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY InsuranceNo_SM  
   DECRYPTION BY CERTIFICATE InsuranceNo;

UPDATE [Recipient] SET encrypted_insurance = EncryptByKey(Key_GUID('InsuranceNo_SM'), CONVERT(varbinary, Insurance_Number));

OPEN SYMMETRIC KEY InsuranceNo_SM  
   DECRYPTION BY CERTIFICATE InsuranceNo;  
 
   
SELECT *, 
    CONVERT(INT, DecryptByKey([encrypted_insurance])) 
    AS 'Decrypted_Insurance_No'  
    FROM dbo.Recipient;
GO