Use Salary_Management_System

select * from employee;
select * from salary;
select * from department;
select * from bonus;
select * from allowance;


--update and value 
UPDATE salary
set emp_fname= 'shariar'
WHERE  emp_id= 860543;

--using BETWEEN & AND
SELECT emp_fname from salary
WHERE amount BETWEEN 70000 AND 74000;

--using IN 
SELECT emp_fname from salary
WHERE amount IN(70000,74000);

--order by
select emp_fname,emp_lname
from salary
ORDER BY amount;

--find employee where name starts and ends with 'n'
SELECT emp_name,emp_id
FROM employee
where emp_name LIKE 'N%'
and WHERE emp_name LIKE '%N';

--to see how many got education_allowance below 500
SELECT education_allowance, COUNT(id)
FROM allowance
GROUP BY education_allowance
HAVING education_allowance<500;

--using WHERE
SELECT housing_rent_allowance, COUNT(id) as Total
FROM allowance
GROUP BY housing_rent_allowance
HAVING housing_rent_allowance>500;

--to find the salaries above 70k
select emp_id,emp_name
from salary
where emp_name in(
    select emp_name
    from salary
    where amount > 70000);

--finding employee who got overtime bonus over 6000 using JOIN
SELECT e.emp_name,e.emp_id, overtime_bonus b
FROM employee e join bonus b
	ON (e.emp_id=b.id)
	AND(b.overtime_bonus>6000);

--join
SELECT e.emp_id,e.emp_name, b.overtime_bonus
FROM employee e natural join bonus b
WHERE b.overtime_bonus>6000;

--join 3 tables 
SELECT e.emp_name, s.amount, p.log_history
from employee e join salary s
	on e.emp_id = s.emp_id 
	join payment_history p
	on e.emp_id = p.id_no;

--outer join
--left
SELECT e.emp_name, s.amount
from employee e left outer join salary s
	ON e.emp_id=s.emp_id;
--right
SELECT e.emp_name, s.amount
from employee e right outer join salary s
	ON e.emp_id=s.emp_id;
--FULL
SELECT e.emp_name, s.amount
from employee e FULL outer join salary s
	ON e.emp_id=s.emp_id;

--Group by average 
SELECT emp_id, AVG(amount) AS AvgSalaryAmount 
FROM salary
GROUP BY emp_id 
HAVING AVG(amount) > 2000 
ORDER BY AvgSalaryAmount DESC;

--Count Employee
SELECT emp_id, COUNT(*) AS EmployeeQty 
FROM salary
GROUP BY emp_id;

--Total employees salary
Select Count(emp_id) as TotalEmp,
	SUM(amount + medical_allowance + education_allowance + housing_rent_allowance) as TotalSalary
From salary s join allowance a
	on s.emp_id = a.id
	order by TotalSalary DESC

--Rollup
Select emp_fname, emp_lname, Count(*) as QtyEmp
From salary
Where emp_fname in ('Nazmul')
Group by emp_lname, emp_fname With Rollup
Order by emp_fname Desc, emp_lname Desc;

--Subquery
Select emp_id, emp_fname, emp_lname, amount 
From salary
Where emp_id in(
	Select emp_id 
	From salary
	Where emp_fname = 'Nafe')
Order by amount;

--EXISTS Operator
Select emp_id, emp_name, emp_mail 
From employee
Where Exists(
	Select * 
	From allowance
	Where id = emp_id);

--NOT EXISTS Operator
Select emp_id, emp_name, emp_mail 
From employee
Where Not Exists(
	Select * 
	From allowance
	Where id = emp_id);

--CTE
With EmployeeCTE as(
	Select e.emp_name,e.emp_id, overtime_bonus b
	From employee e join bonus b
	ON (e.emp_id=b.id)AND(b.overtime_bonus>6000)
)
Select  * 
From EmployeeCTE 
Order by emp_id;

--How to insert, update, and delete data
--a complete copy of the Bonas table 
Select * into BonasCopy
From bonus

--Insert that adds new row without using column list
Insert into BonasCopy
	Values (860895, 4500, 1500, 'N/A');

--Insert that adds new row with column list
Insert into BonasCopy(id, overtime_bonus, festivel_bonus, provident_fund)
	Values (860595, 6500, 1500, 'N/A');

-- assigns new values using update
Update BonasCopy
	Set overtime_bonus = 5500,
		festivel_bonus = 15000
	Where id = 860595;

--delete a row from from BonasCopy
Delete BonasCopy
Where id = 860595;

--CAST & Convert
--Cast
select cast('01-June-2019' AS date);

--Cast BonasCopy
Select overtime_bonus, festivel_bonus,
	CAST(overtime_bonus as real) as realType,
	CAST(festivel_bonus as money) as moneyType
From BonasCopy;

--Convert
SELECT Datetime = CONVERT(datetime,'01-june-2019 10:00:10.00');

--TryConvert
Select TRY_CONVERT(varchar, overtime_bonus) as varcharInt
From BonasCopy

--Case Function
Select overtime_bonus, festivel_bonus,
	CASE overtime_bonus
		When 4000 Then 'Lowest bonus'
		When 5000 Then 'Medum bonus'
		When 7000 Then 'Highest bonus'
	End as Comments
From BonasCopy;

--View with case
Create View EmpCase as
Select overtime_bonus, festivel_bonus,
	CASE overtime_bonus
		When 4000 Then 'Lowest bonus'
		When 5000 Then 'Medum bonus'
		When 7000 Then 'Highest bonus'
	End as Comments
From BonasCopy
--Show EmpCase
Select * From EmpCase

--View Employee Informations
Create View EmpInfo as
Select e.emp_id, e.emp_name, e.branch, 
e.emp_mobile, s.amount  
From employee e join salary s
	on e.emp_id = s.emp_id;
--Show EmpInfo
Select * From EmpInfo;

--Create an encrypted view
--Create an encrypted
create view View_FindingOvertimeBonus
	With Encryption
as
SELECT e.emp_name,e.emp_id, overtime_bonus b
FROM employee e join bonus b
	ON (e.emp_id=b.id)
	AND(b.overtime_bonus>6000);
select * from View_FindingOvertimeBonus
go

--Work with scripts
--a stored procedure
Create PROC SP_EmployeeAvgSalary
as
SELECT emp_id, AVG(amount) AS AvgSalaryAmount 
FROM salary
GROUP BY emp_id 
HAVING AVG(amount) > 2000 
ORDER BY AvgSalaryAmount DESC;

--Show SP_EmployeeAvgSalary
Exec SP_EmployeeAvgSalary;

--a stored procedure that copies a table 
Create Proc SP_CopyAllowance
as
	if OBJECT_ID('allowanceCopy') is not null
		Drop Table allowanceCopy;
	Select * into allowanceCopy 
	From allowance;
--Show SP_CopyAllowance
Exec SP_CopyAllowance;

--Out parameter in a stored procedure
Create Proc SP_TotalBasicSalary
	@EmpID real,
	@AmountVar money Output
as
Select @AmountVar = SUM(amount)
From salary
Where emp_id >= @EmpID;

--Show SP_CopyAllowance
Exec SP_TotalBasicSalary;

---user-defined functions or UDF
-- a scalar-valued function
Create Function FnEmployeeID
	(@EmployeeName varchar(30))
	Returns int
begin
	Return (Select emp_id 
			From employee
			Where emp_name = @EmployeeName)
End;

--table-valued function
Create Function FnHouseRentAllowance
	(@Cutoff money = 0)
	Return table
return
	(SELECT housing_rent_allowance, COUNT(id) as Total
	FROM allowance
	GROUP BY housing_rent_allowance
	HAVING housing_rent_allowance>500);
	
-- multi-statement table-valued function
Create Function FnCalAdj (@HowMuch money)
	Returns @OutTable table
		(Select Count(emp_id) as TotalEmp,
		SUM(amount + medical_allowance + education_allowance + housing_rent_allowance) as TotalSalary
		From salary s join allowance a
		on s.emp_id = a.id
		order by TotalSalary DESC)
begin
	Insert @OutTable
		SELECT emp_id, AVG(amount) AS AvgSalaryAmount 
		FROM salary
		GROUP BY emp_id 
		HAVING AVG(amount) > 2000 
		ORDER BY AvgSalaryAmount DESC
	While(SELECT e.emp_name, s.amount, p.log_history
		from employee e join salary s
		on e.emp_id = s.emp_id 
		join payment_history p
		on e.emp_id = p.id_no;)
	Return;
End;

--
Create proc sp_exceptionThrow
	@num int
	if @num > 5
	print 'The Number is ok';
	else 
	throw(50001,)

--Trigger
Create Trigger T_Emp_Inseert_Update
	on employee
	After Insert, Update
as
	Update employee
	set emp_name = UPPER(emp_name)
	Where emp_id in (Select emp_id From inserted);

--Raiserror using Trigger
Drop Trigger dbo.tr_prevent_insert_update
CREATE TRIGGER dbo.tr_prevent_insert_update2
	ON dbo.bonus
	INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @EmpID int, @Overtime_bonus int, 
	@Festivel_bonus int, @Provident_fund int;
	SELECT @EmpID = inserted.id,
			@Overtime_bonus = inserted.overtime_bonus,
			@Festivel_bonus = inserted.festivel_bonus,
			@Provident_fund = inserted.provident_fund
	FROM inserted
		if UPDATE(id)
	BEGIN
		RAISERROR('This table cannot be updated.', 16 ,1)
		ROLLBACK
	END
	ELSE
	BEGIN
		UPDATE [bonus]
		SET id = @EmpID
		WHERE id = @EmpID
	END
END
update bonus set id = 3 where id = 1
------The End------



