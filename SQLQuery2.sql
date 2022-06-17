create database QuanlySinhvien2
go
use QuanlySinhvien2
go
create table tbLophoc1(
	Malop varchar(10) primary key,
	Tenlop Nvarchar(30) unique not null,
	SiSoToiDa int check(SiSoToiDa >0) DEFAULT 25
)
go
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T102','A1',2)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T103','A2',5)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T104','A3',4)
insert into tbLophoc1(Malop,Tenlop,SiSoToiDa) values ('T105','A4',3)
select * from tbLophoc1
--delete from tbLophoc1
create table tbSinhvien1(
	MaSV varchar(10) primary key,
	Hoten Nvarchar(30) not null ,
	Ngaysinh date null,
	Gioitinh bit default 0,
	Malop varchar(10) FOREIGN KEY REFERENCES tbLophoc1(Malop)
)
go
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV01',N'Nguyễn Ngọc Anh', '2003/2/21','1','T102')
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV02',N'Phạm Văn Hoàng', '2003/8/4','0','T104')
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV03',N'Đỗ Thu Thảo', '2003/6/3','1','T103')
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV04',N'Lê Thị Xuân', '2003/6/29','1','T102')
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV05',N'Vũ Ngọc Anh', '2003/8/15','0','T104')
insert into tbSinhvien1(MaSV,Hoten,Ngaysinh,Gioitinh,Malop) values ('SV06',N'Trần Dương', '2003/4/19','0','T104')
select * from tbSinhvien1
--delete from tbSinhvien1
select tbLophoc1.Malop,tbLophoc1.Tenlop, Count(*) as SiSoToiDa, tbSinhvien1.Hoten from tbLophoc1 
inner join tbSinhvien1 on tbLophoc1.Malop=tbSinhvien1.Malop group by tbLophoc1,tbSinhvien1
--1.	Hiển thị thông tin sinh viên gồm đầy đủ các cột của bảng tbSinhvien và cột TenLop từ bảng tbLophoc
select * from tbLophoc1, tbSinhvien1 where tbLophoc1.Malop = tbSinhvien1.Malop
--Hiển thị thông tin sinh viên và lớp học, sắp xếp theo Họ tên tăng dần
select * from tbLophoc1 inner join tbSinhvien1 on tbLophoc1.Malop = tbSinhvien1.Malop order by Hoten asc
--Hiển thị Mã lớp, tên lớp và đếm số sinh viên của từng lớp
select tbLophoc1.Malop,tbLophoc1.Tenlop,tbSinhvien1.Hoten, count(*) as SiSoToiDa from tbLophoc1 inner join  tbSinhvien1 
on tbLophoc1.Malop = tbSinhvien1.Malop group by tbLophoc1.Malop ,tbSinhvien1.Hoten, tbLophoc1.Tenlop
--Hiển thị Mã lớp, tên lớp và đếm số sinh viên giới tính Nam (0) của từng lớp
select tbLophoc1.Malop,tbLophoc1.Tenlop,tbSinhvien1.Hoten, count(*) as SiSoToiDa from tbLophoc1 inner join  tbSinhvien1 
on tbLophoc1.Malop = tbSinhvien1.Malop where tbSinhvien1.Gioitinh = 0 group by tbLophoc1.Malop,tbSinhvien1.Hoten,tbLophoc1.Tenlop
--Hiển thị Mã lớp, tên lớp, số sinh viên, chỉ hiện thị những lớp có số sinh viên <5
select tbLophoc1.Malop,tbLophoc1.Tenlop,tbSinhvien1.Hoten, count(*) as SiSoToiDa from tbLophoc1 inner join  tbSinhvien1 
on tbLophoc1.Malop = tbSinhvien1.Malop group by tbLophoc1.Malop,tbSinhvien1.Hoten,tbLophoc1.Tenlop having count(*)<5
--Hiển thị các sinh viên sinh năm 2003 (YEAR(Ngaysinh)=2003)
select * from tbSinhvien1 where year(Ngaysinh) = 2003
--Hiển thị các sinh viên sinh vào tháng 12 (MONT(Ngaysinh)=12)
select * from tbSinhvien1 where month(Ngaysinh)=12
insert into tbSinhvien1 values ('SV07',N'Bùi HOàng','2004/12/6',0,'T103')