create database BT_DDL2
go
use BT_DDL2
go
create table tbLopHoc(
	MaLop varchar(10) primary key,
	TenLop nvarchar(30) not null,
	SiSo int
)
go
create table tbSinhVien(
	MaSV varchar(10) primary key,
	HoTen nvarchar(30) not null,
	SDT char(10) null
)
go
select * from tbLopHoc
select * from tbSinhVien
--3a.B? sung c?t Email chu?i 30 ký t? ???c NULL vào b?ng tbSinhvien
Alter table tbSinhVien add  Email varchar(30) null
--3b.B? sung c?t Mã l?p vào b?ng tbSinh viên
Alter table tbSinhVien add  MaLop varchar(10)
--4a.Ràng bu?c ki?m tra S? s? ph?i > 10
Alter table tbLopHoc add constraint CK_SiSo check(SiSo > 10)
--4b.Ràng bu?c ki?m tra h? tên ph?i > 5 ký t?
Alter table tbSinhVien add constraint CK_HoTen check(HoTen > 5)
--4c.Ràng bu?c ki?m tra c?t S? ?i?n tho?i không ???c trùng
Alter table tbSinhVien add constraint UQ_SDT unique 
--4d.Ràng bu?c ki?m tra c?t Email không ???c trùng
Alter table tbSinhVien add constraint UQ_Email unique 
--4e.Ràng bu?c khóa ngo?i cho c?t Mã l?p c?a b?ng tbSinhvien
Alter table tbSinhVien add constraint FK_MaLop_tbSinhVien foreign key(MaLop) references tbLopHoc(MaLop)
--5.??i tên c?t s? ?i?n tho?i thành PhoneNumber
Exec sp_rename 'SDT', 'PhoneNumber'
--6.Xóa c?t Email kh?i b?ng tbSinhvien
Alter table tbSinhVien drop column Email
--7.??i tên b?ng tbSinhvien thành tbStudent
Exec sp_rename 'tbSinhVien', 'tbStudent'