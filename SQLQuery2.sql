create DATABASE p1;
use p1;
Create Table Insurance(
 insurance_id  varchar(50)  Primary Key,
 company_name varchar(50) NOT NULL,
 policy_number varchar(50) NOT NULL,
 coverage_percent INT 
 );
 
Create Table Patient(
patient_id varchar(50)  Primary Key,
name varchar(50) , 
gender varchar(50) check(gender IN('Male','Female')) NOT NULL, 
DateofBirth Date,
phone varchar(50) NOT NULL,
address varchar(50) NOT NULL,
insurance_id varchar(50) foreign key (insurance_id) references Insurance(insurance_id)
);
Create Table Department(
dept_id  varchar(50)  Primary Key, 
dept_name varchar(50), 
floor varchar(10),
head_doctor_id int


);
Create Table Doctor(
doctor_id  varchar(50)  Primary Key, 
name varchar(50), 
specialization varchar(50), 
phone varchar(15), 
email varchar(50), 
dept_id varchar(50) foreign key (dept_id) references Department(dept_id)
);





Create Table Appointment(
appointment_id varchar(50)  Primary Key,
patient_id varchar(50) foreign key (patient_id) references Patient(patient_id),
doctor_id  varchar(50) foreign key (doctor_id) references Doctor(doctor_id),
dept_id varchar(50) foreign key (dept_id) references Department(dept_id),
date Date , 
time Time,
status varchar(50) check(status IN('Scheduled','Completed','Cancelled')) NOT NULL

);
Create Table Prescription(
prescription_id varchar(50)  Primary Key, 
appointment_id varchar(50) foreign key (appointment_id) references Appointment(appointment_id), 
notes varchar(100), 
date_issued Date NOT NULL
);

Create Table Medication (
med_id varchar(50)  Primary Key,
name varchar(50), 
category varchar(50),
stock_qty int NOT NULL,
unit_price varchar(8)
);

Create Table Prescription_Details(
prescription_id varchar(50) foreign key (prescription_id) references Prescription(prescription_id),
med_id varchar(50) foreign key (med_id) references Medication(med_id), 
dosage varchar(10) NOT NULL,
duration varchar(50), 
quantity int NOT NULL
);
Create Table Invoice(
invoice_id  varchar(50)  Primary Key,
patient_id varchar(50) foreign key (patient_id) references Patient(patient_id), 
appointment_id varchar(50) foreign key (appointment_id) references Appointment(appointment_id),
total_amount money NOT NULL, 
date Date ,
payment_status varchar(50) check(payment_status IN ( 'Pending', 'Partially Paid', 'Paid in Full', 'Overdue', 'Written Off'))  NOT NULL);


 CREATE TABLE Rooms (
    room_id INT  PRIMARY KEY,
    daily_rate VARCHAR(10) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL
);

create table Payments(
payment_id int primary key,
amount_paid money not null,
method varchar(50) not null,
payment_date DATE not null,
invoice_id varchar(50) foreign key (invoice_id) references Invoice(invoice_id)

);

CREATE TABLE admissions(
    admission_id INT  PRIMARY KEY,
    admission_date DATE ,
    discharge_date VARCHAR(50),
    patient_id varchar(50) foreign key (patient_id) references Patient(patient_id) ,
    room_id INT FOREIGN KEY (room_id) REFERENCES rooms(room_id)
,
    
);

CREATE TABLE Lab_Test(
   test_id INT PRIMARY KEY,
    test_name VARCHAR(50) NOT NULL,
    result VARCHAR(50) NOT NULL,
    cost money NOT NULL,
    appointment_id varchar(50) FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

CREATE TABLE Lab_Technician (
    tech_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) ,
    specialization VARCHAR(100) 
);

CREATE TABLE lab_report (
    report_id INT NOT NULL PRIMARY KEY,
    report_date DATE NOT NULL,
    notes VARCHAR(255),
    tech_id INT FOREIGN KEY (tech_id) REFERENCES Lab_Technician(tech_id),
    
);


Alter Table Insurance Add   policy_status varchar(50)  check(policy_status IN('Active','Canceled','Inactive','Pending'));
Alter Table Patient ADD  emergency_contact_phone varchar(20);
Alter Table Patient ADD  ssn varchar(20) ;
Alter Table Department ADD department_status varchar(50) check(department_status IN('Active','Under Review','Inactive'));
ALter Table Doctor ADD license_number varchar(20) ;
Alter table Appointment ADD appointment_type varchar(50) check(appointment_type IN('Consultation', 'Follow-up', 'Check-up', 'Emergency', 'Procedure',' Telemedicine'));
Alter Table Prescription ADD status varchar(100) check(status IN('Active','Canceled','Completed','Expired','On Hold'));
Alter Table Medication ADD form varchar(50) check(form IN('Tablet', 'Capsule', 'Liquid', 'Cream', 'Injection'));

Alter Table Invoice  ADD payment_method varchar(50) check(payment_method IN('Cash', 'Credit Card', 'Insurance', 'Split Payment')); 
Alter Table Insurance ADD policy_start_date Date;
Alter Table Insurance ADD policy_end_date Date;
Alter Table Appointment ADD last_updated Datetime DEFAULT GETDATE();
Alter Table Medication ADD supplier VARCHAR(50);
Alter Table  Medication ADD exp_date Date;
Alter Table Medication ADD  min_stock_level INT ;
Alter Table Patient ADD inserted_by varchar(50);
ALTER TABLE lab_report 
ADD test_id INT;

ALTER TABLE lab_report 
ADD CONSTRAINT FK_Report_Test 
FOREIGN KEY (test_id) REFERENCES Lab_Test(test_id);
ALTER TABLE Rooms
ADD room_description VARCHAR(100),
    room_capacity INT;

ALTER TABLE Payments
ADD transaction_id VARCHAR(50),
    payment_status VARCHAR(50) CHECK(payment_status IN('Pending','Completed','Failed'));

ALTER TABLE Admissions
ADD admission_notes VARCHAR(255),
    admission_type VARCHAR(50) CHECK(admission_type IN('Emergency','Scheduled','Observation'));

ALTER TABLE Lab_Test
ADD lab_notes VARCHAR(255),
    lab_type VARCHAR(50) CHECK(lab_type IN('Blood','Urine','Imaging','Other'));


ALTER TABLE Lab_Technician
ADD email VARCHAR(50),
    hire_date DATE;

ALTER TABLE Lab_Report
ADD report_type VARCHAR(50),
    reviewed_by VARCHAR(50);



INSERT INTO Insurance (insurance_id, company_name, policy_number, coverage_percent, policy_status,policy_start_date,policy_end_date)
VALUES
('INS001', 'Blue Cross', 'BC-12345', 80, 'Active', '2023-01-01', '2024-12-31'),
('INS002', 'Aetna', 'AE-67890', 90, 'Active', '2023-03-15', '2024-03-14'),
('INS003', 'UnitedHealth', 'UH-11121', 70, 'Active', '2023-06-01', '2024-05-31'),
('INS004', 'Cigna', 'CG-31415', 85, 'Canceled', '2023-02-01', '2023-08-01'),
('INS005', 'Kaiser', 'KS-16171', 95, 'Active', '2023-04-10', '2024-04-09'),
('INS006', 'Humana', 'HU-81920', 75, 'Inactive', '2023-01-20', '2023-12-19'),
('INS007', 'Medicare', 'MC-21222', 100, 'Active', '2023-01-01', '2023-12-31'),
('INS008', 'Anthem', 'AN-32425', 88, 'Pending', '2024-01-01', '2024-12-31'),
('INS009', 'Blue Cross', 'BC-67890', 40, 'Active', '2025-01-01', '2027-02-03'),
('INS010', 'Aetna', 'AE-78901', 10, 'Active', '2023-03-15', '2024-03-14'),
('INS011', 'UnitedHealth', 'UH-22223', 20, 'Active', '2023-06-01', '2025-06-30'),
('INS012', 'Cigna', 'CG-41516', 12, 'Canceled', '2023-09-01', '2024-08-01');


INSERT INTO Patient (patient_id, name, gender, DateofBirth, phone, address, insurance_id, emergency_contact_phone, ssn,inserted_by)
VALUES
('PAT001', 'John Smith', 'Male', '1985-05-15', '555-123-4567', '123 Main St, Boston', 'INS001', '555-987-6543', '123-45-6789','john'),
('PAT002', 'Maria Garcia', 'Female', '1990-08-22', '555-234-5678', '456 Oak Ave, Cambridge', 'INS002', '555-876-5432', '234-56-7890','carl'),
('PAT003', 'James Wilson', 'Male', '1978-12-03', '555-345-6789', '789 Pine St, Somerville', 'INS003', '555-765-4321', '345-67-8901','darwin'),
('PAT004', 'Sarah Johnson', 'Female', '1995-03-18', '555-456-7890', '321 Elm St, Boston', 'INS004', '555-654-3210', '456-78-9012','tala'),
('PAT005', 'Robert Brown', 'Male', '1982-07-30', '555-567-8901', '654 Maple Dr, Quincy', 'INS005', '555-543-2109', '567-89-0123','Rimas'),
('PAT006', 'Lisa Davis', 'Female', '1988-11-12', '555-678-9012', '987 Birch Ln, Newton', 'INS006', '555-432-1098', '678-90-1234','smith'),
('PAT007', 'Michael Miller', 'Male', '1975-09-25', '555-789-0123', '147 Cedar Rd, Brookline', 'INS007', '555-321-0987', '789-01-2345','carl'),
('PAT008', 'Emily Taylor', 'Female', '1992-04-08', '555-890-1234', '258 Spruce Ave, Boston', 'INS008', '555-210-9876', '890-12-3456','ramon'),
('PAT009', 'mahmoud darwish', 'Male', '1982-07-30', '555-567-8901', '654 Maple Dr, Quincy', 'INS009', '502-543-2109', '111-89-0123','ruben'),
('PAT010', 'Darwin neves', 'Female', '1988-11-12', '555-678-9012', '987 Birch Ln, Newton', 'INS010', '401-432-895', '688-90-1234','sezar'),
('PAT011', 'marlen sensei', 'Male', '1975-09-25', '555-789-0123', '147 Cedar Rd, Brookline', 'INS011', '961-321-0012', '986-01-2345','elias'),
('PAT012', 'merna alahmad', 'Female', '1992-04-08', '555-890-1234', '258 Spruce Ave, Boston', 'INS012', '402-210-9545', '892-12-3456','hasan'),
('PAT013', 'mahmoud darwish', 'Male', '1982-07-30', '555-567-8901', '654 Maple Dr, Quincy',null,  '502-543-2109', '111-89-0123','Husein'),
('PAT014', 'Darwin neves', 'Female', '1988-11-12', '555-678-9012', '987 Birch Ln, Newton', null,'401-432-895', '688-90-1234','Mohamad'),
('PAT015', 'marlen sensei', 'Male', '1975-09-25', '555-789-0123', '147 Cedar Rd, Brookline',null , '961-321-0012', '986-01-2345','marlin');


INSERT INTO Department (dept_id, dept_name, floor, head_doctor_id, department_status)
VALUES
('DEPT001', 'Cardiology', '3', 1001, 'Active'),
('DEPT002', 'Orthopedics', '2', 1002, 'Active'),
('DEPT003', 'Pediatrics', '1', 1003, 'Active'),
('DEPT004', 'Neurology', '4', 1004, 'Under Review'),
('DEPT005', 'Oncology', '5', 1005, 'Active'),
('DEPT006', 'Emergency', '1', 1006, 'Active'),
('DEPT007', 'Surgery', '3', 1007, 'Active'),
('DEPT008', 'Radiology', '2', 1008, 'Inactive');

INSERT INTO Doctor (doctor_id, name, specialization, phone, email, dept_id, license_number)
VALUES
('DOC001', 'Dr. Emily Chen', 'Cardiologist', '555-1001', 'echen@hospital.com', 'DEPT001', 'LIC123456'),
('DOC002', 'Dr. Michael Brown', 'Orthopedic Surgeon', '555-1002', 'mbrown@hospital.com', 'DEPT002', 'LIC234567'),
('DOC003', 'Dr. Sarah Johnson', 'Pediatrician', '555-1003', 'sjohnson@hospital.com', 'DEPT003', 'LIC345678'),
('DOC004', 'Dr. David Wilson', 'Neurologist', '555-1004', 'dwilson@hospital.com', 'DEPT004', 'LIC456789'),
('DOC005', 'Dr. Jennifer Lee', 'Oncologist', '555-1005', 'jlee@hospital.com', 'DEPT005', 'LIC567890'),
('DOC006', 'Dr. Robert Martinez', 'Emergency Medicine', '555-1006', 'rmartinez@hospital.com', 'DEPT006', 'LIC678901'),
('DOC007', 'Dr. Amanda White', 'General Surgeon', '555-1007', 'awhite@hospital.com', 'DEPT007', 'LIC789012'),
('DOC008', 'Dr. Kevin Adams', 'Radiologist', '555-1008', 'kadams@hospital.com', 'DEPT008', 'LIC890123');

INSERT INTO Appointment (appointment_id, patient_id, doctor_id, dept_id, date, time, status, appointment_type, last_updated)
VALUES
('APP001', 'PAT001', 'DOC001', 'DEPT001', '2024-01-15', '09:00:00', 'Completed', 'Consultation', GETDATE()),
('APP002', 'PAT002', 'DOC002', 'DEPT002', '2024-01-16', '10:30:00', 'Scheduled', 'Follow-up', GETDATE()),
('APP003', 'PAT003', 'DOC003', 'DEPT003', '2024-01-17', '14:00:00', 'Completed', 'Check-up', GETDATE()),
('APP004', 'PAT004', 'DOC004', 'DEPT004', '2024-01-18', '11:15:00', 'Cancelled', 'Consultation', GETDATE()),
('APP005', 'PAT005', 'DOC005', 'DEPT005', '2024-01-19', '15:45:00', 'Scheduled', 'Procedure', GETDATE()),
('APP006', 'PAT006', 'DOC006', 'DEPT006', '2024-01-20', '08:30:00', 'Completed', 'Emergency', GETDATE()),
('APP007', 'PAT007', 'DOC007', 'DEPT007', '2024-01-21', '13:20:00', 'Scheduled', 'Consultation', GETDATE()),
('APP008', 'PAT008', 'DOC008', 'DEPT008', '2024-01-22', '16:00:00', 'Completed', 'Follow-up', GETDATE()),
('APP009', 'PAT009', 'DOC001', 'DEPT001', '2025-01-15', '08:00:00', 'Completed', 'Consultation', GETDATE()),
('APP010', 'PAT010', 'DOC002', 'DEPT002', '2024-01-16', '10:30:00', 'Scheduled', 'Follow-up', GETDATE()),
('APP011', 'PAT011', 'DOC001', 'DEPT001', '2024-08-15', '09:00:00', 'Completed', 'Consultation', GETDATE()),
('APP012', 'PAT012', 'DOC002', 'DEPT002', '2024-01-16', '11:30:00', 'Scheduled', 'Check-up', GETDATE()),
('APP013', 'PAT009', 'DOC004', 'DEPT004', '2025-01-15', '08:00:00', 'Completed', 'Consultation', GETDATE()),
('APP014', 'PAT009', 'DOC002', 'DEPT002', '2024-01-16', '10:30:00', 'Scheduled', 'Follow-up', GETDATE()),
('APP015', 'PAT010', 'DOC001', 'DEPT001', '2024-08-15', '09:00:00', 'Completed', 'Consultation', GETDATE()),
('APP016', 'PAT012', 'DOC002', 'DEPT002', '2024-01-16', '11:30:00', 'Scheduled', 'Check-up', GETDATE());


INSERT INTO Prescription (prescription_id, appointment_id, notes, date_issued, status)
VALUES
('PRES001', 'APP001', 'Take with food, avoid alcohol', '2024-01-15', 'Active'),
('PRES002', 'APP002', 'Complete full course', '2024-01-16', 'Completed'),
('PRES003', 'APP003', 'May cause drowsiness', '2024-01-17', 'Active'),
('PRES004', 'APP004', 'Take on empty stomach', '2024-01-18', 'Canceled'),
('PRES005', 'APP005', 'Refrigerate medication', '2024-01-19', 'Active'),
('PRES006', 'APP006', 'Do not operate machinery', '2024-01-20', 'Completed'),
('PRES007', 'APP007', 'Take twice daily', '2024-01-21', 'On Hold'),
('PRES008', 'APP008', 'Complete 10-day course', '2024-01-22', 'Expired');


INSERT INTO Medication (med_id, name, category, stock_qty, unit_price, form, supplier, exp_date,min_stock_level)
VALUES
('MED001', 'Amoxicillin', 'Antibiotic', 100, '15.99', 'Capsule', 'PharmaCorp', '2025-06-30',10),
('MED002', 'Lisinopril', 'Blood Pressure', 75, '12.50', 'Tablet', 'MediSupply', '2024-12-31',12),
('MED003', 'Metformin', 'Diabetes', 150, '8.75', 'Tablet', 'DrugCo', '2025-03-15',50),
('MED004', 'Atorvastatin', 'Cholesterol', 90, '22.00', 'Tablet', 'PharmaCorp', '2024-11-30',1),
('MED005', 'Albuterol', 'Asthma', 60, '18.25', 'Injection', 'MediSupply', '2025-01-20',20),
('MED006', 'Ibuprofen', 'Pain Relief', 200, '5.99', 'Tablet', 'DrugCo', '2026-02-28',20),
('MED007', 'Omeprazole', 'Acid Reducer', 120, '14.50', 'Capsule', 'PharmaCorp', '2025-08-15',30),
('MED008', 'Sertraline', 'Antidepressant', 80, '25.75', 'Tablet', 'MediSupply', '2024-10-10',14),
('MED009', 'Sertraline', 'Antidepressant', 80, '25.75', 'Tablet', 'MediSupply', '2028-10-10',15);


INSERT INTO Prescription_Details (prescription_id, med_id, dosage, duration, quantity)
VALUES
('PRES001', 'MED001', '500mg', '10 days', 20),
('PRES002', 'MED002', '10mg', '30 days', 30),
('PRES003', 'MED003', '850mg', '90 days', 90),
('PRES001', 'MED006', '400mg', '7 days', 14),
('PRES004', 'MED004', '20mg', '30 days', 30),
('PRES005', 'MED005', '2puffs', '60 days', 1),
('PRES006', 'MED007', '20mg', '30 days', 30),
('PRES007', 'MED008', '50mg', '90 days', 90);

INSERT INTO Invoice (invoice_id, patient_id, appointment_id, total_amount, date, payment_status, payment_method)
VALUES
('INV001', 'PAT001', 'APP001', 150.00, '2024-01-15', 'Paid in Full', 'Credit Card'),
('INV002', 'PAT002', 'APP002', 200.00, '2024-01-16', 'Pending', 'Insurance'),
('INV003', 'PAT003', 'APP003', 175.50, '2024-01-17', 'Partially Paid', 'Split Payment'),
('INV004', 'PAT004', 'APP004', 300.00, '2024-01-18', 'Pending', 'Insurance'),
('INV005', 'PAT005', 'APP005', 450.00, '2024-01-19', 'Overdue', 'Credit Card'),
('INV006', 'PAT006', 'APP006', 225.75, '2024-01-20', 'Paid in Full', 'Cash'),
('INV007', 'PAT007', 'APP007', 180.00, '2024-01-21', 'Pending', 'Insurance'),
('INV008', 'PAT008', 'APP008', 195.25, '2024-01-22', 'Written Off', 'Split Payment');

INSERT INTO Rooms (room_id, daily_rate, room_type, status, room_description, room_capacity)
VALUES
(101, 250, 'Private Room','Occupied','Private room with ensuite bathroom and TV', 1),
(102, 200, 'Semi-Private','Available', 'Shared room with two beds and curtain divider', 2),
(103, 300, 'ICU','Occupied',  'Intensive Care Unit with monitoring equipment', 1),
(104, 180, 'Standard','Available', 'Standard ward room with four beds', 4),
(105, 400, 'VIP Suite','Occupied','Luxury suite with living area and premium amenities', 1),
(106, 220, 'Private Room','Available', 'Private room with garden view', 1),
(107, 350, 'ICU','Occupied','ICU with ventilator support', 1),
(108, 150, 'Standard','Available', 'General ward room', 6),
(109, 250, 'Private Room','Available','Private room with ensuite bathroom and TV', 1),
(110, 200, 'Semi-Private','Available', 'Shared room with two beds and curtain divider', 2),
(112, 300, 'ICU','Available',  'Intensive Care Unit with monitoring equipment', 1),
(113, 180, 'Standard','Available', 'Standard ward room with four beds', 4);





INSERT INTO Payments (payment_id, amount_paid, method, payment_date, invoice_id, transaction_id, payment_status)
VALUES
(1, 500.00, 'Credit Card', '2024-01-15', 'INV001', 'TXN001234', 'Completed'),
(2, 250.00, 'Cash','2024-01-16', 'INV002', 'TXN001235', 'Completed'),
(3, 750.00, 'Insurance','2024-01-17', 'INV003', 'TXN001236', 'Pending'),
(4, 300.00, 'Debit Card','2024-01-18', 'INV004', 'TXN001237', 'Completed'),
(5, 450.00, 'Bank Transfer','2024-01-19', 'INV005', 'TXN001238', 'Failed'),
(6, 600.00, 'Credit Card', '2024-01-20', 'INV006', 'TXN001239', 'Completed'),
(7, 350.00, 'Cash','2024-01-21', 'INV007', 'TXN001240', 'Pending'),
(8, 800.00, 'Insurance','2024-01-22', 'INV008', 'TXN001241', 'Completed');

INSERT INTO admissions (admission_id, admission_date, discharge_date, patient_id, room_id, admission_notes, admission_type)
VALUES
(1, '2024-01-10', '2024-01-15','PAT001', 101, 'Patient admitted for routine surgery recovery', 'Scheduled'),
(2, '2024-01-12', 'Pending','PAT002', 103, 'Critical condition, requires constant monitoring', 'Emergency'),
(3, '2024-01-14', '2024-01-20','PAT003', 105, 'VIP patient with special dietary requirements', 'Scheduled'),
(4, '2024-01-16', 'Pending','PAT004', 102, 'Patient under observation for 24 hours', 'Observation'),
(5, '2024-01-18', 'Pending','PAT005', 104, 'Fever and respiratory symptoms', 'Emergency'),
(6, '2024-01-20', 'Pending','PAT006', 106, 'Post-operative care required', 'Scheduled'),
(7, '2024-01-21', 'Pending','PAT007', 107, 'Cardiac emergency, stable now', 'Emergency'),
(8, '2024-01-22', '2024-01-25', 'PAT008', 108, 'Observation for concussion', 'Observation');

INSERT INTO Lab_Test (test_id, test_name, result, cost, appointment_id, lab_notes, lab_type)
VALUES
(01, 'Blood Test','Normal',75.00,  'APP001', 'Fasting blood sample collected at 8:00 AM', 'Blood'),
(02, 'MRI Scan','Clear',500.00,  'APP002', 'Full body MRI with contrast dye', 'Imaging'),
(03, 'Urine Analysis','Abnormal',50.00,  'APP003', 'Mid-stream urine sample shows cloudiness', 'Urine'),
(04, 'X-Ray Chest','Normal',120.00,  'APP004', 'PA and lateral views taken', 'Imaging'),
(05, 'ECG','Regular',90.00,  'APP005', '12-lead ECG performed at rest', 'Other'),
(06, 'CT Scan','Normal',650.00, 'APP006', 'CT abdomen with oral contrast', 'Imaging'),
(07, 'Blood Sugar','High', 45.00, 'APP007', 'Random blood glucose test', 'Blood'),
(08, 'Ultrasound','Clear',280.00, 'APP008', 'Abdominal ultrasound after 6hr fasting', 'Imaging')
;

INSERT INTO Lab_Technician (tech_id, name, phone, specialization, email, hire_date)
VALUES
(1, 'Dr. Sarah Johnson', '555-0101', 'Hematology', 'sarah.johnson@hospital.com', '2020-03-15'),
(2, 'Mike Chen','555-0102', 'Radiology', 'mike.chen@hospital.com', '2021-06-20'),
(3, 'Emily Davis','555-0103', 'Microbiology', 'emily.davis@hospital.com', '2019-11-08'),
(4, 'Robert Wilson','555-0104', 'Pathology', 'robert.wilson@hospital.com', '2018-02-28'),
(5, 'Lisa Martinez','555-0105', 'Biochemistry', 'lisa.martinez@hospital.com', '2022-01-10'),
(6, 'Dr. James Brown','555-0106', 'Genetics', 'james.brown@hospital.com', '2023-04-12'),
(7, 'Karen White','555-0107', 'Immunology', 'karen.white@hospital.com', '2020-09-05'),
(8, 'David Lee','555-0108', 'Toxicology', 'david.lee@hospital.com', '2021-12-15');

INSERT INTO lab_report (report_id, report_date, notes, tech_id, report_type, reviewed_by,test_id)
VALUES
(1, '2024-01-15', 'Complete blood count within normal ranges', 1, 'Hematology', 'Dr. Smith',01),
(2, '2024-01-16', 'MRI shows no abnormalities detected',2, 'Radiology', 'Dr. Johnson',02),
(3, '2024-01-17', 'Urine culture positive for infection',3, 'Microbiology', 'Dr. Brown',03),
(4, '2024-01-18', 'Chest X-ray clear, no pneumonia',4, 'Radiology', 'Dr. Wilson',04),
(5, '2024-01-19', 'ECG shows normal sinus rhythm',5, 'Cardiology', 'Dr. Garcia',05),
(6, '2024-01-20', 'CT scan shows no internal injuries',6, 'Radiology', 'Dr. Chen',06),
(7, '2024-01-21', 'Blood glucose levels elevated, follow up needed',7, 'Biochemistry', 'Dr. Taylor',07),
(8, '2024-01-22', 'Abdominal ultrasound normal',8, 'Radiology', 'Dr. Martinez',08);


Update Medication set stock_qty+=50 where name='Sertraline' AND YEAR(exp_date)>'2025';

update Appointment set status='completed' where appointment_id='APP007';

update Insurance set policy_status='Active' where insurance_id='INS006';
Alter Table Medication Drop column min_stock_level;

Alter Table Patient Drop column inserted_by;



UPDATE Rooms
SET daily_rate = daily_rate + 50
WHERE room_id = 101;

UPDATE Payments
SET amount_paid = amount_paid + 100
WHERE payment_id = 1;

UPDATE Admissions
SET room_id = 102
WHERE admission_id = 1;

UPDATE Lab_Test
SET cost = cost + 20
WHERE test_id = 1;

UPDATE Lab_Technician
SET specialization = 'General Lab'
WHERE tech_id = 1;

UPDATE Lab_Report
SET tech_id = 2
WHERE report_id = 1;


--selction:
--1:each patient with their insurance company name and percent they covered
select p.patient_id,p.name ,i.company_name,i.coverage_percent
from Patient p 
inner join Insurance i ON i.insurance_id=p.insurance_id;
--2:each doctor id and name and how many appointment each doctor have
select d.doctor_id,d.name,COUNT(a.doctor_id) AS total_appof_d
from Doctor d
Inner join Appointment a ON a.doctor_id=d.doctor_id
group by d.doctor_id, d.name
;
--3:most expensive lab test
select  *
from Lab_Test l
where l.cost=(select MAX(l1.cost) from Lab_Test l1 );
--4:medication that doeasnt have any prescription
select *
From Medication l
where  NOT EXISTS (
    SELECT 1 
    From Prescription_Details p 
    Where p.med_id = l.med_id
);

--5:patient that have no insurance
select *
from Patient p
where p.insurance_id is null;

--6:count appointment of patient that has more than 1 appointment
SELECT p.patient_id, p.name,p.gender,COUNT(a.appointment_id) AS total_appointments
FROM Patient p
JOIN Appointment a 
    ON p.patient_id = a.patient_id
GROUP BY 
    p.patient_id,p.name, p.gender
HAVING COUNT(a.appointment_id) > 1;

--7:THE DOCTOR THAT HAVE THE HIGHEST COMPLETED APPOINTMENT 
select d.doctor_id ,d.name ,COUNT(a.appointment_id)
from Doctor d
join Appointment a ON d.doctor_id=a.doctor_id
where a.status='Completed'
group by d.doctor_id,d.name
HAVING COUNT(a.appointment_id) = (
    SELECT MAX(appointment_count)
    FROM (
        SELECT COUNT(appointment_id) as appointment_count
        FROM Appointment
        WHERE status = 'Completed'
        GROUP BY doctor_id
    ) as counts);
	--8:all medications that are about to expire (within 30 days) and their current stock quantity.
	select m.med_id,m.name,m.stock_qty
	from Medication m
	where  DATEDIFF(day, GETDATE(), exp_date) BETWEEN 0 AND 30
;

--9:patients who have both appointments and admissions records.
SELECT p.*
FROM Patient p
WHERE EXISTS (SELECT 1 FROM Appointment a WHERE a.patient_id = p.patient_id)
  AND EXISTS (SELECT 1 FROM admissions s WHERE s.patient_id = p.patient_id);
--10:Calculate the total amount paid for each payment method.
select p.method,SUM(p.amount_paid) as totalpayed
From Payments p
group by p.method;

--11:rooms that have never been occupied in any admission.
SELECT *
FROM Rooms r
WHERE NOT EXISTS (
    SELECT 1 
    FROM admissions a 
    WHERE a.room_id = r.room_id
);
--12:doctors along with their department names and floor numbers
select *,dp.dept_name,dp.floor
from Doctor d 
join Department dp ON d.dept_id=dp.dept_id
 ;

 --13:the average cost of lab tests for each lab type
 select l.lab_type,AVG(l.cost)
 from Lab_Test l
 group by l.lab_type;

 --14:patients who have invoices with payment status 'Pending' or 'Overdue'
 select *
 from Patient p
 join Invoice s ON p.patient_id=s.patient_id
 where s.payment_status IN('Pending','Overdue');
 --15: how many prescriptions each medication appears in.
 select p.med_id,COUNT(p.med_id) as apperin
 from Prescription_Details p
 group by p.med_id;
 --16:available rooms

 SELECT room_id, room_type, daily_rate, status, room_description
FROM Rooms
WHERE status = 'Available';

--17 completed payments
SELECT payment_id, amount_paid, method, payment_date, invoice_id, transaction_id
FROM Payments
WHERE payment_status = 'Completed';

--18 Admissions that are currently pending (not discharged)
SELECT admission_id, admission_date, discharge_date, patient_id, room_id, admission_type
FROM admissions
WHERE discharge_date = 'Pending';

--19 Lab tests costing more than 100
SELECT test_id, test_name, lab_type, cost, lab_notes
FROM Lab_Test
WHERE cost > 100;

--20 row count of technicians
SELECT COUNT(*) AS technician_count
FROM Lab_Technician;

--21 admissions with room details (join admissions -Rooms)
SELECT a.admission_id, a.admission_date, a.discharge_date, a.patient_id,
       r.room_id, r.room_type, r.room_description, r.room_capacity
FROM admissions a
JOIN Rooms r ON a.room_id = r.room_id;

--22 Latest lab report per technician (technician name + most recent report date)
SELECT lt.tech_id, lt.name AS technician_name, MAX(lr.report_date) AS last_report_date
FROM Lab_Technician lt
LEFT JOIN lab_report lr ON lt.tech_id = lr.tech_id
GROUP BY lt.tech_id, lt.name;


--23 Total payments grouped by payment method
SELECT method, COUNT(*) AS payments_count, SUM(amount_paid) AS total_amount
FROM Payments
GROUP BY method
ORDER BY total_amount DESC;

--24 Number of lab tests per lab_type
SELECT lab_type, COUNT(*) AS tests_count
FROM Lab_Test
GROUP BY lab_type
ORDER BY tests_count DESC;

--25  rooms with capacity greater than 2
SELECT room_id, room_type, room_capacity
FROM Rooms
WHERE room_capacity > 2;

--26 highest payment made to lowest
SELECT payment_id, amount_paid, method
FROM Payments
ORDER BY amount_paid DESC;


--27 List patients still admitted (discharge_date IS NULL)
SELECT admission_id, patient_id, room_id, admission_date
FROM Admissions
WHERE discharge_date IS NULL;


--28 tests that contain the word “blood”
SELECT test_id, test_name, cost
FROM Lab_Test
WHERE test_name LIKE '%Blood%';

--29 technicians ordered by experience (highest first)
SELECT tech_id, name, hire_date
FROM Lab_Technician
ORDER BY hire_date ASC;

--30 Show reports with technician name
SELECT lr.report_id,lr.report_date,lr.notes,lt.test_id,lt.test_name,lt.result,lt.cost,ltech.name AS technician_name
FROM lab_report lr
INNER JOIN Lab_Test lt ON lr.test_id = lt.test_id
INNER JOIN Lab_Technician ltech ON lr.tech_id = ltech.tech_id;