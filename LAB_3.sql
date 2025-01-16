---------------------LAB-3------------------------------


-----------------------------PART-A----------------------------------


--TABLE SCHEMA


--create departments table
CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
);


--create employee table
CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 


-- Create Projects Table 
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 


--insert data into departments
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 


--insert data into employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);



--insert into projects table
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);


Select * from Departments
Select * from Employee
Select * from Projects



------------------------------------------------PART-A-------------------------------------------------


--1)Create Stored Procedure for Employee table As User enters either First Name or Last Name and based 
--on this you must give EmployeeID, DOB, Gender & Hiredate.

CREATE OR ALTER PROC PR_EmployeeDetailsWithNull
	@FirstName varchar(100) = null,
	@LastName varchar(100) = null
AS
BEGIN
	Select EmployeeID,DoB,Gender,HireDate
	from Employee
	Where FirstName = @FirstName OR LastName = @LastName
END

exec PR_EmployeeDetailsWithNull @LastName = 'Doe'
exec PR_EmployeeDetailsWithNull @FirstName = 'john'
exec PR_EmployeeDetailsWithNull 'john','Doe'



--2)Create a Procedure that will accept Department Name and based on that gives employees list who 
--belongs to that department.

CREATE OR ALTER PROC PR_EmployeeDetailAsDept
	@DepartmentName varchar(100)
AS
BEGIN
	Select * from Employee E
	join Departments D
	on E.DepartmentID = D.DepartmentID
	where DepartmentName = @DepartmentName
END

EXEC PR_EmployeeDetailAsDept 'IT'



--3) Create a Procedure that accepts Project Name & Department Name and based on that you must give 
--all the project related details.

CREATE OR ALTER PROC PR_ProjectDetailsWithProjNameOrDeptName
	@ProjectName varchar(100),
	@DepartmentName varchar(100)
AS
BEGIN
	select * from Projects P
	join Departments D
	on P.DepartmentID = D.DepartmentID
	Where ProjectName = @ProjectName AND DepartmentName = @DepartmentName
END

EXEC PR_ProjectDetailsWithProjNameOrDeptName 'Project Alpha','IT'



--4)Create a procedure that will accepts any integer and if salary is between provided integer, then those 
--employee list comes in output.

CREATE OR ALTER PROC PR_SelectEmpBySalary
	@Min_Salary int,
	@Max_Salary int
AS
BEGIN
	select *
	from Employee
	where
		Salary > @Min_Salary
		AND
		Salary < @Max_Salary
END

EXEC PR_SelectEmpBySalary 50000,60000


---or----


CREATE OR ALTER PROC PR_SelectEmpBySalary_1
	@Random_Salary INT
AS
BEGIN
	if @Random_Salary < 50000
		SELECT 'Please enter valid salary'
		
	else
		select *from Employee
		where
			Salary between
			@Random_Salary
			AND
			@Random_Salary + 50000
END

EXEC PR_SelectEmpBySalary_1 40000
EXEC PR_SelectEmpBySalary_1 50000



--5)Create a Procedure that will accepts a date and gives all the employees who all are hired on that date.

CREATE OR ALTER PROC PR_SelectEmpByHireDate
	@HireDate DATETIME
AS
BEGIN
	select * from Employee
	where HireDate = @HireDate
END

EXEC PR_SelectEmpByHireDate '2024-01-01';
EXEC PR_SelectEmpByHireDate '2010-06-15'



----------------------------------PART-B--------------------------------------------


--6) Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served.

CREATE OR ALTER PROC PR_Employee_accepts_1st_Letter
	@Gender varchar(100)
AS
BEGIN
	select * 
	From Employee
	where LEFT(Gender, 1) = @Gender;
END

EXEC PR_Employee_accepts_1st_Letter 'M'
EXEC PR_Employee_accepts_1st_Letter 'F'



--7) Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come.

CREATE OR ALTER PROC PR_EmpDetailWithFNameOrDeptName
	@FName varchar(100),
	@DeptName varchar(100)
AS
BEGIN
	select * from Employee E
	join Departments D
	on E.DepartmentID = D.DepartmentID
	Where DepartmentName = @DeptName and FirstName = @FName
END

EXEC PR_EmpDetailWithFNameOrDeptName 'John','HR'
EXEC PR_EmpDetailWithFNameOrDeptName 'John','IT'



--8)Create a procedure that will accepts location, if user enters a location any characters, then he/she will 
--get all the departments with all data.

CREATE OR ALTER PROC PR_Select_By_Location
	@Location varchar(100)
AS
BEGIN
	select * 
	from Departments
	where Location like '%'+@Location+'%'
END

EXEC PR_Select_By_Location 'Ne'




-------------------------------------PART-C------------------------------------



--9) Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project related data.

CREATE OR ALTER PROC PR_ProjectDetailFromToDate
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN
	select * from Projects
	where StartDate = @FromDate and EndDate = @ToDate
END


EXEC PR_ProjectDetailFromToDate '2022-01-01' , '2022-12-31'



--10) Create a procedure in which user will enter project name & location and based on that you must 
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates.

CREATE OR ALTER PROC PR_AllDetails
	@PName varchar(100),
	@Location varchar(100)
AS
BEGIN
	select DepartmentName,ProjectName,FirstName,LastName,StartDate,EndDate from Departments D
	join Projects P
	on D.DepartmentID = P.DepartmentID
	join Employee E
	on D.DepartmentID = E.DepartmentID
	where ProjectName = @Pname and Location = @Location
END


EXEC PR_AllDetails 'Project Alpha' , 'new York'