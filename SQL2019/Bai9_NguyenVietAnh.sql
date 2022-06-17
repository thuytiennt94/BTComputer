create database Quanlysinhvien9
go
use Quanlysinhvien9
go

--B?NG TBLOPHOC
CREATE TABLE tbLophoc(
    MaLop char(10) PRIMARY KEY,
    TenLop nvarchar(10) NOT NULL,
    SiSoToida int DEFAULT 25 CHECK(SiSoToida > 0)
)
go
INSERT INTO tbLophoc VALUES ('L01', 'T2108M', 4)
INSERT INTO tbLophoc VALUES ('L02', 'T2109M', 5)
INSERT INTO tbLophoc VALUES ('L03', 'T1307M', 6)
INSERT INTO tbLophoc VALUES ('L04', 'T1408M', 3)
INSERT INTO tbLophoc VALUES ('L05', 'T1508M', 3)
GO
SELECT * FROM tbLophoc 
--B?NG TBSINHVIEN
CREATE TABLE tbSinhvien(
    MaSV char(10) PRIMARY KEY,
    Ho nvarchar(10) DEFAULT 'Lastname',
    Ten nvarchar(20) DEFAULT 'Firstname',
    Ngaysinh datetime NULL,
    Gioitinh bit DEFAULT 0,
    MaTruongNhom char(10) NULL FOREIGN KEY REFERENCES tbSinhvien(MaSV),
    MaLop char(10) FOREIGN KEY REFERENCES tbLophoc
)
go

INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV01', N'Nguy?n',N'V?n An','11-11-2004',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV02', N'??',N'Hà Linh', '03-23-2003', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV03', N'Tr?n',N'V?n Bình','12-11-2003','SV03','L02')
INSERT INTO tbSinhvien VALUES ('SV04', N'Tr?n',N'Minh Hà', '03-14-2002', 1,NULL,'L03')
INSERT INTO tbSinhvien VALUES ('SV05', N'Nguy?n',N'Th? Mai', '10-23-2004', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV06', N'Lê',N'Chí Thành', '12-10-2003','SV03','L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV07', N'??',N'V?n C??ng', '10-10-2003','SV04','L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV08', N'Nguy?n',N'Tr??ng Giang', '09-12-2003',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV09', N'Lê',N'Vân Hà','12-23-2001', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV10', N'Mai',N'V?n D?ng', '10-04-2003',NULL,'L02')
INSERT INTO tbSinhvien VALUES ('SV11', N'Hà',N'Th? Ph??ng', '02-12-2003', 1,'SV04', 'L03')
INSERT INTO tbSinhvien VALUES ('SV12', N'Tr?n',N'Kim Xuy?n', '07-10-2003', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV13', N'Lê',N'??c C??ng', '12-10-2004',NULL,'L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV14', N'Nguy?n',N'??c Duy','10-10-2002',NULL,'L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV15', N'Nguy?n',N'Duy Linh','11-10-2002',NULL,'L04')
go
select * from tbSinhvien
update tbSinhvien set MaTruongNhom='SV13' where MaSV='SV10'

create table tbMonhoc(
Mamon char(10) primary key,
Tenmon nvarchar(30) not null unique,
Mota ntext
)

INSERT INTO tbMonhoc VALUES ('MH01',N'L?p trình C', N'abcdef')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH02',N'Thi?t k? Web')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH03', N'Thi?t k? CSDL')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH04', N'AI')

create table tbBangdiem(
MaSV char(10) foreign key references tbSinhvien(MaSV),
Mamon char(10) foreign key references tbMonhoc(Mamon),
Diemthi float default 0,
Ngaythi datetime default getdate(),
constraint pk_Bangdiem primary key (MaSV,Mamon)
)
INSERT INTO tbBangDiem VALUES ('SV01','MH01', 7.5, '08-23-2021')
INSERT INTO tbBangDiem VALUES ('SV01','MH02', 9.2, '07-20-2021')
INSERT INTO tbBangDiem VALUES ('SV01','MH03', 8.2, '07-20-2021')
INSERT INTO tbBangDiem VALUES ('SV02','MH01', 8.7, '08-22-2021')
INSERT INTO tbBangDiem VALUES ('SV03','MH02', 6.4, '08-20-2021')
INSERT INTO tbBangDiem VALUES ('SV03','MH03', 10, '08-20-2021')
INSERT INTO tbBangDiem VALUES ('SV03','MH01', 9.2, '08-21-2021')
INSERT INTO tbBangDiem VALUES ('SV04','MH01', 9.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV04','MH02', 8.7, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV04','MH03', 7.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV05','MH01', 7.5, '08-23-2021')
INSERT INTO tbBangDiem VALUES ('SV06','MH02', 6.3, '07-20-2021')
INSERT INTO tbBangDiem VALUES ('SV07','MH01', 8.7, '08-22-2021')
INSERT INTO tbBangDiem VALUES ('SV08','MH02', 6.4, '08-20-2021')
INSERT INTO tbBangDiem VALUES ('SV09','MH01', 9.2, '08-21-2021')
INSERT INTO tbBangDiem VALUES ('SV10','MH01', 9.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV10','MH03', 7.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV12','MH01', 7.3, '08-20-2021')
INSERT INTO tbBangDiem VALUES ('SV12','MH02', 9.3, '08-20-2021')
INSERT INTO tbBangDiem VALUES ('SV13','MH01', 9.2, '08-21-2021')
INSERT INTO tbBangDiem VALUES ('SV13','MH02', 5.2, '08-21-2021')
INSERT INTO tbBangDiem VALUES ('SV14','MH01', 9.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV14','MH03', 7.2, '02-12-2021')
INSERT INTO tbBangDiem VALUES ('SV14','MH02', 8.5, '02-12-2021')

--1.View vTTSinhvien: Hi?n th? thông tin sinh viên g?m ??y ?? các c?t c?a b?ng tbSinhvien và c?t TenLop t? b?ng tbLophoc
Create view vTTSinhvien
as
Select SV.*, LH.Tenlop from tbSinhvien SV inner join tbLophoc LH on SV.MaLop=LH.MaLop
Go
select * from vTTSinhvien
go
--2.View vTTSinhvienASC Hi?n th? thông tin 100 sinh viên và l?p h?c, s?p x?p theo Tên t?ng d?n
Create View vTTSinhvienASC
as
select top(100) * from tbSinhvien order by Ten ASC
go
select * from vTTSinhvienASC
--3.View vSosinhvienTunglop Hi?n th? Mã l?p, tên l?p và ??m s? sinh viên c?a t?ng l?p
create view vSosinhvienTunglop 
as
select LH.MaLop,LH.TenLop,Count(MaSV) as [S? sinh viên] from tbLophoc LH inner join tbSinhvien SV on SV.MaLop=LH.MaLop group by LH.MaLop,LH.TenLop
go
select * from vSosinhvienTunglop 
--4.View vDiemTrungBinhMon Hi?n th? Mã Môn, Tên môn h?c, ?i?m trung bình c?a t?ng môn
create view vDiemTrungBinhMon
as
select MH.MaMon,MH.TenMon,avg(Diemthi) as [Điểm trung bình] from tbMonhoc MH inner join tbBangDiem BD on MH.MaMon=BD.MaMon group by MH.MaMon,MH.TenMon
select * from vDiemTrungBinhMon
--5.Nh?p thêm sinh viên m?i thông qua View vTTSinhvien
insert into tbSinhvien VALUES ('SV16', N'Nguy?n',N'Vi?t Anh', '09-14-2003', 1,'SV08', 'L01')
--6.Update m?t sinh viên qua View vTTSinhvien
UPDATE vTTSinhvien SET Malop='L02' WHERE MaSV='SV16'
--7.Xóa m?t sinh viên qua View vTTSinhvien
delete from  vTTSinhvien WHERE MaSV='SV12'





