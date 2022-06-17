create database Baitap_DDL
go 
use Baitap_DDL
go
create table tbLophoc(
	Malop char(10) primary key constraint PK_Lophoc not null,
	Tenlop nvarchar(30) not null,
	SiSo int 
)
go

create table tbSinhvien(
	MaSV char(10) constraint PK_Sinhvien primary key not null,
	Hoten nvarchar(30) not null,
	SDT char(15) null,
)
go

--3.Thêm cột
--a. Bổ sung cột Email chuỗi 30 ký tự được NULL vào bảng tbSinhvien
ALTER Table tbSinhvien ADD  Email varchar(30)  NULL 

--b. Bổ sung cột Mã lớp vào bảng tbSinh viên
alter table tbSinhvien add Malop char(10) 
go
--4.Thêm ràng buộc:
--a. Ràng buộc kiểm tra Sĩ số phải > 10

ALTER Table tbLophoc ADD CONSTRAINT CK_SiSo check(SiSo > 10)
go

insert into tbLophoc values ('L01', N'T2109M', 5)
go
--b. Ràng buộc kiểm tra họ tên phải > 5 ký tự
alter table tbSinhvien add constraint CK_HoTen check(len(HoTen) > 5)
go

insert into tbSinhvien values ('SV01', N'Trần Thanh Thảo','0839283981','sf23@gmail.com','L01')
go
--c. Ràng buộc kiểm tra cột Số điện thoại không được trùng
alter table tbSinhvien add constraint UQ_SDT unique
go
--d. Ràng buộc kiểm tra cột Email không được trùng
Alter table tbSinhVien add constraint UQ_Email unique
--e. Ràng buộc khóa ngoại cho cột Mã lớp của bảng tbSinhvien
Alter table tbSinhVien add constraint FK_MaLop_tbSinhVien foreign key(MaLop) references tbLopHoc(MaLop)

--5.Đổi tên cột : a. Đổi tên cột số điện thoại thành PhoneNumber
EXECUTE sp_rename 'tbSinhvien.SDT', 'PhoneNumber', 'COLUMN' 

--6.Xóa cột: Xóa cột Email khỏi bảng tbSinhvien
ALTER TABLE tbSinhvien Drop COLUMN Email


--7. Đổi tên bảng tbSinhvien thành tbStudent
EXEC sp_rename 'tbSinhvien', 'tbStudent'
