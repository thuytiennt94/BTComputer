create database VietTours_company
go
use VietTours_company
go
create table Tours(
	TourID int identity(1,1) primary key,
	TourName nvarchar(200) not null,
	Days tinyint,
	Nights tinyint,
	Image varchar(150),
	Description nvarchar(500),
	Price money check(Price > 0)
)
go
insert into Tours values (N'Tour Hạ Long', 2,1,'Image HaLong',N'Điểm đến là Hạ Long',12000000 )
insert into Tours values (N'Tour Cà Mau', 3,2,'Image CaMau',N'Điểm đến là Cà Mau',22000000 )
insert into Tours values (N'Tour Ba Vì', 1,0,'Image BaVi',N'Điểm đến là Ba Vì',16000000 )
select * from Tours

create table TourDetails(
	TourDetailID int primary key identity(1,1),
	TourID int foreign key references Tours(TourID),
	Day tinyint,
	Place nvarchar(100) not null,
	Detail nvarchar(200),
	Vehicle nvarchar(100)
)
go
insert into TourDetails(TourID,Day,Place,Vehicle) values (01,2,N'Hạ Long',N'2 xe 4 chỗ')
insert into TourDetails(TourID,Day,Place,Vehicle) values (02,3,N'Cà Mau',N'Máy bay')
insert into TourDetails(TourID,Day,Place,Vehicle) values (03,2,N'Ba Vì',N'1 xe 25 chỗ')
select * from TourDetails

--1. Create database named VNTours.
--2. Create tables with constraints as design above.
--3. Insert into each table at lease 3 records.
--4. Write a query to select from Tours table where TourName or Description contains ‘Ha Long’.
select * from Tours where TourName = N'Hạ Long' or Description = N'Hạ Long'
go
--5. Write a query to get tours that have days and nights less than 3 and Price less than 10 million.
create view v_ToursDay
as
select * from Tours where Day <3 and Night <3 and Prive < 10000000
go
--6. Create index on column TourName of Tours table.
create index idx_ToursName on Tours(TourName)
--7. Create a view named v_TourInfor about one tour that display TourName, Price,
--Day, Place, Detail and Vehicle from Tours and TourDetails tables.
create view v_TourInfor 
as
select TS.TourName,TS.Price,TD.Day,TD.Place,TD.Detail,TD.Vehicle from Tours TS inner join TourDetails TD on TS.TourID = TD.TourID
group by TS.TourName,TS.Price,TD.Day,TD.Place,TD.Detail,TD.Vehicle 
--8. Create a stored procedure named sp_FindTourByName that accepts keyword as
--given input and display all tours that have TourName contain the keyword.
create proc sp_FindTourByName @Keyword nvarchar(200)
as 
	select * from Tours where TourName Like N'%' + @Keyword + '%'
go
exec sp_FindTourByName N'Tour Cà Mau'
go
--9. Create a trigger named tg_RemoveTour that allows delete information relating to a
--tour when this tour is deleted from the table Tours (delete information in table TourDetails)
delete from Tours where TourName = N'Tour Ba Vì'
go

create trigger tg_RemoveTour 
on Tours
INSTEAD OF DELETE 
as
	declare @Tourid int 
	select @Tourid = TourID from deleted -- Lấy mã tour dag định xoá từ lệnh detele
	if exists(select * from TourDetails where @Tourid = TourID)
	begin
		delete from TourDetails where @Tourid = TourID
	end
	delete from Tours where @Tourid = TourID
	print N'Xoá Thành Công'
go
--thử chạy trigger
delete from Tours where TourID = 2
go