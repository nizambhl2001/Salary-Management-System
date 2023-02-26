Drop Database Salary_Management_System
Create Database Salary_Management_System
on (
	name= 'Salary_Management_SystemDB _Data_1',
	FileName= 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Salary_Management_System_Data_1.mdf',
	Size=25mb,
	Maxsize=100mb,
	FileGrowth=5%
) log on (
	name='Salary_Management_SystemDB_Log_1',
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Salary_Management_SystemDB_Log_1.ldf',
	Size=2mb,
	Maxsize=50mb,
	FileGrowth=1mb
)
Use Salary_Management_System

DROP TABLE salary;
DROP TABLE bonus;
DROP TABLE allowance;
DROP TABLE employee;

Create Table employee(
	emp_id int NOT NULL,
	emp_name VARCHAR(20),
	branch VARCHAR(20),
	emp_mobile Numeric,
	emp_mail VARCHAR(20),
	PRIMARY KEY(emp_id)
);

 Create Table department(
	emp_id int NOT NULL,
	dep_name Varchar(20),
	deg_name Varchar(20),
	join_date date
 );
 
 Create Table salary(
	emp_id int NOT NULL,
	emp_fname VARCHAR(10),
	emp_lname VARCHAR(10),
	amount int,
	FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
  );
 
 Create Table bonus(
	id int NOT NULL,
	overtime_bonus VARCHAR(15),
	festivel_bonus VARCHAR(15),
	provident_fund VARCHAR(15),
	FOREIGN KEY (id) REFERENCES employee(emp_id)
 );
 
 Create Table allowance(
	id int NOT NULL,
	medical_allowance VARCHAR(15),
	education_allowance VARCHAR(15),
	housing_rent_allowance VARCHAR(15),
	FOREIGN KEY (id) REFERENCES employee(emp_id)
 );
 
Insert Into employee(emp_id, emp_name, branch, emp_mobile, emp_mail) 
	Values(860541,'Debendra Osmani','Khulna',01725818649,'deb18@gmail.com'),
		(860543,'Anwar Hossain','Khulna',01846623873,'hossain433@gmail.com'),
		(860733,'Forhad Aziz','Barisal',01834849717,'93forhad@gmail.com'),
		(861403,'Nazirul Haque','Bogra',01518942057,'nazi45@outlook.com'),
		(860554,'Talvia Ara','Khulna',01614773937,'ara@gmail.com'),
		(860782,'Nazmul Hossain','Barisal',01864825734,'nazm@gmail.com'),
		(860314,'Mahmud Bondhon','Dhaka',015242084469,'bondhon@gmail.com'),
		(860522,'Nafe Haque','Khulna',01780007409,'nafe@gmail.com'),
		(860839,'Shamima Khatun','Chattogram',01756460464,'shamima@gmail.com'),
		(860343,'Nayan Hossain','Dhaka',0178795343,'nayan@gmail.com');

Insert Into salary 
	VALUES(860541,'Debendra','Osmani',74230),
		(860543,'Anwar','Hossain',71600),
		(860733,'Forhad','Aziz',66500),
		(861403,'Nazirul','Haque',67900),
		(860554,'Talvia','Ara',71790),
		(860782,'Nazmul','Hossain',65240),
		(860314,'Mahmud','Bondhon',75300),
		(860522,'Nafe','Haque',71500),
		(860839,'Shamima','Khatun',72650),
		(860343,'Nayan','Hossain',73590);

Insert Into bonus 
	VALUES(860541,'7000','15000','N/A'),
		(860543,'5000','15000','N/A'),
		(860733,'5500','15000','N/A'),
		(861403,'6000','15000','N/A'),
		(860554,'5000','15000','N/A'),
		(860782,'4000','15000','N/A'),
		(860314,'7000','15000','N/A'),
		(860522,'5000','15000','N/A'),
		(860839,'6000','15000','N/A'),
		(860343,'6500','15000','N/A');

Insert Into allowance 
	VALUES(860541,'1500','500','19000'),
		(860543,'1500','500','19000'),
		(860733,'1500','500','13000'),
		(861403,'1500','500','14000'),
		(860554,'1500','500','19000'),
		(860782,'1500','500','13000'),
		(860314,'1500','500','20000'),
		(860522,'1500','500','19000'),
		(860839,'1500','500','19000'),
		(860343,'1500','500','20000');


Select * From employee
Select * From salary
Select * From allowance
Select * From bonus
Select * From department
