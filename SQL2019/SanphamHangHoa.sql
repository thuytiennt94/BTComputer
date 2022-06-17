﻿{CREATE DATABASE QuanlyHanghoa
--drop Database QuanlyHangHoa
GO
USE QuanlyHangHoa
GO
CREATE TABLE tbSanpham(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Code char(10) NOT NULL UNIQUE,
	Name nvarchar(30)  NULL UNIQUE,
	Price float NULL,
	Status BIT NULL 
)
go}
select * from tbSanpham1
insert into tbSanpham1(Code,Name,Price,Status) values('P01','Sữa chua Vinamilk', '30000',1)
insert into tbSanpham1(Code,Name,Price,Status) values('P02','Bánh Gạo', '35000',0)
insert into tbSanpham1(Code,Name,Price,Status) values('P03','Cafe G7', '20000',1)
insert into tbSanpham1(Code,Name) values('P04','Mỳ tôm chua cay')
insert into tbSanpham1(Code,Name,Price) values('P05','Bánh Chocopie','40000')
