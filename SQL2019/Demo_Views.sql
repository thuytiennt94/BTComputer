CREATE DATABASE demo_views
go
use demo_views
go
--BẢNG TBLOPHOC
CREATE TABLE tbLophoc(
    MaLop char(10) PRIMARY KEY,
    TenLop nvarchar(10) NOT NULL,
    SiSoToida int DEFAULT 25 CHECK(SiSoToida > 0)
)
go 
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
--Nhập dữ liệu lớp học
INSERT INTO tbLophoc VALUES ('L01', 'T2108M', 4)
INSERT INTO tbLophoc VALUES ('L02', 'T2109M', 5)
INSERT INTO tbLophoc VALUES ('L03', 'T1307M', 6)
INSERT INTO tbLophoc VALUES ('L04', 'T1408M', 3)
INSERT INTO tbLophoc VALUES ('L05', 'T1508M', 3)
GO
select * from tbLophoc
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
go
select * from tbSinhvien
go
--Giới thiệu View
--View là 1 đối tượng trong CSDL (có tên riêng như Table), được tạo bởi 1 câu lệnh SELECT.
--nó dạng bảng ảo (không chứa dữ liệu thật), 
--dữ liệu của View là kết quả của lệnh SELECT từ các bảng hay View khác
--Sau khi tạo ra View, ta gọi view bằng lênh SELECT như với TABLE
-- Ví dụ: Tạo view vSinhvien_Lophoc Hiển thị toàn bộ dữ liệu gồm các cột từ bảng tbSinhvien 
--và cột Tenlop, SisoToida từ bảng tbLophoc
--Tạo View vSinhvien_Lophoc
CREATE VIEW vSinhvien_Lophoc
AS
SELECT SV.*, LH.TenLop,LH.SiSoToida 
FROM tbSinhvien SV INNER JOIN tbLophoc LH ON SV.MaLop=LH.MaLop
go
--Goi View (như với Table) Hiển thị tất cả các cột
SELECT * FROM vSinhvien_Lophoc
--Goi View Hiển thị các cột: MaSV, Ho, Ten, MaLop, TenLop
SELECT MaSV, Ho, Ten, MaLop, TenLop FROM vSinhvien_Lophoc
--thay đổi nội dung View vSinhvien_Lophoc: để chứa MaSV, Malop, TenLop
go
ALTER VIEW vSinhvien_Lophoc
as
SELECT SV.MaSV, SV.MaLop, LH.TenLop 
FROM tbSinhvien SV INNER JOIN tbLophoc LH ON SV.MaLop=LH.MaLop
go
--gọi View để hiển thị dữ liệu
SELECT * FROM vSinhvien_Lophoc
GO
--Xóa view vSinhvien_Lophoc
DROP VIEW vSinhvien_Lophoc
--DỮ LIỆU SINH VIÊN VÀ LỚP HỌC VẪN CHỨA TRONG TABLE tbSinhvien và tbLophoc
GO
--Khi sử dụng mệnh đề ORDER BY trong định nghĩa view thì phải sử dụng SELECT TOP n
--Tạo view Hiển thị lớp học sắp xếp theo Sisotoida giảm dần
CREATE VIEW v_Lophoc_Siso_Giamdan
as
SELECT * FROM tbLophoc order by SiSoToida DESC
go
--lệnh trên lỗi do sử dụng ORDER BY mà không sử dụng SELECT TOP
--hiển thị 3 lớp học có sĩ số tối đa cao nhất
CREATE VIEW v_Lophoc_Siso_Giamdan
as
SELECT TOP 3 * FROM tbLophoc order by SiSoToida DESC
go
SELECT * FROM v_Lophoc_Siso_Giamdan
--Lệnh SELECT <DSCOT> INTO <Bang_moi> FROM <tenbang> [WHERE...]
--để tạo ra Bang_moi trong CSDL với các cột và các dòng từ lệnh SELECT trên <tenbang>
--Ví dụ: Tạo bảng tbSinhvien_L01 chứa các sinh viên của lớp L01
SELECT * INTO tbSinhvien_L01 FROM tbSinhvien WHERE MaLop='L01'
--lệnh trên tạo ra bảng tbSinhvien_L01 trong CSDL chứa dữ liệu từ lệnh SELECT
--dữ liệu trên bảng mới tồn tại độc lập với dữ liệu trên bảng đã có
SELECT * FROM tbSinhvien_L01
--khi xóa dữ liệu từ tbSinhvien_L01 thì dữ liệu bên tbSinhvien vẫn còn
truncate table tbSinhvien_L01
go
select * from tbSinhvien
--Chú ý: LỆNH SELECT ...INTO không được sử dụng để định nghĩa Views
CREATE VIEW v_Sinhvien_L01
SELECT * INTO tbSinhvien_L01 FROM tbSinhvien WHERE MaLop='L01'
go
--Tạo view hiển thị các sinh nữ (giới tính =1)
CREATE VIEW vSinhvienNu
AS
SELECT * FROM tbSinhvien WHERE Gioitinh=1
GO
select * from vSinhvienNu
--thêm 1 sinh viên thông qua View
insert into vSinhvienNu VALUES('SV10',N'Nguyễn',N'Thủy Tiên','2003-03-30',1,NULL,'L02')
--dữ liệu này sẽ lưu vào bảng tbSinhvien
SELECT * FROM tbSinhvien
--thêm 1 sinh viên nam thông qua View
insert into vSinhvienNu VALUES('SV11',N'Đỗ',N'Danh Bản','2003-04-30',0,NULL,'L03')
--vẫn thêm được do bản chất dữ liệu được insert vào tbSinhvien
select * from vSinhvienNu --không hiển thị sinh viên nam (gioitinh=0)
SELECT * FROM tbSinhvien -- sinh viên mới vẫn có trong bảng tbSinhvien
GO
--Sửa View vSinhvienNu để kiểm tra không được thêm/sửa sinh viên giới tính =0
-- sử dụng WITH CHECK OPTION để kiểm soát dữ liệu thêm/sửa phải thỏa mãn đk của WHERE 
ALTER VIEW vSinhvienNu 
AS
SELECT * FROM tbSinhvien WHERE Gioitinh=1
WITH CHECK OPTION 
go
--thêm 1 sinh viên nam thông qua View sau khi đã sử định nghĩa view bổ sung  WITH CHECK OPTION 
insert into vSinhvienNu VALUES('SV12',N'Nguyễn',N'Việt Anh','2003-05-30',0,NULL,'L03')
--lệnh trên lỗi do giới tính của sinh viên =0 vi phạm mệnh đề WHERE 
SELECT * FROM vSinhvienNu
--UPDATE DỮ LIỆU QUA VIEW
UPDATE vSinhvienNu SET Malop='L02' WHERE MaSV='SV01'
--lệnh trên không update được vì trong vSinhvienNu không có MaSV='SV01'
UPDATE vSinhvienNu SET Malop='L02' WHERE MaSV='SV02'
--lệnh trên thỏa mãn do sinh viên MaSV='SV02' có gioitinh=1
select * from tbSinhvien
--Xóa dữ liệu qua view
DELETE FROM vSinhvienNu WHERE MaSV='SV02'
go
select * from tbSinhvien
--để xem lại nội dung lệnh SELECT định nghĩa VIEW, sử dụng thủ tục hệ thống: sp_hepttext <tenview>
EXEC sp_helptext vSinhvienNu
go
--Khi thêm cột mới vào bảng liên quan View 
--thì phải sử dụng sp_refreshview <tenview> để cập nhật cột mới vào View
ALTER TABLE tbSinhvien ADD Email varchar(30)
go
select * from tbSinhvien
select * from vSinhvienNu
--view vSinhnvienNu chưa được cập nhật cột mới
-- sử dụng lênh sp_refreshview <tenview> để cập nhật cột mới vào View
EXEC sp_refreshview vSinhvienNu
go
select * from vSinhvienNu
--Lợi ích và ý nghĩa của View:
--Kế Dương17:11
--View cho phép chúng ta có thể tổng hợp kết quả từ nhiều bảng, tùy theo tiêu chí mong muốn. 
--Do đó, từ 1 truy vấn dài dòng, loằng ngoằng thì chúng ta có thể tách những khúc có ý nghĩa, 
--có thể dùng lại, rồi tạo mỗi cái thành 1 view. 
--Bản chất của view chỉ là 1 đoạn mã sql được lưu vào server cơ sở dữ liệu.
-- => Ý nghĩa 1:
--Sử dụng View quản lý lệnh SELECT phức tạp thì lệnh lệnh SELECT được dịch và tìm lỗi ngay khi tạo View
--khi gọi lệnh SELECT phức tạp đó qua View (đã tạo) máy tính sẽ thực hiện nhanh hơn là trực tiếp

--Pham Tuan Ngoc (APTECH HN)17:12
--Hạn chế truy cập tới các Table cụ thể. Chỉ cho phép được xem qua View.
-- => ý nghĩa 2:
-- Có thể phân quyền cho các khoản chỉ được truy cập vào các bảng thông qua View
-- Để giới hạn các dòng và cột người dùng được xem và cập nhật

--Bản Đỗ 17:14
--Số lượng bảng phải sử dụng trong 1 truy vấn sẽ giảm xuống, truy vấn sẽ dễ hiểu hơn
-- => ý nghĩa 3:
-- Phát triển các ứng dụng làm việc với CSDL đơn giản dễ hiểu hơn