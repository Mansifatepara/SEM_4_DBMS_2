------------------------------LAB-2-------------------------------


----------------------------PART-A-----------------------------

--TABLE SCHEMA


-- Create Department Table 
CREATE TABLE Department ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE
); 

-- Create Designation Table 
CREATE TABLE Designation ( 
DesignationID INT PRIMARY KEY, 
DesignationName VARCHAR(100) NOT NULL UNIQUE 
); 

-- Create Person Table 
CREATE TABLE Person ( 
PersonID INT PRIMARY KEY IDENTITY(101,1), 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8, 2) NOT NULL, 
JoiningDate DATETIME NOT NULL, 
DepartmentID INT NULL, 
DesignationID INT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID), 
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID) 
);

--------------------------STORED PROCEDURE-----------------------------------


--1) Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.

--------FOR DEPARTMENT---------

--------1)INSERT----------

CREATE OR ALTER PROCEDURE PR_Department_Insert
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	INSERT INTO Department
	(
		DepartmentID,
		DepartmentName
	)
	VALUES
	(
		@DepartmentID,
		@DepartmentName
	)
END

EXEC PR_Department_Insert 1,'Admin'
EXEC PR_Department_Insert 2,'IT'
EXEC PR_Department_Insert 3,'HR'
EXEC PR_Department_Insert 4,'Account'



--------2)UPDATE----------

CREATE OR ALTER PROCEDURE PR_Department_Update
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	UPDATE Department
	SET DepartmentName = @DepartmentName
	WHERE DepartmentID = @DepartmentID
END



---------3)DELETE----------

CREATE OR ALTER PROCEDURE PR_Department_Delete
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	DELETE Department
	WHERE DepartmentID = @DepartmentID
END





-----------------FOR DESIGNATION---------------------


------------1)INSERT--------------

CREATE OR ALTER PROCEDURE PR_Designation_Insert
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	INSERT INTO Designation
	(
		DesignationID,
		DesignationName
	)
	VALUES
	(
		@DesignationID,
		@DesignationName
	)
END


EXEC PR_Designation_Insert 11,'Jobber'
EXEC PR_Designation_Insert 12,'Welder'
EXEC PR_Designation_Insert 13,'Clerk'
EXEC PR_Designation_Insert 14,'Manager'
EXEC PR_Designation_Insert 15,'CEO'



--------2)UPDATE----------

CREATE OR ALTER PROCEDURE PR_Designation_Update
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	UPDATE Designation
	SET DesignationName = @DesignationName
	WHERE DesignationID = @DesignationID
END



---------3)DELETE----------

CREATE OR ALTER PROCEDURE PR_Designation_Delete
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	DELETE Designation
	WHERE DesignationID = @DesignationID
END




-----------------FOR PERSON---------------------


------------1)INSERT--------------

CREATE OR ALTER PROCEDURE PR_Person_Insert
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary DECIMAL(8,2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
AS
BEGIN
	INSERT INTO Person
	(
		FirstName,
		LastName,
		Salary,
		JoiningDate,
		DepartmentID,
		DesignationID
	)
	VALUES
	(
		@FirstName,
		@LastName,
		@Salary,
		@JoiningDate,
		@DepartmentID,
		@DesignationID
	)
END

EXEC PR_Person_Insert 'Rahul','Anshu',56000,'1990-01-01',1,12
EXEC PR_Person_Insert 'Hardik','Hinsu',18000,'1990-09-25',2,11
EXEC PR_Person_Insert 'Bhavin','Kamani',25000,'1991-05-14',null,11
EXEC PR_Person_Insert 'Bhoomi','Patel',39000,'2014-02-20',1,13
EXEC PR_Person_Insert 'Rohit','Rajgor',17000,'1990-07-23',2,15
EXEC PR_Person_Insert 'Priya','Mehta',25000,'1990-10-18',2,null
EXEC PR_Person_Insert 'Neha','Trivedi',18000,'2014-02-20',3,15



------------2)UPDATE--------------

CREATE OR ALTER PROCEDURE PR_Person_Update
	@PersonID INT,
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100)
AS
BEGIN
	UPDATE Person
	SET FirstName = @FirstName,
		LastName = @LastName
	WHERE PersonID = @PersonID
END


------------3)DELETE--------------

CREATE OR ALTER PROCEDURE PR_Person_Delete
	@PersonID INT
AS
BEGIN
	DELETE Person
	WHERE PersonID = @PersonID
END





--2) Department, Designation & Person Table’s SELECTBYPRIMARYKEY 

---For Department Table

CREATE OR ALTER PROC PR_DEPARTMENT_SELECT_BY_PK
	@DEPT_ID INT
AS
BEGIN
	SELECT * FROM Department
	WHERE DepartmentID = @DEPT_ID
END


--For Designation Table

CREATE PROC PR_DsignationSelectByPK
	@DesignationID INT
AS
BEGIN
	SELECT * FROM Designation
	WHERE DesignationID = @DesignationID
END


--For Person table

CREATE PROC PR_PersonSelectByPK
	@PER_ID INT
AS
BEGIN
	SELECT * FROM Person
	WHERE PersonID = @PER_ID
END




--3) Department, Designation & Person Table’s (If foreign key is available then do write join and take 
--columns on select list)


CREATE OR ALTER PROC PR_PERSON_SELECT_BY_FK
AS
BEGIN
	SELECT * FROM Person
	JOIN Department
	ON  Person.DepartmentID = Department.DepartmentID
	JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
END


--4) Create a Procedure that shows details of the first 3 persons.

CREATE OR ALTER PROC PR_Detail_Of_Top_3_Person
AS
BEGIN
	SELECT TOP 3 *
	FROM PERSON
	JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
END





-----------------------------PART-B----------------------------------



--4) Create a Procedure that takes the department name as input and returns a table with all workers 
--working in that department.

CREATE OR ALTER PROC PR_DETAILOFWORKERS
	@Dept_Name varchar(50)
AS
BEGIN
	SELECT * FROM Person
	join Department
	ON Person.DepartmentID = Department.DepartmentID
	where Department.DepartmentID = @Dept_Name
END

--5)Create Procedure that takes department name & designation name as input and returns a table with 
--worker’s first name, salary, joining date & department name.

CREATE OR ALTER PROC PR_AllPersonDetails
	@DepartmentName varchar(50),
	@DesignationName Varchar(50)
AS
BEGIN
	select * from
	person join Department
	on Person.DepartmentID = Department.DepartmentID
	join Designation
	on Person.DesignationID = Designation.DesignationID
	Where DepartmentName = @DepartmentName AND DesignationName = @DesignationName
END


--7)Create a Procedure that takes the first name as an input parameter and display all the details of the 
--worker with their department & designation name.

CREATE OR ALTER PROC PR_AllPersonDetails
	@FirstName varchar(50)
AS
BEGIN
	select * from
	person join Department
	on Person.DepartmentID = Department.DepartmentID
	join Designation
	on Person.DesignationID = Designation.DesignationID
	where FirstName = @FirstName
END


--8) Create Procedure which displays department wise maximum, minimum & total salaries.

CREATE OR ALTER PROC PR_Select_Max_Min_Total_Salary
AS
BEGIN
	select Person.max(Salary),Person.min(Salary),Person.sum(Salary)
	from Person
	join Department
	on Person.DepartmentID = Department.DepartmentID
	Group By Department.DepartmentName
END


--9) Create Procedure which displays designation wise average & total salaries.

CREATE OR ALTER PROC PR_Select_Avg_Total_Salary
AS
BEGIN
	select Person.avg(Salary),Person.sum(Salary)
	from Person
	join Designation
	on Person.DesignationID = Designation.DesignationID
	Group By Designation.DesignationName
END



----------------------------PART-C-----------------------------------



--10) Create Procedure that Accepts Department Name and Returns Person Count. 

CREATE OR ALTER PROC PR_Person_Count
	@DepartmentName varchar(50)
AS
BEGIN
	select Person.count(PersonID)
	from Person
	join Department
	on Person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentID
END


--11)  Create a procedure that takes a salary value as input and returns all workers with a salary greater than 
--input salary value along with their department and designation details.

CREATE OR ALTER PROC PR_SalaryGreaterThan
	@Salary INT
AS
BEGIN
	select * from
	Person Join Department
	on Person.DepartmentID = Department.DepartmentID
	join Designation
	on Person.DesignationID = Designation.DesignationID
	Where Person.Salary>@Salary
END


--12) Create a procedure to find the department(s) with the highest total salary among all departments.

CREATE OR ALTER PROCEDURE PR_PERSON_HEGHEST_SALARY
AS
BEGIN
		select top 1 D.DepartmentName , sum(P.Salary) from
		Person P join 
		Department D 
		on P.DepartmentID = D.DepartmentID
		group by D.DepartmentName
		order by sum(P.Salary) desc
END

exec PR_PERSON_HEGHEST_SALARY



--13) Create a procedure that takes a designation name as input and returns a list of all workers under that 
--designation who joined within the last 10 years, along with their department.

CREATE OR ALTER PROC PR_List_Of_All_Workers
	@DesignationName Varchar(50)
AS
BEGIN
	select * from Person
	join Department
	on person.DepartmentID = Department.DepartmentID
	join Designation
	on Person.DesignationID = Designation.DesignationID
	Where Designation.DesignationName = @DesignationName
	AND
	DATEDIFF(year,JoiningDate,getdate()) <= 10
END



--14)Create a procedure to list the number of workers in each department who do not have a designation assigned.

CREATE OR ALTER PROC PR_List_No_Of_Workers
AS
BEGIN
	select count(PersonID)
	from Person
	join Department
	on person.DepartmentID = Department.DepartmentID
	join Designation
	on Person.DesignationID = Designation.DesignationID
	where Designation.DesignationID = null
END


--15)Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.

CREATE OR ALTER PROC PR_DetailsOfWorkers
AS
BEGIN
	select Person.avg(Salary)
	from Person
	join Department
	on person.DepartmentID = Department.DepartmentID
	group by Department.DepartmentName
	having Person.avg(Salary)>12000
END