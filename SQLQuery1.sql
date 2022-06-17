create database QuanlySinhvien1
create database QuanlySinhvien1
go
use QuanlySinhvien1
go
create table tbLophoc1(
	Malop varchar(10) primary key,
	Tenlop varchar(10) unique not null,
	SiSoToiDa int check(SiSoToiDa>0)
)
go
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T102','A1',2)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T103','A2',5)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T104','A3',4)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T105','A4',3)
select * from tbLophoc1
--delete from tbLophoc1
create table tbSinhvien(
	MaSV varchar(10) primary key,
	Hoten Nvarchar(30) not null ,
	Ngaysinh date null,
	Gioitinh bit default 0,
	Malop varchar(10) FOREIGN KEY REFERENCES tbLophoc1(Malop)
)
go
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV01',N'Nguyễn Ngọc Anh', '2003/2/21','1','T102')
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV02',N'Phạm Văn Hoàng', '2003/8/4','0','T104')
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV03',N'Đỗ Thu Thảo', '2003/6/3','1','T103')
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV04',N'Lê Thị Xuân', '2003/6/29','1','T102')
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV05',N'Vũ Ngọc Anh', '2003/8/15','0','T104')
insert into tbSinhvien(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV06',N'Trần Dương', '2003/4/19','0','T104')
select * from tbSinhvien
--delete from tbSinhvien
--select tbLophoc1.Malop ,tbLophoc1.Tenlop, Count(*) as SiSoToiDa from tbLophoc1 inner join tbSinhvien on tbLophoc1.Malop=tbSinhvien.Malop
select tbLophoc1.Malop ,tbSinhvien.Hoten,tbLophoc1.Tenlop from tbLophoc1 inner join tbSinhvien on tbLophoc1.Malop = tbSinhvien.Malop 
--Hiển thị thông tin sinh viên gồm đầy đủ các cột của bảng tbSinhvien và cột TenLop từ bảng tbLophoc
select * from tbSinhvien, tbLophoc1 where tbLophoc1.Malop=tbSinhvien.Malop
--Hiển thị thông tin sinh viên và lớp học, sắp xếp theo Họ tên tăng dần
select tbLophoc1.Tenlop, tbSinhvien.Hoten from tbLophoc1 inner join tbSinhvien on tbLophoc1.Malop=tbSinhvien.Malop order by Hoten asc
--Hiển thị Mã lớp, tên lớp và đếm số sinh viên của từng lớp
select tbLophoc1.Tenlop, tbSinhvien.Hoten, count(*) as SiSoToiDa from tbLophoc1 inner join tbSinhvien on tbLophoc1.Malop=tbSinhvien.Malop 
group by tbLophoc1.Malop,tbLophoc1.Tenlop,tbSinhvien.Hoten
--Hiển thị Mã lớp, tên lớp và đếm số sinh viên giới tính Nam (0) của từng lớp

