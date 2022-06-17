CREATE DATABASE Demo_DDL
go
USE Demo_DDL

GO
--TẠO BẢNG KHÓA CHÍNH GỒM 1 BỘ 2 CỘT KẾT HỢP
--các ràng buộc (Constraint) sử dụng tên tự động bởi hệ thống
CREATE TABLE Table1(
	Col1 int not null CHECK(Col1>0),
	Col2 int not null CHECK(Col2>0),
	Col3 varchar(10) DEFAULT N'CỘT 3',
	PRIMARY KEY  (Col1, Col2)
)
--thêm một số bản ghi
INSERT INTO Table1 VALUES(1,1, 'Dòng 1')
INSERT INTO Table1 VALUES(1,2, 'Dòng 2')
INSERT INTO Table1 VALUES(2,2, 'Dòng 3')
SELECT * FROM Table1
--thêm bản ghi mới mà trùng cả Col1 + Col2 thì sẽ lỗi vi phạm ràng buộc Khóa chính
INSERT INTO Table1 VALUES(1,1, 'Dòng 4')

--Tạo bảng tự đặt tên cho các ràng buộc để dễ nhớ (sử dụng khi muốn xóa ràng buộc)
--cú pháp:
CREATE TABLE TenBang(
--Trực tiếp trong cột
Tencot1 Kieu_dulieu [NULL|NOT NULL] CONSTRAINT Ten_Constraint1 Loai_Rangbuoc <thông số của ràng buộc>,
Tencot2 Kieu_dulieu [NULL|NOT NULL] CONSTRAINT Ten_Constraint2 Loai_Rangbuoc <thông số của ràng buộc>,
--sau danh sách sách cột
CONSTRAINT Ten_Constraint3 Loai_Rangbuoc <thông số của ràng buộc>
)
--ví dụ
CREATE TABLE Table2(
	Col1 int not null CONSTRAINT check_col1 CHECK(Col1>0),
	Col2 int not null CONSTRAINT check_col2 CHECK(Col2>0),
	Col3 nvarchar(10) NULL CONSTRAINT DF_Col3_Table2 DEFAULT N'CỘT 3',
	CONSTRAINT PK_Table2 PRIMARY KEY  (Col1, Col2),
)

--thêm một số bản ghi
INSERT INTO Table2 VALUES(1,1, N'Dòng 1')
INSERT INTO Table2 VALUES(1,2, N'Dòng 2')
INSERT INTO Table2(Col1,Col2) VALUES(2,2)
SELECT * FROM Table2
--thêm bản ghi mới mà trung cả Col1 + Col2 thì sẽ lỗi vi phạm ràng buộc Khóa chính
INSERT INTO Table2 VALUES(1,1, N'Dòng 4')

--Tạo bảng và sử dụng lệnh ALTER TABLE để thêm cột, thêm ràng buộc, sửa cột, xóa cột 
--Sau khi đã tạo bảng xong
CREATE TABLE Table3(
	Col1 int not null ,
	Col2 int not null ,
	Col3 nvarchar(10) 
)
go
--cú pháp Thêm ràng buộc cho bảng
ALTER TABLE <tên bảng> ADD CONSTRAINT Ten_Constraint Loai_Rangbuoc <thông số của ràng buộc>
--Ví dụ:
--thêm ràng buộc khóa chính cho bảng 3 trên 2 cột Col1,Col2
ALTER Table Table3 ADD CONSTRAINT PK_Table3 PRIMARY KEY(Col1,Col2)
go
--Demo thêm khóa ngoại
CREATE TABLE Table4(Col1 int PRIMARY KEY, Col2 varchar(20))
go
--Thêm ràng buộc khóa ngoại cho cột Col1 tham chiếu đến Col1 của bảng Table4
ALTER TABLE Table3 ADD CONSTRAINT  FK_Col1_Table3 FOREIGN KEY(Col1) REFERENCES Table4(Col1)
--thêm 2 ràng buộc kiểm tra Col1 và Cột 2>0
ALTER Table Table3 ADD CONSTRAINT CK_Col1 CHECK(Col1 > 0) 
ALTER Table Table3 ADD CONSTRAINT CK_Col2 CHECK(Col2 > 0) 
--thêm ràng buộc thiết lập mặc định cho cột Col3 là 'CỘT 3'
--cú pháp: ALTER Table <tên_bảng> ADD CONSTRAINT <tên_constraint> DEFAULT Giá_trị FOR Tên_cột
ALTER Table Table3 ADD CONSTRAINT DF_Col3 DEFAULT N'CỘT 3' FOR Col3

--Bổ sung thêm cột mới tên cột Col4 kiểu varchar(30) NOT NULL vào bảng Table3
--cú pháp: ALTER TABBLE<tên_bảng> ADD <tên_cột> <kiểu_dữ_liệu> [NULL|NOT NULL] [ràng buộc của cột]
ALTER Table Table3 ADD  Col4 varchar(30) NOT NULL 
--Sửa kiểu dữ liệu Col4 thành nvarchar(30) NOT NULL
ALTER Table Table3 ALTER Column Col4 nvarchar(30) NOT NULL
--Thay tên cột Col4 thành tên mới Cot4
--sử dụng thủ tục sp_rename của hệ thống
--Cú pháp:EXECUTE sp_rename 'TenBang.Tencot_cu', 'Tencot_moi', 'COLUMLN'
EXECUTE sp_rename 'Table3.Col4', 'Cot4', 'COLUMN' 
--'COLUMN' xách định loại đối tượng cần thay tên là tên cột
SELECT * FROM Table3
--Thay tên bảng Table3 thành Bang3
--Cú pháp:EXECUTE sp_rename 'TenBang_cu', 'Tenbang_moi'
EXEC sp_rename 'Table3', 'Bang3'
SELECT * FROM Bang3
--Xóa cột Cot4 khỏi bảng Bang3
--cú pháp: ALTER TABLE DROP COLUMN <tencot>
ALTER TABLE Bang3 DROP COLUMN Cot4
--Xóa ràng buộc DF_Col3 khỏi bảng Bang3
--Cú pháp: ALTER TABLE <ten_bang> DROP CONSTRAINT <ten_rang_buoc>
ALTER TABLE Bang3 DROP CONSTRAINT DF_Col3