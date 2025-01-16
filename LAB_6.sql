
-----------------------LAB-6
-----------------------CURSOR

--From the above given tables perform the following queries: 


--  Create the Products table 
CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
);

--  Insert data into the Products table 
INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

SELECT * from Products


-----------------------PART-A

--1) Create a cursor Product_Cursor to fetch all the rows from a products table.

DECLARE Product_Cursor CURSOR
FOR 
	SELECT * FROM Products

OPEN Product_Cursor

FETCH NEXT FROM Product_Cursor

WHILE @@FETCH_STATUS=0
	BEGIN
		FETCH NEXT FROM Product_Cursor
	END

CLOSE Product_Cursor

DEALLOCATE Product_Cursor


--2)Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. (Example: 1_Smartphone)

DECLARE @Product_ID INT,
		@Product_Name VARCHAR(50)

DECLARE Product_Cursor_Fetch CURSOR
FOR
	SELECT Product_id,Product_Name
	FROM Products

OPEN Product_Cursor_Fetch

FETCH NEXT FROM Product_Cursor_Fetch
INTO @Product_id,@Product_Name

WHILE @@FETCH_STATUS=0
	BEGIN
		PRINT CAST(@Product_Id AS VARCHAR(50))+'_'+@Product_Name

		FETCH NEXT FROM Product_Cursor_Fetch
		INTO @Product_Id,@Product_Name
	END

CLOSE Product_Cursor_Fetch

DEALLOCATE Product_Cursor_Fetch


--3)Create a Cursor to Find and Display Products Above Price 30,000.

DECLARE @Product_Name VARCHAR(50)
DECLARE	@Price DECIMAL(10,2)

DECLARE Cursor_Price_Fetch CURSOR
FOR
	SELECT PRODUCT_Name,Price
	FROM Products

OPEN Cursor_Price_Fetch

FETCH NEXT FROM Cursor_Price_Fetch
INTO @Product_Name,@Price

WHILE @@FETCH_STATUS=0
	BEGIN
		IF(@Price>30000)
			PRINT @Product_Name+'==>'+CAST(@Price AS VARCHAR(50))
		FETCH NEXT FROM Cursor_Price_Fetch
		INTO @Product_Name,@Price
	END

CLOSE Cursor_Price_Fetch

DEALLOCATE Cursor_Price_Fetch


--4) Create a cursor Product_CursorDelete that deletes all the data from the Products table.


DECLARE @Product_id INT

DECLARE Product_CursorDelete CURSOR
FOR
	SELECT Product_id
	FROM Products

OPEN Product_CursorDelete

FETCH NEXT FROM Product_CursorDelete
INTO @Product_id

WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM Products
		WHERE Product_id = @Product_id

		FETCH NEXT FROM Product_CursorDelete
		INTO @Product_id
	END

CLOSE Product_CursorDelete

DEALLOCATE Product_CursorDelete



--------------------PART-B


--5)Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%.

DECLARE @Product_ID INT,
		@Price DECIMAL(10,2)
		
DECLARE Product_CursorUpdate CURSOR
FOR
	SELECT Product_id,Price FROM Products

OPEN Product_CursorUpdate

FETCH NEXT FROM Product_CursorUpdate
INTO @Product_ID,@Price

WHILE @@FETCH_STATUS=0
	BEGIN
		UPDATE Products
		SET Price=(@Price+(@Price*0.1))
		WHERE Product_id=@Product_ID

		FETCH NEXT FROM Product_CursorUpdate
		INTO @Product_ID,@Price
	END

CLOSE Product_CursorUpdate

DEALLOCATE Product_CursorUpdate


select * from Products


--6) Create a Cursor to Rounds the price of each product to the nearest whole number.

DECLARE @Price DECIMAL(10,2)

DECLARE Cursor_Price_Round CURSOR
FOR
	SELECT Price
	FROM Products

OPEN Cursor_Price_Round

FETCH NEXT FROM Cursor_Price_Round
INTO @Price

WHILE @@FETCH_STATUS=0
	BEGIN
		UPDATE Products
		SET Price=Round(@Price,0)

		FETCH NEXT FROM Cursor_Price_Round
		INTO @Price
	END

CLOSE Cursor_Price_Round

DEALLOCATE Cursor_Price_Round


select * from Products


------------------------PART-C

create table newProduct(
	Product_Id int,
	Product_Name varchar(50),
	price decimal(10,2)
)

--7) Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)

declare @Productid int,
		@ProductName varchar(50)
		@Price decimal(10,2)

declare Cursor_insert_Into_NewProduct cursor
for
	select * from Products

open Cursor_insert_Into_NewProduct

fetch next from Cursor_insert_Into_NewProduct
into @Productid,@ProductName,@Price

while @@FETCH_STATUS=0
	begin
		if @Product_Name='Laptop'
		set 
			insert into NewProduct
			values
			(@Productid int,
			 @ProductName varchar(50),
			 @Price decimal(10,2)
			)
		fetch next from Cursor_insert_Into_NewProduct
		into @Productid,@ProductName,@Price
	end

close Cursor_insert_Into_NewProduct

deallocate Cursor_insert_Into_NewProduct