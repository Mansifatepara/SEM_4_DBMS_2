---------------------------LAB-5



-- Creating PersonInfo Table 
CREATE TABLE PersonInfo ( 
PersonID INT PRIMARY KEY, 
PersonName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8,2) NOT NULL, 
JoiningDate DATETIME NULL, 
City VARCHAR(100) NOT NULL, 
Age INT NULL, 
BirthDate DATETIME NOT NULL 
);

-- Creating PersonLog Table 
CREATE TABLE PersonLog ( 
PLogID INT PRIMARY KEY IDENTITY(1,1), 
PersonID INT NOT NULL, 
PersonName VARCHAR(250) NOT NULL, 
Operation VARCHAR(50) NOT NULL, 
UpdateDate DATETIME NOT NULL
);



--From the above given tables perform the following queries: 

--------------------------PART-A

--1)Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display 
--a message "Record is Affected."

------FOR INSERT

create trigger tr_insert_recoredAffected
on PersonInfo
after insert
as
begin
	print 'Record is inserted!!'
end


insert into PersonInfo
values(103,'mansi',13000,'2020-05-12','botad',19,'2000-05-23')


select * from PersonInfo


------FOR UPDATE

create or alter trigger tr_update_recoredAffected
on PersonInfo
after update
as
begin
	print 'Record is updated!!'
end


update PersonInfo
set PersonName='janvi'
where PersonID=101

select * from PersonInfo


------FOR DELETE

create or alter trigger tr_update_recoredAffected
on PersonInfo
after delete
as
begin
	print 'Record is deleted!!'
end


delete from PersonInfo
where PersonID=103

select * from PersonInfo



--2)Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, 
--log all operations performed on the person table into PersonLog.

--FOR INSERT

create or alter trigger tr_insert_log
on PersonInfo
after insert
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'Record is inserted!',getdate())

end

insert into PersonInfo values(103,'mansi',12000,'2020-07-01','botad',20,'2000-09-01')

select * from PersonInfo

select * from PersonLog


---FOR UPDATE

create or alter trigger tr_update_log
on PersonInfo
after update
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'Record is updated!',getdate())
end


update PersonInfo
set PersonName='khushi'
where PersonID=101


select * from PersonInfo

select * from PersonLog


---FOR DELETE

create or alter trigger tr_deleteData_insert_log
on PersonInfo
after delete
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from deleted

	insert into PersonLog
	values(@pid,@pname,'Record is deleted!',getdate())
end


delete from PersonInfo
where PersonID=102

select * from PersonInfo

select * from PersonLog



--------------jyare prevents name no keyword aave tyare always instead of trigger j aavse


--3)Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo 
--table. For that, log all operations performed on the person table into PersonLog.


--FOR INSERT

create or alter trigger tr_insteadOf_insert_log
on PersonInfo
instead of insert
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'Record is inserted!',getdate())
end

insert into PersonInfo values(104,'mansi',12000,'2020-07-01','botad',20,'2000-09-01')

select * from PersonInfo

select * from PersonLog


---FOR UPDATE

create or alter trigger tr_insteadOf_update_log
on PersonInfo
instead of update
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from inserted

	insert into PersonLog
	values(@pid,@pname,'Record is updated!',getdate())
end

update PersonInfo
set PersonName='nandu'
where PersonID=103


select * from PersonInfo

select * from PersonLog


---FOR DELETE

create or alter trigger tr_insteadOf_delete_log
on PersonInfo
instead of delete
as
begin
	declare @pid int
	declare @pname varchar(100)

	select @pid = PersonID , @pname = PersonName from deleted

	insert into PersonLog
	values(@pid,@pname,'Record is deleted!',getdate())
end


delete from PersonInfo
where PersonID=101

select * from PersonInfo

select * from PersonLog



--4)Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into 
--uppercase whenever the record is inserted.

create or alter trigger tr_insert_upperName
on PersonInfo
instead of insert
as
begin
	declare @pname varchar(100)
	declare @pid int

	select @pname = PersonName,@pid=PersonID from inserted
	
	update PersonInfo
	set PersonName=upper(@pname)
	where PersonID=@pid
end

insert into PersonInfo values(104,'Janvi',12000,'2020-07-01','botad',20,'2000-09-01')

select * from PersonInfo

select * from PersonLog


drop trigger tr_

--5)Create trigger that prevent duplicate entries of person name on PersonInfo table.

create or alter trigger tr_prevent_duplicate_name
on PersonInfo
instead of insert
as
begin
	insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate)
	select PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate from inserted
	where PersonName not in (select PersonName from PersonInfo)
end




















-------------PART-C------------

--9)Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL during an INSERT.

create or alter trigger tr_joiningDate_AutoUpdate
on PersonInfo
after insert
as
begin
	declare @Person_Id int
	select @Person_Id = PersonId from inserted

	update PersonInfo
	set JoiningDate=getdate()
	where JoiningDate is null
end


--10)Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints 
--‘Record deleted successfully from PersonLog’.

create or alter trigger tr_delete_on_PersonLog
on PersonLog
after delete
as
begin
	print('Record deleted successfully from PersonLog')
end