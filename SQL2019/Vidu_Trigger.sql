CREATE DATABASE Vidu_Trigger
go
use Vidu_Trigger
go
--BẢNG TBLOPHOC
CREATE TABLE tbLophoc(
    MaLop char(10) PRIMARY KEY,
    TenLop nvarchar(10) NOT NULL,
    SiSoToida int DEFAULT 25 CHECK(SiSoToida > 0)
)
go
INSERT INTO tbLophoc VALUES ('L01', 'T2108M', 2)
INSERT INTO tbLophoc VALUES ('L02', 'T2109M', 5)
INSERT INTO tbLophoc VALUES ('L03', 'T1307M', 6)
INSERT INTO tbLophoc VALUES ('L04', 'T1408M', 3)
INSERT INTO tbLophoc VALUES ('L05', 'T1508M', 3)
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
GO
INSERT into tbSinhvien VALUES ('SV01', N'Nguyễn', N'Việt Anh', '2003-09-14',0,NULL,'L01')
go
SELECT * FROM tbSinhvien
go


--Bài 1. Viết Trigger cho sự kiện thêm lớp học học mới, 
--kiểm tra nếu sĩ số tối đa >30 thì hủy bản ghi (lớp học) vừa thêm
INSERT INTO tbLophoc VALUES ('L06', 'T1509M', 31)
go
select * from tbLophoc
go
--chưa tạo trigger thì vẫn thêm được lớp học có sĩ số tối đa >30
--Tạo trigger để kiểm soát sĩ số tối đa phải <=30 khi thêm lớp học mới
CREATE TRIGGER tg_Kiemtra_sisotoida
ON tbLophoc
AFTER INSERT --Định nghĩa trigger thực thi sau khi INSERT thành công
AS
	--Khai báo biến để lưu sĩ số của lớp học vừa thêm
	DECLARE @siso int
	--lấy sĩ số của lớp vừa được thêm
	SELECT @siso=SiSoToida FROM inserted
	--kiểm tra nếu @siso >30 thì hủy bản ghi vừa được thêm
	IF @siso > 30 
	BEGIN
		PRINT N'sĩ số tối đã phải <=30'
		ROLLBACK TRANSACTION --UNDO LỆNH INSERT VỪA THỰC THI THÀNH CÔNG
	END
	ELSE
	BEGIN
		PRINT N'Thêm lớp học thành công'
	END
GO
--demo kiểm tra hoạt động của Trigger tg_Kiemtra_sisotoida
--KHÔNG SỬ DỤNG:EXECUTE tg_Kiemtra_sisotoida
INSERT INTO tbLophoc VALUES ('L07', 'T1509L', 31)
--sĩ số tối đã phải <=30
--Msg 3609, Level 16, State 1, Line 61
--The transaction ended in the trigger. The batch has been aborted.
SELECT * FROM tbLophoc --chưa có Lớp L07 vì trigger kiểm tra và hủy lớp L07 do sĩ số > 30
--thử thêm lớp L07 với sĩ số tối đa <30
INSERT INTO tbLophoc VALUES ('L07', 'T1509L', 29)
--Thêm lớp học thành công
--(1 row affected)
SELECT * FROM tbLophoc --có lớp L07 với sĩ số tối đa 29
GO
--Bài 02: Viết trigger thay thế cho sự kiện xóa lớp học, 
--kiểm tra nếu lớp đó chưa có sinh viên thì xóa lớp học
--nếu lớp đã có sinh viên thì: 1. xóa các sinh viên có mã lớp đó, 2. xóa lớp
--Do ta có khóa ngoại của bảng sinh viên trên mã lớp, nên khi xóa lớp học mà đang có sinh thì bị lỗi
DELETE FROM tbLophoc WHERE MaLop='L01'
GO
--Msg 547, Level 16, State 0, Line 79
--The DELETE statement conflicted with the REFERENCE constraint "FK__tbSinhvie__MaLop__668030F6". The conflict occurred in database "master", table "dbo.tbSinhvien", column 'MaLop'.
--xây dựng trigger thay thế cho sự kiện DELETE trên bảng tbLophoc, thực hiện yêu cầu bài 02
--tức là khi thực thi lệnh DELETE FROM tbLophoc.. thì trigger chạy thay thế cho delete mà không cần kiểm tra ràng buộc khóa ngoại
CREATE TRIGGER tg_XoaLopHoc
ON tbLophoc
INSTEAD OF DELETE --trigger thự thi thay cho lệnh DELETE trên bảng tbLhophoc
AS
--kiểm tra nếu lớp đó chưa có sinh viên thì xóa lớp học
DECLARE @MaLop char(10)
SELECT @MaLop = MaLop FROM deleted --lấy MaLop từ bản ghi định xóa (của lệnh DELETE FROM tbLophoc ....)
IF EXISTS (SELECT * FROM tbSinhvien WHERE MaLop=@MaLop) --nếu lớp đã có sinh viên thì:	
BEGIN
	--1. xóa các sinh viên có mã lớp đó,
	DELETE FROM tbSinhvien WHERE MaLop=@MaLop
	--2. xóa lớp học
	 DELETE FROM tbLophoc WHERE MaLop=@MaLop
	 print N'Xóa lớp học và các sinh viên liên quan thành công'
END
ELSE --LỚP CHƯA CÓ SINH VIÊN THÌ thực thi lệnh xóa lớp học
begin
	 DELETE FROM tbLophoc WHERE MaLop=@MaLop
	 print N'Xóa lớp học thành công'
end
GO
--THỬ XÓA LỚP HỌC ĐÃ CÓ SINH VIÊN
DELETE FROM tbLophoc WHERE MaLop='L01'
--(1 row affected)
--(1 row affected)
--Xóa lớp học và các sinh viên liên quan thành công
select * from tbSinhvien
select * from tbLophoc
--THỬ XÓA LỚP HỌC CHƯA CÓ SINH VIÊN
DELETE FROM tbLophoc WHERE MaLop='L02'
--(1 row affected)
--Xóa lớp học thành công
