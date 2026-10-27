

# Insert value for physician
INSERT INTO Physician (physicianID, name, position, ssn)
VALUES
(4, 'David', 'Surgeon', 444444),
(5, 'Priya', 'Senior', 555555),
(6, 'Arun', 'Resident', 666666),
(7, 'Meena', 'Psychiatrist', 777777),
(8, 'Kumar', 'Intern', 888888),
(9, 'Anita', 'Chief of Medicine', 999999),
(10, 'Robert', 'Senior', 101010);

# Insert value for Department
INSERT INTO Department (deptID, name, headID)
VALUES
(704, 'Surgery', 4),
(705, 'General Medicine', 5),
(706, 'Psychiatry', 6),
(707, 'Surgery', 7),
(708, 'General Medicine', 8),
(709, 'Psychiatry', 9),
(710, 'Surgery', 10);

# Insert value for Affiliated with
INSERT INTO AffiliatedWith (physicianID, departmentID)
VALUES
(4, 704),
(5, 705),
(6, 706),
(7, 707),
(8, 708),
(9, 709),
(10, 710);


# Insert value for Procedure
INSERT INTO `Procedure` (procID, name, cost)
VALUES
(504, 'Kidney Surgery', 12000),
(505, 'Appendectomy', 5000),
(506, 'Liver Transplant', 40000),
(507, 'Eye Surgery', 3500),
(508, 'Knee Replacement', 18000),
(509, 'Heart Bypass', 25000),
(510, 'Dental Surgery', 2000);

# Insert value for Patient
INSERT INTO Patient
(patientID, ssn, name, address, dob, phone, InsuranceNumber, primaryPhysID)
VALUES
(10003, 456792, 'David Smith', '10 Oak Street', '1985-01-10', '5751111111', 104, 4),
(10004, 456793, 'Priya Kumar', '20 Pine Street', '1990-02-15', '5752222222', 105, 5),
(10005, 456794, 'Arun Raj', '30 Cedar Street', '1975-03-20', '5753333333', 106, 6),
(10006, 456795, 'Meena Devi', '40 Maple Street', '1988-04-25', '5754444444', 107, 7),
(10007, 456796, 'Kumar Rao', '50 Birch Street', '1992-05-30', '5755555555', 108, 8),
(10008, 456797, 'Anita Das', '60 Elm Street', '1980-06-05', '5756666666', 109, 9),
(10009, 456798, 'Robert Lee', '70 Ash Street', '1995-07-12', '5757777777', 110, 10);

# Insert Value for Nurses
INSERT INTO Nurse (nurseID, name, position, ssn)
VALUES
(5002, 'Jonathan', 'Nurse', 967735),
(5003, 'Emily', 'Nurse', 300001),
(5004, 'Michael', 'Nurse', 300002),
(5005, 'Sarah', 'Head Nurse', 300003),
(5006, 'Daniel', 'Nurse', 300004),
(5007, 'Jessica', 'Nurse', 300005),
(5008, 'William', 'Head Nurse', 300006),
(5009, 'Olivia', 'Nurse', 300007);
 
 
 # Insert value for Medication
INSERT INTO Medication (medID, name)
VALUES
(4, 'Paracetamol'),
(5, 'Amoxicillin'),
(6, 'Aspirin'),
(7, 'Metformin'),
(8, 'Cetirizine'),
(9, 'Omeprazole'),
(10, 'Calcium');
 
 
 # Insert value for presecribes
 
INSERT INTO Prescribes
(physicianID, patientID, medicationID, prescribedDate, dose)
VALUES
(4, 10003, 4, '2026-09-10', '500 mg'),
(5, 10004, 5, '2026-09-11', '250 mg'),
(6, 10005, 6, '2026-09-12', '100 mg'),
(7, 10006, 7, '2026-09-13', '500 mg'),
(8, 10007, 8, '2026-09-14', '10 mg'),
(9, 10008, 9, '2026-09-15', '20 mg'),
(10, 10009, 10, '2026-09-16', '600 mg');
 
 # Insert value for rooms
 
INSERT INTO Room (roomID, roomType)
VALUES
(457, 'Double'),
(458, 'Single'),
(459, 'Double'),
(460, 'Single'),
(461, 'Double'),
(462, 'Single'),
(463, 'Double');
 
 
 # Insert value for Stay
INSERT INTO Stay (stayID, patientID, roomID, startDate, endDate)
VALUES
(5001, 10003, 457, '2026-09-10', '2026-09-20'),
(5002, 10004, 458, '2026-09-11', '2026-09-21'),
(5003, 10005, 459, '2026-09-12', '2026-09-22'),
(5004, 10006, 460, '2026-09-13', '2026-09-23'),
(5005, 10007, 461, '2026-09-14', '2026-09-24'),
(5006, 10008, 462, '2026-09-15', '2026-09-25'),
(5007, 10009, 463, '2026-09-16', '2026-09-26');
    
# Insert table for undergoes
INSERT INTO Undergoes
(patientID, procedureID, stayID, procDate, physicianID, nurseID)
VALUES
(10003, 504, 5001, '2026-09-12', 4, 5003),
(10004, 505, 5002, '2026-09-13', 5, 5004),
(10005, 506, 5003, '2026-09-14', 6, 5005),
(10006, 507, 5004, '2026-09-15', 7, 5006),
(10007, 508, 5005, '2026-09-16', 8, 5007),
(10008, 509, 5006, '2026-09-17', 9, 5008),
(10009, 510, 5007, '2026-09-18', 10, 5009);
    
# Insert value for on call

INSERT INTO OnCall (nurseID, startDate, endDate)
VALUES
(5002, '2026-10-01', '2026-10-15'),
(5003, '2026-10-02', '2026-10-16'),
(5004, '2026-10-03', '2026-10-17'),
(5005, '2026-10-04', '2026-10-18'),
(5006, '2026-10-05', '2026-10-19'),
(5007, '2026-10-06', '2026-10-20'),
(5008, '2026-10-07', '2026-10-21');

INSERT INTO Nurse (nurseID, name, position, ssn)
VALUES (5002, 'Jonathan', 'Nurse', 967735);

# INsert vaLUES FOR APPOINTMENT
INSERT INTO Appointment
(appID, patientID, nurseID, physicianID, startDateTime, endDateTime)
VALUES
(903, 10003, 5003, 4, '2026-10-01 09:00:00', '2026-10-01 09:30:00'),
(904, 10004, 5004, 5, '2026-10-02 10:00:00', '2026-10-02 10:30:00'),
(905, 10005, 5005, 6, '2026-10-03 11:00:00', '2026-10-03 11:30:00'),
(906, 10006, 5006, 7, '2026-10-04 12:00:00', '2026-10-04 12:30:00'),
(907, 10007, 5007, 8, '2026-10-05 13:00:00', '2026-10-05 13:30:00'),
(908, 10008, 5008, 9, '2026-10-06 14:00:00', '2026-10-06 14:30:00'),
(909, 10009, 5009, 10, '2026-10-07 15:00:00', '2026-10-07 15:30:00');

SELECT 'Physician' AS table_name, COUNT(*) AS total FROM Physician
UNION ALL SELECT 'Department', COUNT(*) FROM Department
UNION ALL SELECT 'AffiliatedWith', COUNT(*) FROM AffiliatedWith
UNION ALL SELECT 'Procedure', COUNT(*) FROM `Procedure`
UNION ALL SELECT 'Patient', COUNT(*) FROM Patient
UNION ALL SELECT 'Nurse', COUNT(*) FROM Nurse
UNION ALL SELECT 'Medication', COUNT(*) FROM Medication
UNION ALL SELECT 'Prescribes', COUNT(*) FROM Prescribes
UNION ALL SELECT 'Room', COUNT(*) FROM Room
UNION ALL SELECT 'Stay', COUNT(*) FROM Stay
UNION ALL SELECT 'Undergoes', COUNT(*) FROM Undergoes
UNION ALL SELECT 'OnCall', COUNT(*) FROM OnCall
UNION ALL SELECT 'Appointment', COUNT(*) FROM Appointment;

INSERT INTO Appointment (appID, patientID, nurseID, physicianID, startDateTime, endDateTime)
VALUES (910, 10003, 5003, 5, '2026-10-08 09:00:00', '2026-10-08 09:30:00');

INSERT INTO Stay (stayID, patientID, roomID, startDate, endDate)
VALUES (5008, 10004, 457, '2026-09-12', '2026-09-14');