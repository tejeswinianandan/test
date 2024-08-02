-- Create Departments table
create database hospital_management_system;
use hospital_management_system;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100)
);

-- Create Doctors table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create MedicalRecords table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    RecordDate DATE,
    Description TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Create Bills table
CREATE TABLE Bills (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10, 2),
    BillDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


-- Insert sample departments
INSERT INTO Departments (DepartmentName) VALUES ('Cardiology');
INSERT INTO Departments (DepartmentName) VALUES ('Neurology');

-- Insert sample doctors
INSERT INTO Doctors (FirstName, LastName, Specialty, DepartmentID) VALUES ('John', 'Doe', 'Cardiologist', 1);
INSERT INTO Doctors (FirstName, LastName, Specialty, DepartmentID) VALUES ('Jane', 'Smith', 'Neurologist', 2);

-- Insert sample patients
INSERT INTO Patients (FirstName, LastName, DateOfBirth, PhoneNumber, Address) VALUES ('Alice', 'Johnson', '1980-05-15', '123-456-7890', '123 Elm St');
INSERT INTO Patients (FirstName, LastName, DateOfBirth, PhoneNumber, Address) VALUES ('Bob', 'Williams', '1975-11-23', '987-654-3210', '456 Oak St');

-- Insert sample appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime) VALUES (1, 1, '2024-08-01', '09:00:00');
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime) VALUES (2, 2, '2024-08-02', '14:00:00');

-- Insert sample medical records
INSERT INTO MedicalRecords (PatientID, RecordDate, Description) VALUES (1, '2024-07-15', 'Routine check-up. All vitals normal.');
INSERT INTO MedicalRecords (PatientID, RecordDate, Description) VALUES (2, '2024-07-16', 'Headache and dizziness. Prescribed medication.');

-- Insert sample bills
INSERT INTO Bills (PatientID, Amount, BillDate) VALUES (1, 150.00, '2024-07-15');
INSERT INTO Bills (PatientID, Amount, BillDate) VALUES (2, 200.00, '2024-07-16');


SELECT a.AppointmentDate, a.AppointmentTime, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE a.PatientID = 1; 
-- Replace with the specific PatientID

SELECT d.FirstName, d.LastName, d.Specialty
FROM Doctors d
JOIN Departments dept ON d.DepartmentID = dept.DepartmentID
WHERE dept.DepartmentName = 'Cardiology'; -- Replace with the specific department

SELECT p.FirstName, p.LastName, SUM(b.Amount) AS TotalAmount
FROM Bills b
JOIN Patients p ON b.PatientID = p.PatientID
GROUP BY p.PatientID;

SELECT a.AppointmentDate, a.AppointmentTime, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
WHERE a.DoctorID = 1 AND a.AppointmentDate > CURDATE(); -- Replace with the specific DoctorID

-- commit is used to save the data
commit;






