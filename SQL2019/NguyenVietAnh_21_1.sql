Create database VNTours
go
use VNTours
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
create table TourDetails(
TourDetailID int primary key identity(1,1),
TourID int foreign key references Tours(TourID),
Day tinyint,
Place varchar(100) not null,
Detail nvarchar(200),
Vehicle nvarchar(100)
)
go  
insert into Tours values (N'Tour H� N?i',5,4,N'Thumbnail image path',N'Description of tour',2600)

go
insert into Tours values (N'Tour Nha Trang',3,2,N'?nh Nha Trang',N'M� t? v? Tour',3000)
go
insert into Tours values (N'Tour ?� N?ng',4,3,N'?nh ?� N?ng',N'M� t? v? Tour',2500)
go
insert into Tours values (N'Tour Ha Long',4,3,N'?nh Ha Long',N'M� t? v? Tour',4100)
go
select * from Tours
go
insert into TourDetails values(1,5,N'H� N?i',N'Th�ng tin',N'Xe 16 ch?')
go
insert into TourDetails values(2,3,N'Nha Trang',N'Details',N'M�y bay')
go
insert into TourDetails values(3,4,N'?� N?ng',N'Th�ng tin',N'Xe 16 ch?')
go
select * from TourDetails
go
--4.Write a query to select from Tours table where TourName or Description contains �Ha Long�.
create view v_HaLong
as
select * from Tours where TourName=N'Tour Ha Long'
go
--5.Write a query to get tours that have days and nights less than 3 and Price less than 10 million.
update Tours set Price = 11000  where TourName=N'Tour ?� N?ng'
Update Tours set Days=2, Nights=1 where TourName=N'Tour Nha Trang'
create view v_ToursShort
as
select * from Tours where Days<3 and Nights<3 and Price< 10000
go
--7.Create a view named v_TourInfor about one tour that display TourName, Price, 
--Day, Place, Detail and Vehicle from Tours and TourDetails tables.
Create view v_TourInfor
as
select T.TourName,T.Price,TD.Day,TD.Place,TD.Detail ,TD.Vehicle from Tours T inner join TourDetails TD on T.TourID=TD.TourID
go
