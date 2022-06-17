create database ExamPager 
go
use ExamPager 
go
create table tblLocation(
	LocationID char(6) primary key,
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go
insert into tblLocation(LocationID,Name, Description) values (027,N'Mỹ Đình', N'có sân vận động to, đẹp')
insert into tblLocation(LocationID,Name, Description) values (042,N'Tràng Tiền',N'Địa Điểm có kem ngon')
insert into tblLocation(LocationID,Name) values (012,N'Hồ Tây')
select * from tblLocation 

create table tblLand(
	LandID int Primary key identity,
	Title nvarchar(100) Not null,
	LocationID char(6) FOREIGN KEY REFERENCES Location,
	Detail nvarchar(1000),
	StartDate datetime not null,
	EndDate datetime not null
)
go
insert into tblLand(Title,LocationID,Detail,StartDate,EndDate) values (N'momoland', 2, N'good', '4-2-1999', '3-5-2011')
insert into tblLand(Title,LocationID,Detail,StartDate,EndDate) values (N'Đảo hồng', 3, N'đẹp', '8-7-2011', '4-2-2020')
insert into tblLand(Title,LocationID,Detail,StartDate,EndDate) values (N'IceLand', 1, N'đẹp', '8-9-2011', '4-12-2023')
insert into tblLand(Title,LocationID,Detail,StartDate,EndDate) values (N'Hotland', 2, N'nóng', '4-8-2013', '27-5-2019')
select * from tblLand

create table tblBuilding(
	BuildingID int Primary key identity,
	LandID int FOREIGN KEY REFERENCES Land,
	BuildingType nvarchar(50),
	Area int check(Area > 50),
	Floors int check(Floors>1),
	Rooms int check(Rooms>1),
	Cost money
)
go
insert into tblBuilding(LandID,BuildingType,Area,Floors,Rooms,Cost) values('1','Villas', 100,2,5,16000000)
insert into tblBuilding(LandID,BuildingType,Area,Floors,Rooms,Cost) values (2,N'apartment',60,3,6,650000)
insert into tblBuilding(LandID,BuildingType,Area,Floors,Cost) values (1,N'Villas',120,5,1000000)
insert into tblBuilding(LandID,BuildingType,Area,Floors,Cost) values (3,N'Supermarket',40,2,1650000)
insert into tblBuilding(LandID,BuildingType,Area,Cost) values (2,N'Supermarket',50,920000)
insert into tblBuilding(LandID,BuildingType,Area,Floors,Rooms,Cost) values (3,N'apartment',75,17,4,2540000)
select * from tblBuilding


--1. Create a database as requested above.

--2. Create table based on the above design.

--3. Insert into each table at least three records.

--4. List all the buildings with a floor area of 100m2 or more.
select * from tblBuilding where area > 100
--5. List the construction land will be completed before January 2013.
select * from tblLand where StartDate < '1/1/2013'
--6. List all buildings to be built in the land of title "My Dinh”
select * from tblLocation where Name = N'Mỹ Đình'
--7. Create a view v_Buildings contains the following information (BuildingID, Title, Name, BuildingType, Area, Floors) 
--from table Building, Land and Location.
create view v_Buildings 
as
	select BD.BuildingID,LD.Title,LT.Name,BD.BuildingType,BD.Area,BD.Floos from tblBuilding BD inner join tblLand LD on BD.LandID = LD.LandID
	inner join tblLocation LT on LT.LocationID = LD.LocationID 
go
exec v_Buildings 
go
--8. Create a view v_TopBuildings about 5 buildings with the most expensive price per m2.
create view v_TopBuildings
as
	select top(5) tblBuilding.Cost from tblBuilding order by Cost desc
go
exec v_TopBuildings
go
--9. Create a store called sp_SearchLandByLocation with input parameter is the area code and retrieve planned land for this area.
create proc sp_SearchLandByLocation @area int
as
	select  from tblBuilding where @area = Area 
go

--10. Create a store called sp_SearchBuidingByLand procedure input parameter is the land
--code and retrieve the buildings built on that land.
create proc sp_SearchBuidingByLand @area int
as
	select * from tblBuilding where @area = Area
go
declare @area int
exec sp_SearchBuidingByLand 100
go
--11. Create a trigger tg_RemoveLand allows to delete only lands which have not any buildings built on it.
create trigger tg_RemoveLand 
on tblBuilding
instead of delete
as
	declare @landid int
	select @landid = LandID from deleted
	if exists(select * from tblBuilding where @landid = LandID)
	begin
		delete from tblBuilding where LandID = @landid
		delete from tblLand where LandID = @landid
		print N'Xoá vùng đất và nhà thành công'
	end
	else
	begin
		delete from tblLand where LandID = @landid
		print N'Xoá vùng đất thành công'
	end
go
delete from tblLand where LandID = N'Đảo hồng'
go