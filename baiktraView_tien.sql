create database VNTours
go
use VNTours
go
create table Tours(
	TourID int primary key identity,
	TourName nvarchar(200) not null,
	Days tinyint,
	Nights tinyint,
	Image varchar(150),
	Description nvarchar(500),
	Price money check(Price>0)
)
go
insert into Tours values (N'Tour Hạ Long', 2,1,'Image HaLong',N'Đẹp',12000000 )
insert into Tours values (N'Tour Cà Mau', 3,2,'Image CaMau',N'Đẹp',22000000 )
insert into Tours values (N'Tour Ba Vì', 1,0,'Image BaVi',N'Đẹp',16000000 )
select * from Tours

create table TourDetails(
	TourDetailID int primary key identity,
	TourID int foreign key REFERENCES Tours(TourID),
	Day tinyint,
	Place varchar(100) not null,
	Detail nvarchar(200),
	Vehicle nvarchar(100)
)
go
insert into TourDetails(TourID,Day,Place,Vehicle) values (01,2,N'Hạ Long',N'2 xe 4 chỗ')
insert into TourDetails(TourID,Day,Place,Vehicle) values (02,3,N'Cà Mau',N'Máy bay')
insert into TourDetails(TourID,Day,Place,Vehicle) values (03,2,N'Ba Vì',N'1 xe 25 chỗ')

select * from TourDetails

-- Write a query to select from Tours table where TourName or Description contains
create view v_TourHaLong
as
select * from Tours where TourName = N'Tour Hạ Long'
go
--Write a query to get tours that have days and nights less than 3 and Price less than 10 million.
create view v_ToursDay
as
select * from Tours where Days <3 and Nights<3 and Price < 10000000
go
--Create a view named v_TourInfor about one tour that display TourName, Price, Day, Place, Detail and Vehicle from Tours and TourDetails tables.
create view v_TourInfor
as
select TS.TourName,TS.Price, TD.DAY, TD.Place, TD.Detail, TD.Vehicle from Tours TS inner join TourDetails TD 
on TS.TourID = TD.TourID
go