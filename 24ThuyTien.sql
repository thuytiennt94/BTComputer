create database QuanliHangHoa5
go
use QuanliHangHoa5
go
create table tbCategory1(
	CatID int identity(1,1) primary key,
	CatName Nvarchar(30) not null,
	CatStatus bit null
)
go
insert into tbCategory1 values (N'Đồ uống',1)
insert into tbCategory1 values (N'Bánh kẹo',1)
insert into tbCategory1 values (N'Đồ ăn',1)
select * from tbCategory1
--delete from tbCategory
create table tbSanpham2(
	Id int identity(1,1) primary key not null,
	Code char(10) not null unique,
	Name Nvarchar(30) unique null,
	Price float null,
	Quantity int null,
	Status bit null,
	CatID int NOT NULL FOREIGN KEY REFERENCES tbCategory1(CatID)
)
go
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P01',N'Sữa chua vinamilk', 30000, 10, 1,1)
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P02',N'Bánh gạp', 35000, 5, 1, 2)
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P03',N'Cafe G7', 20000, 8, 0, 1)
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P04',N'Mì tôm chua cây', 5000, 3, 1,3)
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P05',N'Bánh Chocopie', 40000, 10, 0, 2)
	insert into tbSanpham2(Code,Name,Price,Quantity,Status,CatID) values ('P06',N'Trà Lipton', 25000, 10, 1,1)
	insert into tbSanpham2(Code,Name,Quantity,Status,CatID) values ('P07','Xúc xích Đức',5, 1,3)
select * from tbSanpham2
delete from tbSanpham2
--1.Hiển thị Mã nhóm (CatID) và giá trung bình của mỗi nhóm
select CatID, avg(Quantity) AS Giatrungbinh from tbSanpham2 group by CatID
--2.Hiển thị Mã nhóm (CatID) và giá cao nhất của từng nhóm
select CatID,Price from tbSanpham2 group by CatID,Price order by tbSanpham2.Price desc
--3.Hiển thị Mã nhóm (CatID) và tổng số lượng sản phẩm của từng nhóm
select CatID, sum(tbSanpham2.Quantity) as Soluong from tbSanpham2 group by CatID, Quantity

--4.Hiển thị Mã nhóm (CatID) và tổng giá (Price*Quantity) của từng nhóm
select tbSanpham2.CatID, sum(tbSanpham2.Price * tbSanpham2.Quantity) as tongsp from tbSanpham2, tbCategory1 group by tbSanpham2.CatID

--Hiển thị Mã nhóm (CatID) và giá trung bình của mỗi nhóm, chỉ hiện thị các nhóm có giá trung bình >30.000
select tbSanpham2.CatID, avg(tbSanpham2.Price) as GiaTB from tbSanpham2 group by tbSanpham2.CatID having avg(Price) > 30000

--Hiển thị Mã nhóm (CatID) và giá trung bình của các sản phẩm có Status=1 của mỗi nhóm
select tbSanpham2.CatID, avg(Price) as Giatb from tbSanpham2 where Status=1 group by CatID,Price 

--Hiển thị Mã nhóm (CatID) và giá trung bình của các sản phẩm có Status=1 của mỗi nhóm, chỉ hiện thị các nhóm có giá trung bình &gt; 20.000
select CatID,avg(Price) as Giatb from tbSanpham2 where Status = 1 group by CatID,Price having avg(Price) >20000

--Hiển thị Mã nhóm (CatID), Tên nhóm (CatName) và giá trung bình của mỗi nhóm
select tbSanpham2.CatID,avg(tbSanpham2.Price) as Giatb, tbCategory1.CatName from tbCategory1, tbSanpham2 where tbCategory1.CatID = tbSanpham2.CatID
group by tbSanpham2.CatID,tbCategory1.CatName, tbSanpham2.Price

