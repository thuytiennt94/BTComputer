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
--3a.B? sung c?t Email chu?i 30 k� t? ???c NULL v�o b?ng tbSinhvien
Alter table tbSinhVien add  Email varchar(30) null
--3b.B? sung c?t M� l?p v�o b?ng tbSinh vi�n
Alter table tbSinhVien add  MaLop varchar(10)
--4a.R�ng bu?c ki?m tra S? s? ph?i > 10
Alter table tbLopHoc add constraint CK_SiSo check(SiSo > 10)
--4b.R�ng bu?c ki?m tra h? t�n ph?i > 5 k� t?
Alter table tbSinhVien add constraint CK_HoTen check(HoTen > 5)
--4c.R�ng bu?c ki?m tra c?t S? ?i?n tho?i kh�ng ???c tr�ng
Alter table tbSinhVien add constraint UQ_SDT unique 
--4d.R�ng bu?c ki?m tra c?t Email kh�ng ???c tr�ng
Alter table tbSinhVien add constraint UQ_Email unique 
--4e.R�ng bu?c kh�a ngo?i cho c?t M� l?p c?a b?ng tbSinhvien
Alter table tbSinhVien add constraint FK_MaLop_tbSinhVien foreign key(MaLop) references tbLopHoc(MaLop)
--5.??i t�n c?t s? ?i?n tho?i th�nh PhoneNumber
Exec sp_rename 'SDT', 'PhoneNumber'
--6.X�a c?t Email kh?i b?ng tbSinhvien
Alter table tbSinhVien drop column Email
--7.??i t�n b?ng tbSinhvien th�nh tbStudent
Exec sp_rename 'tbSinhVien', 'tbStudent'