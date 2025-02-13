-------LAB-7

------Exception Handling 

-- Create the Customers table 
CREATE TABLE Customers ( 
Customer_id INT PRIMARY KEY,                 
Customer_Name VARCHAR(250) NOT NULL,         
Email VARCHAR(50) UNIQUE                     
);

-- Create the Orders table 
CREATE TABLE Orders ( 
Order_id INT PRIMARY KEY,                    
Customer_id INT,                             
Order_date DATE NOT NULL,                    
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
);


--From the above given tables perform the following queries:

---------Part–A 

--1)Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

BEGIN TRY
	DECLARE @N1 int = 10
	DECLARE @N2 int = 0 --'5'
	DECLARE @result int
	SET @result =  @N1 / @N2
END TRY

BEGIN CATCH
	print 'Error occurs that is - Divide by zero error'
END CATCH


--2)Try to convert string to integer and handle the error using try…catch block.

BEGIN TRY
	DECLARE @Num1 INT = 10
	DECLARE @Num2 NVARCHAR(50) = 'ABC' --'1'
	SET @Num2 = CAST(@Num2 AS INT)
END TRY

BEGIN CATCH
	print 'Error occurs that is - Not Convert string to int'
END CATCH


--3)Create a procedure that prints the sum of two numbers: take both numbers as integer & handle 
--exception with all error functions if any one enters string value in numbers otherwise print result.

CREATE OR ALTER PROC PR_SumOfErorHandling
@N1 NVARCHAR(50) , @N2 NVARCHAR(50)
AS
BEGIN
	BEGIN TRY
		Declare @num1 int = CAST(@N1 AS INT)
		Declare @num2 int = CAST(@N2 AS INT)
		PRINT @num1 + @num2 
	END TRY

	BEGIN CATCH
		print 'Error occurs that is - Not Convert string to int'
	END CATCH
END

EXEC PR_SumOfErorHandling 1,2

EXEC PR_SumOfErorHandling 1,'abc'

EXEC PR_SumOfErorHandling 1,'2'


--4)Handle a Primary Key Violation while inserting data into customers table and print the error details 
--such as the error message, error number, severity, and state.

--IT EXECUTE 2 TIMES

BEGIN TRY
	INSERT INTO Customers VALUES(1,'mansi','mansi@gmail.com')
END TRY

BEGIN CATCH
	PRINT ERROR_MESSAGE()
	PRINT ERROR_NUMBER()
	PRINT ERROR_SEVERITY()
	PRINT ERROR_STATE()
END CATCH


--5)Throw custom exception using stored procedure which accepts Customer_id as input & that throws 
--Error like no Customer_id is available in database. 

CREATE OR ALTER PROC PR_customIdExistOrNot
@CustomerId int
AS
BEGIN
	IF not exists (SELECT Customer_id FROM Customers WHERE Customer_id = @CustomerId)
	BEGIN
		THROW 50001,'Error like no Customer_id is available in database',1
	END
	ELSE
	BEGIN
		print 'Customer_id is already exist'
	END
END

EXEC PR_customIdExistOrNot 1

EXEC PR_customIdExistOrNot 2



---------Part–B


--6)Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message

--IT EXECUTE 2 TIMES

BEGIN TRY
	INSERT INTO Orders VALUES(1,1,GETDATE())
END TRY

BEGIN CATCH
	PRINT 'Foreign key Violation Error Occured : Invalid Customer)id'
END CATCH


--7)Throw custom exception that throws error if the data is invalid.

CREATE OR ALTER PROC PR_CustomException
@Age INT
AS
BEGIN
	If @Age<18
	BEGIN
		THROW 50002,'Age must be greater than 18!',1
	END
	ELSE
	BEGIN
		print 'You are eligible for voting!!'
	END
END

EXEC PR_CustomException 20

EXEC PR_CustomException 17


--8)Create a Procedure to Update Customer’s Email with Error Handling

CREATE OR ALTER PROC PR_UpdateEmailWithErrorHandling
@CustomerId INT,@CustomerName VARCHAR(50),@NewEmail VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		UPDATE Customers
		SET Email = @NewEmail
		WHERE Customer_id = @CustomerId
	END TRY

	BEGIN  CATCH
		print Error_message()
	END CATCH
END

EXEC PR_UpdateEmailWithErrorHandling 1,'mansi','fatepara@gmail.com'

EXEC PR_UpdateEmailWithErrorHandling 2,'mansi','fatepara@gmail.com'