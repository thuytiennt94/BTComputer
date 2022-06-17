create database baiktra
go 
use baiktra
go 
create table tbLocation (
	LocationID char(6) Primary key,
	Name nvarchar(50) not null,
	Description nvarchar(100)
)
go
insert into tbLocation values ('1',N'ABB',N'Đẹp')
insert into tbLocation(LocationID,Name) values ('2',N'AFG')
insert into tbLocation(LocationID,Name) values ('3',N'BDG')
select * from tbLocation
delete from tbLocation
go

create table tbLand1 (
	LandID int primary key identity,
	Title nvarchar(100) not null,
	LocationID char(6) foreign key REFERENCES tbLocation(LocationID),
	Detail nvarchar(1000),
	StartDate datetime not null,
	EndDate datetime not null
)
go 
insert into tbLand1(Title,LocationID,Detail,StartDate,EndDate) values (N'momoland', 2, N'Xinh, đẹp', '4-2-1999', '3-5-2011')
insert into tbLand1(Title,LocationID,Detail,StartDate,EndDate) values (N'Đảo hồng', 3, N'đẹp', '8-7-2011', '4-2-2020')
insert into tbLand1(Title,LocationID,Detail,StartDate,EndDate) values (N'IceLand', 1, N'đẹp', '8-9-2011', '4-12-2023')
insert into tbLand1(Title,LocationID,Detail,StartDate,EndDate) values (N'Hotland', 2, N'nóng', '4-8-2013', '27-5-2019')

select * from tbLand1
--delete from tbLand1
go

create table tbBuilding(
	BuildingID int primary key identity,
	LandID int foreign key references tbLand(LandID),
	BuildingType nvarchar(50),
	Area int default 50,
	Floors int default 1,	
	Rooms int default 1,
	Cost money 
)
go
insert into tbBuilding1(LandID,BuildingType,Area,Floors,Rooms,Cost) values('1','Villas', 100,2,5,16000000)
insert into tbBuilding1(LandID,BuildingType,Area,Floors,Rooms,Cost) values (2,N'apartment',60,3,6,650000)
insert into tbBuilding1(LandID,BuildingType,Area,Floors,Cost) values (1,N'Villas',120,5,1000000)
insert into tbBuilding1(LandID,BuildingType,Area,Floors,Cost) values (3,N'Supermarket',40,2,1650000)
insert into tbBuilding1(LandID,BuildingType,Area,Cost) values (2,N'Supermarket',50,920000)
insert into tbBuilding1(LandID,BuildingType,Area,Floors,Rooms,Cost) values (3,N'apartment',75,17,4,2540000)
select * from tbBuilding1

--List all the buildings with a floor area of 100m2 or more.
select * from tbBuilding where tbBuilding.Cost >= 100
--List the construction land will be completed before January 2013.
select * from tbLand1 where tbLand1.EndDate < '1-1-2013'
--List all buildings to be built in the land of title "My Dinh”
select tbBuilding.* from tbBuilding inner join tbLand1 on tbBuilding.LandID = tbLand1.LandID 
where tbLand1.Title = 'My Dinh'
--Create a view v_Buildings contains the following information (BuildingID, Title, Name,
--BuildingType, Area, Floors) from table Building, Land and Location.
create view building_home 
as 
select tbBuilding.BuildingID,tbLand1.Title, tbLocation.Name, tbBuilding.BuildingType, tbBuilding.Area, tbBuilding.Floors
from tbBuilding inner join tbLand1 on tbBuilding.LandID = tbLand1.LandID 
inner join tbLocation on tbLocation.LocationID= tbLand1.LocationID
go 
select * from building_home 
go

--Create a view v_TopBuildings about 5 buildings with the most expensive price per m2.
create view v_TopBuildings
as
select top(5) tbBuilding.Cost from tbBuilding order by Cost desc
go
select * from v_TopBuildings
go