CREATE DATABASE QuanlySinhvien8
go
use QuanlySinhvien8
go
--BẢNG TBLOPHOC
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
--BẢNG TBSINHVIEN
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
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV01', N'Nguyễn',N'Văn An','11-11-2004',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV02', N'Đỗ',N'Hà Linh', '03-23-2003', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV03', N'Trần',N'Văn Bình','12-11-2003','SV03','L02')
INSERT INTO tbSinhvien VALUES ('SV04', N'Trần',N'Minh Hà', '03-14-2002', 1,NULL,'L03')
INSERT INTO tbSinhvien VALUES ('SV05', N'Nguyễn',N'Thị Mai', '10-23-2004', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV06', N'Lê',N'Chí Thành', '12-10-2003','SV03','L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV07', N'Đỗ',N'Văn Cường', '10-10-2003','SV04','L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV08', N'Nguyễn',N'Trường Giang', '09-12-2003',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV09', N'Lê',N'Vân Hà','12-23-2001', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV10', N'Mai',N'Văn Dũng', '10-04-2003','SV08','L02')
INSERT INTO tbSinhvien VALUES ('SV11', N'Hà',N'Thị Phương', '02-12-2003', 1,'SV04', 'L03')
INSERT INTO tbSinhvien VALUES ('SV12', N'Trần',N'Kim Xuyến', '07-10-2003', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV13', N'Lê',N'Đức Cường', '12-10-2004',NULL,'L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV14', N'Nguyễn',N'Đức Duy','10-10-2002',NULL,'L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV15', N'Nguyễn',N'Duy Linh','11-10-2002',NULL,'L04')
go
SELECT * FROM tbSinhvien
go
--BẢNG TBMONHOC
CREATE TABLE tbMonhoc(
    MaMon char(10) PRIMARY KEY,
    TenMon nvarchar(30) NOT NULL UNIQUE,
    Mota ntext
)
go
INSERT INTO tbMonhoc VALUES ('MH01',N'Lập trình C', N'abcdef')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH02',N'Thiết kế Web')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH03', N'Thiết kế CSDL')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH04', N'AI')
SELECT * FROM tbMonhoc
--BẢNG TBBANGDIEM
CREATE TABLE tbBangDiem(
    MaSV char(10) FOREIGN KEY REFERENCES tbSinhvien(MaSV),
    MaMon char(10) FOREIGN KEY REFERENCES tbMonhoc(MaMon),
    Diemthi float DEFAULT 0,
    Ngaythi datetime DEFAULT GETDATE(),
    CONSTRAINT PK_Bangdiem PRIMARY KEY(MaSV, MaMon) 
)
go
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
SELECT * FROM tbBangDiem 
GO
--Tạo và sử dụng Stored Procedure
--1. Viết thủ tục spBangDiem hiển thị thông tin: Mã SV, Họ tên, Mã môn, Tên môn, Điểm thi.
CREATE PROCEDURE spBangDiem  
AS
	SELECT MH.MaMon,MH.TenMon,BD.Diemthi  FROM tbMonhoc MH inner join tbBangDiem BD 
	on BD.MaMon=MH.MaMon group by  MH.MaMon,MH.TenMon,BD.Diemthi
	select * from tbSinhvien
go

--Gọi thủ tục trên
EXEC spBangDiem
go
--2. Viết thủ tục spXemDiemTB, đầu vào là mã môn, thủ tục sẽ sử dụng vDiemTrungBinhMon
--và hiển thị điểm trung bình của môn đó, thủ tục trả về tổng số sinh viên có điểm lớn hơn điểm trung bình môn này. 
--Viết đoạn script để gọi thủ tục này và hiển thị số sinh viên có điểm lớn hơn trung bình trả về từ thủ tục.
CREATE PROCEDURE vDiemTrungBinhMon 
AS
	SELECT MH.MaMon,MH.TenMon,avg(BD.Diemthi) as DiemTB FROM tbBangDiem BD inner join tbMonhoc MH on MH.MaMon=BD.MaMon
	group by MH.MaMon,MH.TenMon
GO
--viết thủ tục 
create proc spXemDiemTB @MaMon char(10), @TongSV int output
as
	select DiemTB from vDiemTrungBinhMon where MaMon = @MaMon
	select @TongSV = count(MaSV) from tbBangDiem where MaMon = @MaMon and Diemthi>(select Diemthi from tbBangDiem where MaMon = @MaMon)
go
--gọi thủ tục 
declare @Tongsv int
exec spXemDiemTB 'SV02', @Tongsv = @TongSV output 
go
--3. Tạo tục spKetquaSV đầu vào là mã sinh viên, đầu ra trả về Điểm trung bình và kết quả của sinh viên đó. 
--Viết đoạn chương trình sử dụng thủ tục trên
CREATE PROC spKetquaSV @MaSV varchar(10), @DiemTB float, @KQ nvarchar(20) OUTPUT
AS
	SELECT @DiemTB = avg(Diemthi) from tbBangDiem where MaSV = @MaSV
	if(@DiemTB <5)
		set @KQ = N'Trượt'
	else
		set @KQ = N'Đồ'
GO
declare @DTB float
declare @KetQua nvarchar(20)
declare @Masv char(10) = 'SV01'
exec spKetquaSV 'SV01', @MaSV = @Masv,@DiemTB = @DTB output, @KQ = @KetQua output
print N'Điểm trung bình là: ' + convert(varchar(5),@DTB) 
print N'Kết quả: ' + @KetQua
go
--4. Viết thủ tục sửa điểm cho sinh viên: đầu vào mã sinh viên, mã môn cần sửa và điểm mới.
--Kiểm tra nếu điểm >=0 và <=10 thì cập nhật điểm cho sinh viên
CREATE PROCEDURE suaDiem @MaSV char(10), @MaMon char(10), @DiemMoi float
AS
	if(@DiemMoi > 0 and @DiemMoi <10)
	begin
		update tbBangDiem set Diemthi = @DiemMoi where MaSV = @MaSV and MaMon = @MaMon
	end
GO
exec suaDiem 'SV01', 'MH01', 4
go
select * from tbBangDiem where MaSV = 'SV01'
go
--5. Viết thủ tục xóa Môn học: đầu vào là mã môn:
-- Xóa các điểm của sinh viên đã thi môn đó trong bảng điểm nếu có
-- Xóa môn học khỏi bảng môn học
create procedure XoaMon @MaMon char(10)
as
	if exists(select MaMon, Diemthi from tbBangDiem where MaMon = @MaMon)
		begin
			delete from tbBangDiem where MaMon = @MaMon
		end
	delete from tbMonhoc where MaMon = @MaMon

go
exec XoaMon 'MH04'
go
select * from tbMonhoc
--	SELECT SV.MaSV,BD.Diemthi ,avg(BD.Diemthi) as [Điểm trung bình] FROM tbBangDiem BD inner join tbSinhvien SV on BD.MaSV = SV.MaSV
	--where BD.Diemthi >= 0 and BD.Diemthi <= 10
	--group by SV.MaSV,BD.Diemthi
