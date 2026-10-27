create database `las_palmas_medical`;
use `las_palmas_medical`;
# Physician
Create Table `Physician` (
	physicianID INT, 
    name varchar(40) not null,
    position varchar(40),
		check (
			position in ('Intern', 'Surgeon', 'Senior', 'Chief of Medicine', 'Resident',  'Psychiatrist')
		),
    ssn INT,
    primary key (physicianID)
);

# Department
Create Table `Department` (
	deptID INT ,
    name 	varchar(40),
		check (
			name in ('General Medicine', 'Surgery', 'Psychiatry')
		),
    headID INT,
    primary key (deptID),
    foreign key (headID) references Physician(physicianID)
);
# Affiliated with
Create Table `AffiliatedWith` (
	physicianID INT,
    departmentID INT,
    primary key (physicianID, departmentID),
    foreign key (physicianID) references Physician(physicianID),
	foreign key (departmentID) references Department(deptID)
);

# Procedure
Create Table `Procedure` (
	procID INT,
    name varchar(40),
    cost Real,
    primary key (procID)
);

# Patient
Create Table Patient (
	patientID Int,
    ssn Int,
    name varchar(40),
    address varchar(100),
    dob Date,
    phone varchar(16),
    InsuranceNumber Int,
    primaryPhysID INT,
    primary key (patientID),
    FOREIGN KEY (primaryPhysID) REFERENCES Physician(physicianID)
);
# Nurse
Create Table Nurse (
	nurseID int, 
    name varchar(40), 
    position varchar(40),
		check (
			position in ('Head Nurse', 'Nurse')
		),
    ssn integer,
    primary key (nurseID)
);
# Medication
Create Table Medication (
	medID integer, 
    name varchar(40),
    primary key (medID)
);
# Prescribes
Create Table Prescribes (
	physicianID integer, 
    patientID integer, 
    medicationID integer, 
    prescribedDate date, 
    dose varchar(40),
    primary key (physicianID, patientID, medicationID, prescribedDate),
    Foreign key (physicianID) references Physician(physicianID),
	Foreign key (patientID) references Patient(patientID),
	Foreign key (medicationID) references Medication(medID)
);
# Room
Create Table Room (
	roomID integer, 
    roomType varchar(40) not null,
		check (
			roomType in ('Single', 'Double')
		),
    primary key (roomID)
);

# Stay

Create Table Stay (
	stayID integer, 
    patientID integer, 
    roomID integer, 
    startDate date, 
    endDate date,
    primary key(stayID),
	Foreign key (patientID) references Patient(patientID),
    Foreign key (roomID) references Room(roomID)
);

# Undergoes
Create Table Undergoes (
	patientID integer, 
    procedureID integer, 
    stayID integer, 
    procDate date, 
    physicianID integer, 
    nurseID integer,
    primary key (patientID, procedureID, stayID, procDate),
    Foreign key (patientID) references Patient(patientID),
	Foreign key (procedureID) references `Procedure`(procID),
	Foreign key (stayID) references Stay(stayID),
	Foreign key (physicianID) references Physician(physicianID),
	Foreign key (nurseID) references Nurse(nurseID)
);

#. On call
Create Table OnCall (
	nurseID integer, 
    startDate date, 
    endDate date,
    primary key (nurseID, startDate, endDate),
	Foreign key (nurseID) references Nurse(nurseID)
);

# Appointment


Create Table Appointment (
	appID integer, 
    patientID integer, 
    nurseID integer, 
    physicianID integer, 
    startDateTime datetime, 
    endDateTime datetime,
	primary key (appID),
    Foreign key (patientID) references Patient(patientID),
    Foreign key (nurseID) references Nurse(nurseID),
    Foreign key (physicianID) references Physician(physicianID)
);

