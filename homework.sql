--1. Ti?nh tô?ng sô? tiê?n theo t??ng ma? c??a ha?ng va? theo t??ng vu?ng d??a theo ?i?a chi? nhân viên (Miê?n B??c, Miê?n Trung, Miê?n Nam).
Select * from Lession1_SQL.dbo.Banhang
Select distinct(Sale_man_address) from Lession1_SQL.dbo.Banhang
Select StoreID, Sale_man_address,
	case
		when Sale_man_address in ('Lao Cai', 'Yen Bai', 'Dien Bien', 'Hoa Binh', 'Lai Chau', 'Son La', 'Ha Giang', 'Cao Bang', 'Bac Kan', 'Lang Son', 'Tuyen Quang', 'Thai Nguyen', 'Phu Tho', 'Bac Giang', 'Quang Ninh', 'Bac Ninh', 'Ha Nam', 'Ha Noi', 'Hai Duong', 'Hai Phong', 'Hung Yen', 'Nam Dinh', 'Ninh Binh', 'Thai Binh', 'Vinh Phuc') then 'Mien Bac'
		when Sale_man_address in ('Thanh Hoa', 'Nghe An', 'Ha Tinh', 'Quang Binh', 'Quang Tri', 'Thua Thien Hue', 'Da Nang', 'Quang Nam', 'Quang Ngai', 'Binh Dinh', 'Phu Yen', 'Khanh Hoa', 'Ninh Thuan', 'Binh Thuan', 'Kon Tum', 'Gia Lai', 'Dak Lak', 'Dac Nong', 'Lam Dong') then 'Mien Nam'
		else 'Mien Trung'
	end as VungMien,
	sum (SoTienQuyDoi) as TongSoTien
from Lession1_SQL.dbo.Banhang
group by StoreID, Sale_man_address,
	case
		when Sale_man_address in ('Lao Cai', 'Yen Bai', 'Dien Bien', 'Hoa Binh', 'Lai Chau', 'Son La', 'Ha Giang', 'Cao Bang', 'Bac Kan', 'Lang Son', 'Tuyen Quang', 'Thai Nguyen', 'Phu Tho', 'Bac Giang', 'Quang Ninh', 'Bac Ninh', 'Ha Nam', 'Ha Noi', 'Hai Duong', 'Hai Phong', 'Hung Yen', 'Nam Dinh', 'Ninh Binh', 'Thai Binh', 'Vinh Phuc') then 'Mien Bac'
		when Sale_man_address in ('Thanh Hoa', 'Nghe An', 'Ha Tinh', 'Quang Binh', 'Quang Tri', 'Thua Thien Hue', 'Da Nang', 'Quang Nam', 'Quang Ngai', 'Binh Dinh', 'Phu Yen', 'Khanh Hoa', 'Ninh Thuan', 'Binh Thuan', 'Kon Tum', 'Gia Lai', 'Dak Lak', 'Dac Nong', 'Lam Dong') then 'Mien Nam'
		else 'Mien Trung'
	end;
--2. Ti?nh tô?ng sô? tiê?n theo t??ng ma? c??a ha?ng va? theo t??ng nho?m n?m cu?a th??i ?iê?m giao di?ch nh? sau t?? tha?ng 1 – tha?ng 6 2019(Quy? 1 20219), t?? tha?ng 7 – tha?ng 12 2019(Quy? 2 20219), t?? tha?ng 1 – 6 n?m 2020(Quy? 1 20220), t?? tha?ng 7 – 12 n?m 2020(Quy? 2 20220).
Select StoreID, TransTime,
	case
		when year(TransTime)=2019 and month(TransTime) in (01,02,03,04,05,06) then 'Quy 1 nam 2019'
		when year(TransTime)=2019 and month(TransTime) in (07,08,09,10,11,12) then 'Quy 2 nam 2019'
		when year(TransTime)=2020 and month(TransTime) in (01,02,03,04,05,06) then 'Quy 1 nam 2020'
		when year(TransTime)=2020 and month(TransTime) in (07,08,09,10,11,12) then 'Quy 2 nam 2020'
	end as Quy,
	sum (SoTienQuyDoi) as TongSoTien
from Lession1_SQL.dbo.Banhang
group by StoreID, TransTime,
case
		when year(TransTime)=2019 and month(TransTime) in (01,02,03,04,05,06) then 'Quy 1 nam 2019'
		when year(TransTime)=2019 and month(TransTime) in (07,08,09,10,11,12) then 'Quy 2 nam 2019'
		when year(TransTime)=2020 and month(TransTime) in (01,02,03,04,05,06) then 'Quy 1 nam 2020'
		when year(TransTime)=2020 and month(TransTime) in (07,08,09,10,11,12) then 'Quy 2 nam 2020'
	end;
--3. Ti?nh tô?ng sô? tiê?n theo t??ng ma? c??a ha?ng va? theo t??ng nho?m ma? kha?ch ha?ng chia nh? sau:
Select StoreID, Ma_KH,
	case
		when len(Ten_KH)<8 then 'Ten KH <8'
		when len(Ten_KH) between 8 and 12 then '8<Ten KH<12'
		when len(Ten_KH) between 12 and 15 then '12<Ten KH<15'
		else 'Ten KH >15'
		end as DemsotenKH,
		sum (SoTienQuyDoi) as TongSoTien
from Lession1_SQL.dbo.Banhang
group by StoreID, Ma_KH,
case
		when len(Ten_KH)<8 then 'Ten KH <8'
		when len(Ten_KH) between 8 and 12 then '8<Ten KH<12'
		when len(Ten_KH) between 12 and 15 then '12<Ten KH<15'
		else 'Ten KH >15'
		end;
--4. Lâ?y ra thông tin giao di?ch co? sô? tiê?n l??n nhâ?t theo t??ng nga?y va? t??ng c??a ha?ng
Select StoreID, TransTime, max(SoTienQuyDoi) as SoTienLonNhat
from Lession1_SQL.dbo.Banhang
group by StoreID, TransTime;
--Note: em khong biet lay them cot Ma_KH voi ten_KH vao nhu the nao
--5. Lâ?y ra kha?ch co? sô? tiê?n l??n nhâ?t theo t??ng nga?y va? t??ng c??a ha?ng
Select StoreID, TransTime, max(SoTienQuyDoi) as SoTienLonNhat
from Lession1_SQL.dbo.Banhang
group by StoreID, TransTime
--6. S?? du?ng insert into thêm d?? liê?u va?o ba?ng discount nh? trong file Lesson1-data.xlsb.
Select * from Lession1_SQL.dbo.Discount_import
insert into Lession1_SQL.dbo.Discount_import values (1,7,0.05,200,3)
insert into Lession1_SQL.dbo.Discount_import values (2,8,0.06,300,1)
--7. Ta?o ba?ng va? s?? du?ng insert into thêm 10 do?ng d?? liê?u va?o ba?ng Cus_ID nh? trong file Lesson1-data.xlsb.
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith', 'Nha Trang', 'Ms', 'Cong ty 123', 'James Smith@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989877', 'James Smith1', 'Nha Trang', 'Mr', 'Cong ty 122', 'James Smith1@gmail.com', 0998977878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989876', 'James Smith2', 'Nha Trang', 'Ms', 'Cong ty 143', 'James Smith2@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith3', 'Nha Trang', 'Ms', 'Cong ty 123', 'James Smith3@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith4', 'Nha Trang', 'Ms', 'Cong ty 124', 'James Smith4@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith5', 'Nha Trang', 'Ms', 'Cong ty 125', 'James Smith5@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith6', 'Nha Trang', 'Ms', 'Cong ty 163', 'James Smith6@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith7', 'Nha Trang', 'Ms', 'Cong ty 127', 'James Smith7@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith8', 'Nha Trang', 'Ms', 'Cong ty 1283', 'James Smith8@gmail.com', 0998987878, null)
Insert into Lession1_SQL.dbo.Cus_ID_import values ('MKH989878', 'James Smith9', 'Nha Trang', 'Ms', 'Cong ty 1293', 'James Smith9@gmail.com', 0998987878, null)
Select * from Lession1_SQL.dbo.Cus_ID_import where Address in ('Nha Trang')
--8. Update cô?t sô? ?iê?n thoa?i cu?a ba?ng Cus_ID b??ng ca?ch thêm sô? 0 va?o ?â?u
Update Lession1_SQL.dbo.Cus_ID_import
set [Phone Num]= concat('0', [Phone Num]) 
--9. Update cô?t Email cu?a ba?ng Cus_ID b??ng ca?ch xo?a ch?? @gmail.com ?i
Update Lession1_SQL.dbo.Cus_ID_import
set Email= Replace(Email, '@gmail.com', ' ')
--10. Xo?a ca?c công ty co? tên co? ?ô? da?i >= 13 ki? t??
delete from Lession1_SQL.dbo.Cus_ID_import
where len(Company) >=13 