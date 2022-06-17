CREATE DATABASE Bai7
GO 
USE Bai7
GO 
--B?NG TBLOPHOC
CREATE TABLE tbLophoc(
    MaLop char(10) PRIMARY KEY,
    TenLop nvarchar(10) NOT NULL,
    SiSoToida int DEFAULT 25 CHECK(SiSoToida > 0)
)
go 
--B?NG TBSINHVIEN
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
--B?NG TBMONHOC
CREATE TABLE tbMonhoc(
    MaMon char(10) PRIMARY KEY,
    TenMon nvarchar(30) NOT NULL UNIQUE,
    Mota ntext
)
go
--B?NG TBBANGDIEM
CREATE TABLE tbBangDiem(
    MaSV char(10) FOREIGN KEY REFERENCES tbSinhvien(MaSV),
    MaMon char(10) FOREIGN KEY REFERENCES tbMonhoc(MaMon),
    Diemthi float DEFAULT 0,
    Ngaythi datetime DEFAULT GETDATE(),
    CONSTRAINT PK_Bangdiem PRIMARY KEY(MaSV, MaMon) 
)
go
--C�ch 2
--s? d?ng l?nh t?o r�ng bu?c: CONSTRAINT Ten_Constraint Loai_Constraint <C�c tham s?>
CREATE TABLE tbBangDiem2(
    MaSV char(10) ,
    MaMon char(10) ,
    Diemthi float DEFAULT 0,
    Ngaythi datetime DEFAULT GETDATE(),
    CONSTRAINT PK_BangDiem2 PRIMARY KEY(MaSV,MaMon),
	CONSTRAINT FK_BD2_MaSV FOREIGN KEY (MaSV) REFERENCES tbSinhvien(MaSV),
	CONSTRAINT FK_BD2_MaMon FOREIGN KEY (MaSV) REFERENCES tbMonhoc(MaMon)
)
--Nh?p d? li?u l?p h?c
INSERT INTO tbLophoc VALUES ('L01', 'T2108M', 4)
INSERT INTO tbLophoc VALUES ('L02', 'T2109M', 5)
INSERT INTO tbLophoc VALUES ('L03', 'T1307M', 6)
INSERT INTO tbLophoc VALUES ('L04', 'T1408M', 3)
INSERT INTO tbLophoc VALUES ('L05', 'T1508M', 3)
GO
SELECT * FROM tbLophoc
--Nh?p d? li?u sinh vi�n
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV01', N'Nguy?n',N'V?n An','11-11-2004',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV02', N'??',N'H� Linh', '03-23-2003', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV03', N'Tr?n',N'V?n B�nh','12-11-2003','SV03','L02')
INSERT INTO tbSinhvien VALUES ('SV04', N'Tr?n',N'Minh H�', '03-14-2002', 1,NULL,'L03')
INSERT INTO tbSinhvien VALUES ('SV05', N'Nguy?n',N'Th? Mai', '10-23-2004', 1,'SV01','L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV06', N'L�',N'Ch� Th�nh', '12-10-2003','SV03','L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV07', N'??',N'V?n C??ng', '10-10-2003','SV04','L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV08', N'Nguy?n',N'Tr??ng Giang', '09-12-2003',NULL,'L01')
INSERT INTO tbSinhvien VALUES ('SV09', N'L�',N'V�n H�','12-23-2001', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV10', N'Mai',N'V?n D?ng', '10-04-2003',NULL,'L02')
INSERT INTO tbSinhvien VALUES ('SV11', N'H�',N'Th? Ph??ng', '02-12-2003', 1,'SV04', 'L03')
INSERT INTO tbSinhvien VALUES ('SV12', N'Tr?n',N'Kim Xuy?n', '07-10-2003', 1,'SV08', 'L01')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV13', N'L�',N'??c C??ng', '12-10-2004',NULL,'L02')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV14', N'Nguy?n',N'??c Duy','10-10-2002',NULL,'L03')
INSERT INTO tbSinhvien(MaSV, Ho, Ten, Ngaysinh, MaTruongNhom, MaLop) VALUES('SV15', N'Nguy?n',N'Duy Linh','11-10-2002',NULL,'L04')
go
SELECT * FROM tbSinhvien
go
UPDATE tbSinhvien SET MaTruongNhom='SV13' WHERE MaSV='SV10'
GO
--Nh?p m?t s? m�n h?c
INSERT INTO tbMonhoc VALUES ('MH01',N'L?p tr�nh C', N'abcdef')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH02',N'Thi?t k? Web')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH03', N'Thi?t k? CSDL')
INSERT INTO tbMonhoc(MaMon, TenMon) VALUES ('MH04', N'AI')
SELECT * FROM tbMonhoc
--Nh?p m?t s? ?i?m thi
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
go
--1.Hi?n th? M� SV, H? t�n (ho + ten), Ng�y sinh, gi?i t�nh, m� tr??ng nh�m, m� l?p c?a c�c sinh vi�n
SELECT MaSV, Ho + ' ' + Ten as [Hoten], Ngaysinh, Gioitinh, MaTruongNhom, MaLop FROM tbSinhvien
--Hi?n th? ng�y sinh:Ng�y/Th�ng/N?m
SELECT MaSV, Ho + ' ' + Ten as [Hoten], 
CONVERT(char(2),Day(Ngaysinh)) + '/' + CONVERT(char(2),MONTH(Ngaysinh)) 
+ '/' + CONVERT(char(4),YEAR(Ngaysinh)) as [Ngay sinh], 
Gioitinh, MaTruongNhom, MaLop FROM tbSinhvien

--2.Hi?n th? th�ng tin M� SV, H? t�n , Ng�y sinh, gi?i t�nh, m� tr??ng nh�m v� T�n Tr??ng nh�m c?a m?i sinh vi�n
SELECT SV1.MaSV, SV1.Ho + ' ' + SV1.Ten as [Hoten], SV1.Ngaysinh,SV1.Gioitinh, 
SV1.MaTruongNhom, SV2.Ho + ' ' + SV2.Ten as [Ho ten truong nhom]
FROM tbSinhvien SV1 LEFT OUTER JOIN tbSinhvien SV2 
ON SV1.MaTruongNhom = SV2.MaSV

--3.Hi?n th? M� Sinh vi�n, H? t�n, M� M�n, T�n M�n v� ?i?m thi c?a t?t c? sinh vi�n
SELECT SV.MaSV, SV.Ho + SV.Ten [Ho ten], MH.MaMon, MH.TenMon, BD.Diemthi 
FROM tbSinhvien SV 
LEFT OUTER JOIN tbBangDiem BD ON SV.MaSV=BD.MaSV
LEFT OUTER JOIN tbMonhoc MH ON BD.MaMon=MH.MaMon

--4.Hi?n th? c�c m�n h?c ch?a c� sinh vi�n n�o thi
SELECT * FROM tbMonHoc WHERE MaMon not in (SELECT (MaMon) FROM tbBangDiem)

--5.Hi?n th? M� M�n, T�n m�n h?c, ?i?m trung b�nh c?a t?ng m�n
select MH.MaMon, MH.TenMon, AVG(BD.DiemThi) as [?TB] from tbMonHoc MH , tbBangDiem BD 
where MH.MaMon = BD.MaMon group by MH.MaMon, MH.TenMon
go

--6.Hi?n th? M� M�n, T�n m�n h?c, ?i?m cao nh?t c?a t?ng m�n
select BD.Mamon, MH.TenMon, MAX(BD.Diemthi) as [?i?m cao nh?t] 
from tbBangdiem BD inner join tbMonhoc MH on MH.Mamon = BD.Mamon group by BD.Mamon, MH.TenMon 

--7.Hi?n th? C�c sinh vi�n m� c� ?i?m = ?i?m cao nh?t c?a m�n h?c c� m� MH01
SELECT * FROM tbBangDiem WHERE MaMon='MH01'
SELECT * FROM tbBangDiem WHERE Diemthi=9.2
select * from tbSinhvien sv
where sv.masv in (select bd.MaSV  from tbBangdiem bd 
where Diemthi=(select max (Diemthi) from tbBangdiem where mamon='mh01') and bd.mamon='mh01')

--8.Hi?n th? t�n m�n h?c v� t?ng s? sinh vi�n ??t ?i?m cao nh?t c?a m?i m�n h?c
SELECT b2.MaMon, b3.TenMon, COUNT(b1.Diemthi) AS CountScore ,MAX(Diemthi) AS MaxScore
FROM tbBangDiem b1 INNER JOIN
((SELECT MaMon, MAX(Diemthi) AS MaxScore FROM tbBangDiem GROUP BY MaMon)  b2 
INNER JOIN tbMonhoc b3 ON b2.MaMon = b3.MaMon) ON b1.MaMon = b2.MaMon
WHERE b2.MaxScore = b1.Diemthi GROUP BY b2.MaMon, b3.TenMon
go
--ch?a b�i c�u 8
SELECT b1.MaMon, b2.TenMon, COUNT(b1.Diemthi) AS CountScore ,MAX(Diemthi) AS MaxScore
FROM  tbBangDiem b1 INNER JOIN tbMonhoc b2 ON b1.MaMon=b2.MaMon --join tbMon h?c ?? l?y t�n m�n
WHERE b1.Diemthi =(SELECT MAX(Diemthi) FROM tbBangDiem b3 WHERE b3.MaMon=b1.MaMon) --x�t ?i?m thi = max c?a m�n t??ng ?ng
GROUP BY b1.MaMon, b2.TenMon --nh�m theo m� m�n + t�n m�n ?? ??m (count) s? b?n ghi

select * from tbBangdiem order by Mamon

--9.Hi?n th? M� Sinh vi�n, H? t�n, M� M�n, T�n M�n v� ?i?m thi c?a t?t c? sinh vi�n 
--m� c� ?i?m > ?i?m trung b�nh c?a m�n m?i m�n

SELECT SV.MaSV, SV.Ho,SV.Ten, BD.MaMon, MH.TenMon, BD.Diemthi
FROM tbSinhvien SV, tbBangDiem BD, tbMonhoc MH
WHERE (SV.MaSV = BD.MaSV) AND BD.MaMon=MH.MaMon
AND Diemthi > (SELECT AVG(Diemthi) FROM tbBangDiem BD2 GROUP BY BD2.MaMon HAVING BD2.MaMon=MH.MaMon)

--10. Hi?n th? 2 m�n h?c c� nhi?u sinh vi�n thi nh?t
SELECT b3.MaMon, b2.TenMon, CountScore 
FROM (SELECT TOP 2 MaMon, COUNT(b1.Diemthi) AS CountScore 
FROM tbBangDiem b1 GROUP BY MaMon ORDER BY CountScore DESC) b3
INNER JOIN tbMonhoc b2 ON b3.MaMon = b2.MaMon

SELECT top 2 b1.Mamon, b2.TenMon, count(diemthi) as countscore
FROM tbBangDiem b1 INNER JOIN tbMonhoc b2 ON b1.MaMon=b2.MaMon
GROUP BY b1.Mamon, b2.TenMon ORDER BY countscore desc

--11. Hi?n th? danh s�ch c�c sinh vi�n ch?a thi m�n n�o
SELECT b0.* FROM tbSinhvien b0 WHERE b0.MaSV != ALL(SELECT MaSV FROM tbBangDiem)

SELECT * FROM tbSinhvien WHERE MaSV NOT IN(SELECT MaSV FROM tbBangDiem)

--12. Hi?n th? M� l?p, t�n l?p c?a c�c l?p h?c m� ch?a c� sinh vi�n n�o c� ?i?m thi
SELECT b0.MaLop, b0.TenLop, COUNT(b2.MaSV) AS [S? h?c sinh ?i thi] 
FROM (tbLophoc b0 Left JOIN tbSinhvien b1 ON b0.MaLop = b1.MaLop) LEFT JOIN 
tbBangDiem b2 ON b2.MaSV = b1.MaSV GROUP BY b0.MaLop, b0.TenLop HAVING COUNT(b2.MaSV) = 0

	SELECT DISTINCT(LH.MaLop),LH.TenLop FROM (tbLophoc LH LEFT OUTER JOIN tbSinhvien SV ON SV.MaLop=LH.MaLop),
	(SELECT SV.MaSV FROM tbSinhvien SV LEFT OUTER JOIN tbBangdiem BD ON BD.MaSV=SV.MaSV
	WHERE SV.MaSV NOT IN (SELECT MaSV FROM tbBangdiem)) A
	WHERE LH.MaLop NOT IN (SELECT MaLop FROM tbSinhvien WHERE MaSV!=A.MaSV)


--13. Hi?n th? c�c sinh vi�n n?m trong TOP 3 ?i?m trung b�nh cao nh?t
SELECT SV.MaSV,SV.Ho,SV.Ten, AVG(Diemthi) DiemTB 
FROM tbSinhvien SV INNER JOIN tbBangDiem BD ON SV.MaSV=BD.MaSV 
GROUP BY SV.MaSV,SV.Ho,SV.Ten HAVING AVG(Diemthi) in
(SELECT top 3 AVG(Diemthi) DiemTB FROM  tbBangDiem bd 
GROUP BY (MaSV) ORDER BY DiemTB DESC) ORDER BY DiemTB DESC
--14. Hi?n th? c�c sinh vi�n n?m trong TOP 3 ?i?m trung b�nh cao nh?t, ch? x�t nh?ng sinh vi�n thi t? 3 m�n tr? l�n

SELECT SV.MaSV,SV.Ho,SV.Ten, AVG(Diemthi) DiemTB, COUNT(*) Somon
FROM tbSinhvien SV INNER JOIN tbBangDiem BD ON SV.MaSV=BD.MaSV 
GROUP BY SV.MaSV,SV.Ho,SV.Ten HAVING COUNT(*)>=3 AND AVG(Diemthi) in
(SELECT top 3 AVG(Diemthi) DiemTB FROM  tbBangDiem bd 
GROUP BY (MaSV) ORDER BY DiemTB DESC) ORDER BY DiemTB DESC

--15. Hi?n th? c�c m�n h?c c� ?i?m trung b�nh th?p nh?t
SELECT b1.MaMon, b1.TenMon,ROUND(AVG(b2.Diemthi),2) AS [?i?m trung b�nh] 
FROM tbMonhoc b1 INNER JOIN tbBangDiem b2 ON b1.MaMon = b2.MaMon 
GROUP BY b1.MaMon, b1.TenMon HAVING ROUND(AVG(b2.Diemthi),2) = (
SELECT TOP 1 ROUND(AVG(Diemthi),2) FROM tbBangDiem
GROUP BY MaMon ORDER BY ROUND(AVG(Diemthi),2) ASC)
