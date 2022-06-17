create database QuanlySinhvien9
go 
use QuanlySinhvien9
go
create table tbLophoc(
	Malop char(10) primary key,
	Tenlop nvarchar(30) not null,
	SiSoToida int default 25 check(SiSoToida>0)
)
go
insert into tbLophoc values ('L01', 'T2108M', 5)
insert into tbLophoc values ('L02', 'T1908A', 4)
insert into tbLophoc values ('L03', 'T2109M', 4)
insert into tbLophoc values ('L04', 'T2009A', 5)
select * from tbLophoc

create table tbSinhvien(
	MaSV char(10) primary key not null,
	Ho nvarchar(10) default 'LastName',
	Ten nvarchar(20) default 'FirstName',
	Ngaysinh date null,
	Gioitinh bit default 0,
	MaTruongNhom char(10) NULL FOREIGN KEY REFERENCES tbSinhvien(MaSV),
    MaLop char(10) FOREIGN KEY REFERENCES tbLophoc
)
go
insert into tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV01', N'Nguyễn',N'Văn Anh','1-11-2002',NULL,'L01')
insert into tbSinhvien VALUES ('SV02', N'Nguyễn',N'Thuỳ Anh', '04-26-2003', 1,'SV01','L01')
insert into tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV03', N'Trần',N'Văn Nam','10-6-2003','SV03','L02')
insert into tbSinhvien VALUES ('SV04', N'Đỗ',N'Thanh Hà', '09-24-2002', 1,NULL,'L03')
insert into tbSinhvien VALUES ('SV05', N'Nguyễn',N'Thị Mai', '5-22-2003', 1,'SV01','L01')
insert into tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV06', N'Lê',N'Chí Thành', '1-21-2003','SV03','L02')
insert into tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV07', N'Đỗ',N'Văn Cường', '7-17-2003','SV04','L03')
insert into tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV08', N'Nguyễn',N'Trường Giang', '09-12-2003',NULL,'L01')
insert into tbSinhvien VALUES ('SV09', N'Lê',N'Vân Hà','12-23-2001', 1,'SV08', 'L01')
select * from tbSinhvien

CREATE TABLE tbMonhoc(
    MaMon char(10) PRIMARY KEY,
    TenMon nvarchar(30) NOT NULL UNIQUE,
    Mota ntext
)
go
insert into tbMonhoc values ('MH01',N'Lập trình C', N'Khó')
insert into tbMonhoc(MaMon, TenMon) values ('MH02',N'Thiết kế Web')
insert into tbMonhoc(MaMon, TenMon) values ('MH03', N'CSDL')
insert into tbMonhoc(MaMon, TenMon) values ('MH04', N'Kĩ thuật AI')
select * from tbMonhoc


CREATE TABLE tbBangDiem(
    MaSV char(10) FOREIGN KEY REFERENCES tbSinhvien(MaSV),
    MaMon char(10) FOREIGN KEY REFERENCES tbMonhoc(MaMon),
    Diemthi float DEFAULT 0,
    Ngaythi datetime DEFAULT GETDATE(),
    CONSTRAINT PK_Bangdiem PRIMARY KEY(MaSV, MaMon) 
)
go
insert into tbBangDiem VALUES ('SV01','MH01', 7.5, '08-23-2021')
insert into tbBangDiem VALUES ('SV01','MH02', 9.2, '07-20-2021')
insert into tbBangDiem VALUES ('SV01','MH03', 8.2, '07-20-2021')
insert into tbBangDiem VALUES ('SV02','MH01', 8.7, '08-22-2021')
insert into tbBangDiem VALUES ('SV03','MH02', 6.4, '08-20-2021')
insert into tbBangDiem VALUES ('SV03','MH03', 10, '08-20-2021')
insert into tbBangDiem VALUES ('SV03','MH01', 9.2, '08-21-2021')
insert into tbBangDiem VALUES ('SV04','MH01', 9.2, '02-12-2021')
insert into tbBangDiem VALUES ('SV04','MH02', 8.7, '02-12-2021')
insert into tbBangDiem VALUES ('SV04','MH03', 7.2, '02-12-2021')
insert into tbBangDiem VALUES ('SV05','MH01', 7.5, '08-23-2021')
insert into tbBangDiem VALUES ('SV06','MH02', 6.3, '07-20-2021')
insert into tbBangDiem VALUES ('SV07','MH01', 8.7, '08-22-2021')
insert into tbBangDiem VALUES ('SV08','MH02', 6.4, '08-20-2021')
insert into tbBangDiem VALUES ('SV09','MH01', 9.2, '08-21-2021')
select * from tbBangDiem 


--Tạo View Thực hiện một số câu truy vấn sau
--1. View vTTSinhvien: Hiển thị thông tin sinh viên gồm đầy đủ các cột của bảng tbSinhvien và cột TenLop từ bảng tbLophoc
create view vTTSinhvien
as 
select SV.*, LH.Tenlop from tbSinhvien SV inner join tbLophoc LH on SV.MaLop=LH.Malop

--2. View vTTSinhvienASC Hiển thị thông tin 100 sinh viên và lớp học, sắp xếp theo Tên tăng dần
create view vTTSinhvienASC
as 
select top(100) * from tbSinhvien order by Ten ASC

--3. View vSosinhvienTunglop Hiển thị Mã lớp, tên lớp và đếm số sinh viên của từng lớp
create view vSosinhvienTunglop
as 
select SV.Ten, LH.Malop,LH.Tenlop, count(*) as SiSoToida from tbSinhvien SV inner join tbLophoc LH on SV.MaLop=LH.Malop
group by SV.Ten,LH.Malop,LH.Tenlop
--4. View vDiemTrungBinhMon Hiển thị Mã Môn, Tên môn học, Điểm trung bình của từng môn
create view vDiemTrungBinhMon
as 
select MH.MaMon,MH.TenMon, AVG(MH.TenMon* BD.Diemthi) as [Điểm trung bình] from tbBangDiem BD inner join tbMonhoc MH on BD.MaMon=MH.MaMon
group by MH.MaMon,MH.TenMon

--5. Nhập thêm sinh viên mới thông qua View vTTSinhvien
alter view vTTSinhvien 
as
select * from tbSinhvien where Gioitinh = 1
with check option
go

insert into vTTSinhvien VALUES('SV10',N'Đỗ',N'Thanh Thảo','2003-06-20',0,NULL,'L03')

--6. Update một sinh viên qua View vTTSinhvien
UPDATE vTTSinhvien SET Malop='L02' WHERE MaSV='SV04'

--7. Xóa một sinh viên qua View vTTSinhvien
delete from vTTSinhvien where MaSV = 'SV05'