---------------------LAB-4----------------------

--UDF(User Defined Function)

--Note: for Table valued function use tables of Lab-2

-----------------------------PART-A----------------------------

--1)Write a function to print "hello world".

CREATE OR ALTER FUNCTION FN_Hello_World()
RETURNS VARCHAR(50)
AS
BEGIN
	RETURN('Hello World')
END

SELECT dbo.FN_Hello_World()



--2)Write a function which returns addition of two numbers.

CREATE OR ALTER FUNCTION FN_Add_2_Num(@n1 INT,@n2 INT)
RETURNS INT
AS
BEGIN
	RETURN (@n1+@n2)
END

SELECT dbo.FN_Add_2_Num(10,20)



--3)Write a function to check whether the given number is ODD or EVEN.

CREATE OR ALTER FUNCTION FN_Num_Is_Even_Odd(@n INT)
RETURNS VARCHAR(100)
AS
BEGIN
	Declare @msg varchar(100)

	if @n%2=0
	set @msg='Even'
	else if @n%2!=0
	set @msg='Odd'
	else
	set @msg='Invalid!'

	return @msg
END

select dbo.FN_Num_Is_Even_Odd(4)
select dbo.FN_Num_Is_Even_Odd(5)



--4)Write a function which returns a table with details of a person whose first name starts with B.

select * from Person

create or alter function Fn_Person_Detail_Fname_Start_With_B()
returns table
as
	return(select * from Person
			where FirstName like 'B%')


Select * from dbo.Fn_Person_Detail_Fname_Start_With_B()



--5)Write a function which returns a table with unique first names from the person table.

create or alter function FN_Uni_Fname_From_Person()
returns table
as
	return(
		select distinct FirstName from Person
	)

select * from dbo.FN_Uni_Fname_From_Person()



--6)Write a function to print number from 1 to N. (Using while loop)

create or alter function FN_Print_1toN(@n int)
returns varchar(max)
as
begin
	declare @ans varchar(max),@i int
	set @ans = ''
	set @i = 1
	while(@i<=@n)
	begin
		set @ans = @ans+cast(@i as varchar)+','
		set @i = @i+1
	end
	return @ans
end

select dbo.FN_Print_1toN(5)



--7)Write a function to find the factorial of a given integer.

create or alter function FN_Find_Factorial(@n INT)
returns int
as
begin
	declare @fact int,@i int
	set @fact=1
	set @i=1
	while(@i<=@n)
	begin
		set @fact = @fact*@i
		set @i=@i+1
	end
	return @fact
end

select dbo.FN_Find_Factorial(5)








------------------------PART-B--------------------------


--8)Write a function to compare two integers and return the comparison result. (Using Case statement)

create or alter function FN_Compare_2_int_return_str(@n1 int,@n2 int)
returns varchar(max)
as
begin
	return case
			when @n1>@n2 then 'First is greater than Second'
			when @n2>@n1 then 'Second is greater than First'
			else 'both are equal!'
			end
end

select dbo.FN_Compare_2_int_return_str(2,4)
select dbo.FN_Compare_2_int_return_str(4,2)
select dbo.FN_Compare_2_int_return_str(4,4)



--9)Write a function to print the sum of even numbers between 1 to 20.

create or alter function FN_Print_Sum_Even_Num_Between_1to20()
returns int
as
begin
	declare @sum int,@n int
	set @sum=0
	set @n = 1
	while (@n<=20)
	begin
		if (@n%2=0)
		set @sum=@sum+@n
	set @n=@n+1
	end
	return @sum
end

select dbo.FN_Print_Sum_Even_Num_Between_1to20()




--10)Write a function that checks if a given string is a palindrome

---using reverse() function

create or alter function FN_Str_Palindrome_Using_Rev(@str varchar(max))
returns varchar(max)
as
begin
	declare @msg varchar(max)
	if (@str = reverse(@str))
	set @msg = 'palindome'
	else
	set @msg = 'not palindrome'
	return @msg
end

select dbo.FN_Str_Palindrome_Using_Rev('sks')
select dbo.FN_Str_Palindrome_Using_Rev('sky')


--using logic of palindrome

create or alter function FN_Str_Palindrome(@str varchar(max))
returns varchar(max)
as
begin
	DECLARE @len INT, @i INT, @isPalindrome varchar(max)
    SET @len = LEN(@str)
    SET @i = 1
    SET @isPalindrome = ''

    WHILE @i <= @len / 2
    BEGIN
        -- Compare characters from the beginning and end
        IF SUBSTRING(@str, @i, 1) <> SUBSTRING(@str, @len - @i + 1, 1)
        BEGIN
            SET @isPalindrome = 'Not Palindrome'
            BREAK
        END
		ELSE
			SET @isPalindrome = 'Palindrome'
		SET @i = @i + 1
    END

    RETURN @isPalindrome
end

select dbo.FN_Str_Palindrome('sks')
select dbo.FN_Str_Palindrome('sky')





-------------------------------PART-C--------------------------------

--11)Write a function to check whether a given number is prime or not.

create or alter function FN_Prime_Or_NOT(@n int)
returns varchar(max)
as
begin
	declare @isPrime varchar(max),@i int,@count int
	set @isPrime = ''
	set @i = 1
	set @count = 0
	while (@i<=@n)
	begin
		if (@n%@i=0)
		set @count = @count + 1
	set @i = @i + 1
	end
	if @count=2
	set @isPrime='yes, prime!'
	else
	set @isPrime='No, Not prime!'
	return @isPrime
end

select dbo.FN_Prime_Or_NOT(13)
select dbo.FN_Prime_Or_NOT(14)