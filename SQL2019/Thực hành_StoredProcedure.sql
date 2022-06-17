CREATE DATABASE Demo_StoredPrcedure
go
use Demo_StoredPrcedure
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
--Ví dụ 1: Viết thủ tục trả về danh sách các sinh viên nam (giới tính =0)
CREATE PROCEDURE spSinhvienNam 
AS
	SELECT * FROM tbSinhvien WHERE gioitinh=0
GO
--Thực thi thủ tục
EXECUTE spSinhvienNam
go
--hoặc viết tắt EXEC
EXEC spSinhvienNam
go
--Ví dụ 2: thủ tục có tham số đầu vào (input parameter)
--Viết thủ tục hiển thị các sinh viên có tên chứa từ khóa là tham số của thủ tục
CREATE PROC spFindStudentByName @tukhoa nvarchar(20) -- khai báo thủ tục có tham số là @tukhoa kiểu nvarchar 20
AS
	SELECT * FROM tbSinhvien WHERE Ten LIKE '%' + @tukhoa + '%'
GO
--CHẠY THỬ: hiển thị các sinh viên mà tên có chwuas từ Văn
EXEC spFindStudentByName N'Văn'
go
--Ví dụ 3: thủ tục có 02 tham số đầu vào (02 input parameter)
--Viết thủ tục đầu vào là giới tính (dạng số nguyên) và năm sinh (số nguyên) 
--để hiển thị các sinh viên có giới tính và năm sinh tương ứng
CREATE PROCEDURE spFindStudentByGenderAndYear @gioitinh int, @namsinh int
AS
	SELECT * FROM tbSinhvien WHERE Gioitinh=@gioitinh AND YEAR(Ngaysinh)=@namsinh
GO
--CHẠY THỬ: hiển thị sinh viên nam sinh năm 2004
--cách 1: không chỉ rõ tên tham số thì các giá trị gán tuần tự cho các tham số
EXEC spFindStudentByGenderAndYear 0,2002  -- giá trị 0 gán cho @gioitinh, 2002 gán cho @namsinh
GO
--cách 2 có thể chỉ rõ tên tham số nhận giá trị (không cần theo thứ tự)
EXEC spFindStudentByGenderAndYear @gioitinh=0, @namsinh=2002
go
EXEC spFindStudentByGenderAndYear @namsinh=2002,@gioitinh=0
go

select * from tbLophoc
select * from tbSinhvien
GO
--Ví dụ 4: sử dụng lệnh điều kiển rẽ nhánh trong thủ tục
--Viết thủ tục spXoaLopHoc, đầu vào là mã lớp cần xóa
--thủ tục kiểm tra nếu đã có sinh viên của lớp đó thì báo lỗi và không cho xóa
--nếu lớp học đó chưa có sinh viên thì thực hiện xóa lớp học có mã lớp đó từ bảng tbLophoc
CREATE PROC spXoaLopHoc @MaLop varchar(10)
AS
	IF EXISTS(SELECT * FROM tbSinhvien WHERE MaLop = @MaLop) --Nếu tồn tại sinh viên có mã lớp = @malop
		BEGIN
			PRINT N'Lớp ' + @MaLop + N' đã có sinh viên => không được xóa'
		END
	ELSE
		BEGIN
			DELETE FROM tbLophoc WHERE MaLop=@MaLop
		END
GO
--thử xóa lớp học có mã lớp L01 (đã có sinh viên) => thông báo không được xóa
EXEC spXoaLopHoc 'L01'
go
--thử xóa lớp học có mã lớp L05 (chưa có sinh viên)
EXEC spXoaLopHoc 'L05'
go
SELECT * FROM tbLophoc
go
--Ví dụ 5: Sử tham số kiểu OUTPUT: trả về 1 hoặc nhiều giá trị qua tham số OUTPUT
--Viết thủ tục đầu vào là Mã sinh viên, đầu ra trả về Họ tên (ho + ten)
--Viết chương trình minh họa tìm sinh viên và hiển thị họ tên
CREATE PROC spGetStudentName @MaSV varchar(10), @Hoten nvarchar(30) OUTPUT
AS
	--gán dữ liệu cho biến: SET @bien = giatri hoặc SELECT @Bien = Tencot FROM Tenbang WHERE...
	--lấy cột Ho + ' ' + cột Ten từ bảng tbSinhvien (mà có MaSV=@MaSV) gán cho biến @Hoten ra bên ngoài
	SELECT @Hoten = Ho + ' ' + Ten FROM tbSinhvien WHERE MaSV = @MaSV
GO
--Chạy thử (chạy SQL theo nhóm lệnh liên quan)
DECLARE @Hovaten nvarchar(30) --Khai báo biến @Hovaten kiểu nvarchar(30) để lấy kết quả từ thủ tục
	--gọi thủ tục với đầu vào là @MaSV và đầu ra là @Hoten đầu ra gán cho biến @Hovaten
EXEC spGetStudentName @MaSV='SV01', @Hoten = @Hovaten OUTPUT 
PRINT N'Sinh viên SV01 có Họ và tên: ' + @Hovaten
go
SELECT * FROM tbBangDiem
GO
--Ví dụ 6: Viết thủ tục spKetqua đầu vào là mã sinh viên, trả về điểm trung bình của sinh viên
CREATE PROC spKetqua @MaSV varchar(10), @DiemTB float OUTPUT
AS
	SELECT @DiemTB = AVG(Diemthi) FROM tbBangDiem WHERE MaSV=@MaSV
GO
--Viết đoạn chương trình tính và in điểm trung bình của sinh viên có masv=sv01
DECLARE @DTB float
DECLARE @Masinhvien varchar(10) = 'SV01'
EXEC spKetqua @MaSV = @Masinhvien, @DiemTB = @DTB OUTPUT
PRINT N'Điểm trung bình là: ' + CONVERT(varchar(5) ,@DTB)
go
--Ví dụ 7: Sửa thủ tục spKetqua: trả về 2 giá trị là điểm trung bình và xếp loại (<5: trượt, >=5 đỗ)
ALTER PROC spKetqua @MaSV varchar(10), @DiemTB float OUTPUT, @Xeploai nvarchar(10) OUTPUT
AS
	SELECT @DiemTB = AVG(Diemthi) FROM tbBangDiem WHERE MaSV=@MaSV
	IF(@DiemTB<5)
		SET @Xeploai = N'Trượt'
	ELSE
		SET @Xeploai = N'Đỗ'
GO
--Viết đoạn chương trình (script) chạy thử
DECLARE @DTB float, @XL nvarchar(10)
DECLARE @Masinhvien varchar(10) = 'SV01'
EXEC spKetqua @MaSV = @Masinhvien, @DiemTB = @DTB OUTPUT, @Xeploai=@XL OUTPUT
PRINT N'Điểm trung bình là: ' + CONVERT(varchar(5) ,@DTB)
PRINT N'Xếp loại: ' + @XL
go
--Xóa thủ tục
DROP PROC spKetqua