create database AZBank
go
use AZBank
go
create table Customer(
	CustomerID int not null primary key,
	Name nvarchar(50) null,
	City nvarchar(50) null,
	Country nvarchar(50) null,
	Phone nvarchar(15) null,
	Email nvarchar(50) null,

)
go
insert into Customer(Name,City,Country,Phone,Email) values (N'Trần Thành',N'Hà Nội', N'Việt Nam', N'0973829254', 'thanh32@gmail.com')
insert into Customer(Name,City,Country,Phone,Email) values (N'Lê Thảo',N'Hà Nội', N'Việt Nam', N'0847287482', 'lethaothao472@gmail.com')
insert into Customer(Name,City,Country,Phone,Email) values (N'Nguyễn Đức Anh',N'Tp.Hồ Chí Minh', N'Việt Nam', N'0963742627', 'ducanhnguyen3@gmail.com')
insert into Customer(Name,City,Country,Phone,Email) values (N'Hoàng Dũng ',N'Hải Phòng', N'Việt Nam', N'0837461386', 'dunghoangmen66@gmail.com')
select*from Customer 

create table CustomerAccount(
	AccountNumber char(9) not null primary key ,
	CustomerID int not null foreign key references Customer(CustomerID),
	Balance money not null,
	MinAccount money 
)
go
insert into CustomerAccount(AccountNumber,CustomerID,Balance) values ('A142',2,23000)
insert into CustomerAccount(AccountNumber,CustomerID,Balance) values ('A143',3,45000)
insert into CustomerAccount(AccountNumber,CustomerID,Balance) values ('A144',1,71000)
insert into CustomerAccount(AccountNumber,CustomerID,Balance) values ('A145',4,55000)
select * from CustomerAccount 

create table CustomerTransaction(
	TransactionID int not null primary key,
	AccountNumber char(9) null foreign key references CustomerAccount(AccountNumber),
	TransactionDate smalldatetime,
	Amount money,
	DepositorWithdraw bit
)
go
insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw) values ('A142', '2019-2-27', 30000, 0)
insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw) values ('A145', '2017-11-8', 78000, 1)
insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw) values ('A144', '2020-9-30', 69000, 1)
insert into CustomerTransaction(AccountNumber,TransactionDate,Amount,DepositorWithdraw) values ('A143', '2018-5-17', 58900, 1)
select * from CustomerTransaction
--1. Create database named AZBank.
--2. In the AZBank database, create tables with constraints as design above.
--3. Insert into each table at least 3 records.
--4. Write a query to get all customers from Customer table who live in ‘Hanoi’.
select * from Customer where City like  N'Hà Nội'
go
--5. Write a query to get account information of the customers (Name, Phone, Email,AccountNumber, Balance).
select CR.Name,CR.Phone, CR.Email,CA.AccountNumber, CA.Balance  from Customer CR inner join CustomerAccount CA 
on CA.CustomerID = CR.CustomerID 
go
--6. A-Z bank has a business rule that each transaction (withdrawal or deposit) won’t be over $1000000 (One million USDs). 
--Create a CHECK constraint on Amount column of CustomerTransaction table to check that each transaction amount is greater than
--0 and less than or equal $1000000.
ALTER TABLE CustomerTransaction ADD CONSTRAINT CK_tiengiaodich CHECK (Amount > 0 and Amount <= 100000)

--7. Since the A-Z Bank usually searches for customers by their names, make a non-clustered index on column Name of Customer table.
CREATE NONCLUSTERED INDEX Customers ON Customer(Name)

--8. Create a view named vCustomerTransactions that display Name, AccountNumber, TransactionDate, Amount,
--and DepositorWithdraw from Customer, CustomerAccount and CustomerTransaction tables.
create view vCustomerTransactions 
as
	select CR.Name,CT.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw from Customer CR inner join CustomerAccount CA on CR.CustomerID = CA.CustomerID 
	inner join CustomerTransaction CT on CA.AccountNumber = CT.AccountNumber
go
select * from vCustomerTransactions
go
--9. Create a stored procedure named spAddCustomer with Customer Id, Customer Name, Country, Phone and Email 
--as input parameters to insert data into Customer table. Using this stored procedure to insert some records into Customer table.
create proc spAddCustomer @idkhachhang int, @tenkh nvarchar(50), @quocgia nvarchar(50), @dt nvarchar(50), @email nvarchar
as
	insert into Customer(CustomerID,Name,Country,Phone,Email) values (@idkhachhang,@tenkh,@quocgia,@dt,@email)
go
exec spAddCustomer 5,N'Lý Ngọc', N'Việt Nam', N'0863728918', 'ngocman803@gmail.com'
go

--10.Create a stored procedure named spGetTransactions which accepts AccountNumber, FromDate, ToDate as input parameters \
--and displays transaction detail of specified account including transaction date, amount, transaction type (depositor or withdraw).
create proc spGetTransactions @AN char(9), @fromD smalldatetime, @toDate smalldatetime
as
	select AccountNumber,TransactionDate from CustomerTransaction where @AN = AccountNumber and TransactionDate between @fromD and @toDate
go
exec spGetTransactions 'A142', '2018-3-15', '2023-4-31'
go