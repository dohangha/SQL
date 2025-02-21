Select * from Lession1_SQL.dbo.Staff_import
Select * from Lession1_SQL.dbo.transaction_import_lesion1
Select* from Lession1_SQL.dbo.Branch_import
Select* from Lession1_SQL.dbo.TYGIA_import
Select* from Lession1_SQL.dbo.CUS_ID_import
Select* from Lession1_SQL.dbo.Banhang
--1.Lấy tổng số tiền của nhân viên có giao dịch trong ngày 02-04-2019, thông tin nhân viên phải có đủ tên, ngày vào công ty hệ và hệ số lương
Select 
	A.[Tên], 
	A.[Ngày vào công ty], 
	A.[hệ số lương],
	sum([Số tiền Mua hàng nguyên tệ]) as TongSoTien
from Lession1_SQL.dbo.Staff_import as A
	inner join Lession1_SQL.dbo.transaction_import_lesion1 as B
	on A.[Mã nhân viên]=B.Sale_man_ID
where year(Trans_Time)=2019 and month(Trans_Time)=04 and day(Trans_Time)=02
group by 
	A.[Tên], 
	A.[Ngày vào công ty], 
	A.[hệ số lương]
;
--2.Lấy tổng số tiền của nhân viên có giao dịch trong ngày 02-04-2019 và vào công ty năm 2019
Select 
	A.[Tên], 
	A.[Ngày vào công ty], 
	sum([Số tiền Mua hàng nguyên tệ]) as TongSoTien
from Lession1_SQL.dbo.Staff_import as A
	inner join Lession1_SQL.dbo.transaction_import_lesion1 as B
	on A.[Mã nhân viên]=B.Sale_man_ID
where year([Ngày vào công ty])=2019 and year(Trans_Time)=2019 and month(Trans_Time)=04 and day(Trans_Time)=02
group by 
	A.[Tên], 
	A.[Ngày vào công ty]
;
--3.Lấy thông tin giao dịch có thông tin địa điểm của hàng, thông tin tên khách hàng
Select * 
from Lession1_SQL.dbo.Branch_import as A
	inner join Lession1_SQL.dbo.transaction_import_lesion1 as B
	on A.[Mã cửa hàng]=B.[Store ID];
--4.Lấy thông tin giao dịch có thông tin địa điểm của hàng(Branch), thông tin email và số điện thoại khách hàng(Cus_ID), và tỷ giá(Tygia) tại ngày đó
--Cach 1
Select 
	Lession1_SQL.dbo.Branch_import.[Địa điểm], 
	Lession1_SQL.dbo.CUS_ID_import.[Email], 
	Lession1_SQL.dbo.CUS_ID_import.[Phone Num],
	Lession1_SQL.dbo.TYGIA_import.[Tỷ giá]
from 
	Lession1_SQL.dbo.Branch_import,
	Lession1_SQL.dbo.CUS_ID_import,
	Lession1_SQL.dbo.TYGIA_import,
	Lession1_SQL.dbo.transaction_import_lesion1
where 
	Lession1_SQL.dbo.transaction_import_lesion1.Trans_Time=Lession1_SQL.dbo.TYGIA_import.[Ngày] and
	Lession1_SQL.dbo.transaction_import_lesion1.[Tên Khách hàng]=Lession1_SQL.dbo.CUS_ID_import.[Tên khách hàng] and
	Lession1_SQL.dbo.transaction_import_lesion1.[Store ID]=Lession1_SQL.dbo.Branch_import.[Mã cửa hàng]
;
--Cach 2
Select 
	D.[Địa điểm], 
	C.[Email], 
	C.[Phone Num],
	B.[Tỷ giá]
from 
	(Lession1_SQL.dbo.transaction_import_lesion1 as A 
	inner join Lession1_SQL.dbo.TYGIA_import as B on A.Trans_Time=B.[Ngày]
	inner join Lession1_SQL.dbo.CUS_ID_import as C on A.[Tên Khách hàng]=C.[Tên khách hàng]
	inner join Lession1_SQL.dbo.Branch_import as D on A.[Store ID]=D.[Mã cửa hàng]
	)
;
--5.Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 4 năm 2019
Select * 
from Lession1_SQL.dbo.transaction_import_lesion1
where year(Trans_Time)=2019 and month(Trans_Time)=04;
--6.Tạo ra bảng dữ liệu danh sách giao dịch trong tháng 6 năm 2019
Select * 
from Lession1_SQL.dbo.transaction_import_lesion1
where year(Trans_Time)=2019 and month(Trans_Time)=06;
--7.Tìm những nhân viên có giao dịch trong tháng 4-2019 nhưng không giao dịch trong tháng 6 năm 2019 từ 2 bảng vừa được tạo trên
Select A.Sale_man, A.Trans_Time, B.Trans_Time
from 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=04) A
	left join 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=06) B
	on A.[Store ID]=B.[Store ID]
	where B.Sale_man is null
group by A.Sale_man, A.Trans_Time, B.Trans_Time
;
--8.Tìm danh sách khách hàng có mua hàng trong cả tháng 4 và tháng 6 từ 2 bảng vừa được tạo trên
Select A.[Tên Khách hàng], A.Trans_Time, B.Trans_Time 
from
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=04) A
	inner join 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=06) B
	on A.[Tên Khách hàng]=B.[Tên Khách hàng]
group by A.[Tên Khách hàng], A.Trans_Time, B.Trans_Time 
;
--9.Tìm danh sách khách hàng có mua hàng trong tháng 4 nhưng không mua trong tháng 6 và ngược lại từ 2 bảng vừa được tạo trên
-- có mua hàng tháng 4 nhưng không mua tháng 6
Select A.[Tên Khách hàng], A.Trans_Time, B.Trans_Time
from 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=04) A
	left join 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=06) B
	on A.[Store ID]=B.[Store ID]
	where B.Sale_man is null
group by A.[Tên Khách hàng], A.Trans_Time, B.Trans_Time;
-- ngược lại
Select B.[Tên Khách hàng], A.Trans_Time, B.Trans_Time
from 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=04) A
	right join 
	(Select * from Lession1_SQL.dbo.transaction_import_lesion1
	where year(Trans_Time)=2019 and month(Trans_Time)=06) B
	on A.[Store ID]=B.[Store ID]
	where A.Sale_man is null
group by B.[Tên Khách hàng], A.Trans_Time, B.Trans_Time;
--10.So sánh số tiền giao dịch của từng nhân viên trong tháng 4 và tháng 6
with tbla as
	(select Sale_man,
		sum(case 
				when year(Trans_Time)=2019 and month(Trans_Time)=04 then '42019'
				else 0
				end) as TongSoTienthang4nam2019,
		sum(case 
				when year(Trans_Time)=2019 and month(Trans_Time)=06 then '62019'
				else 0
				end) as TongSoTienthang6nam2019
from Lession1_SQL.dbo.transaction_import_lesion1
group by Sale_man)
select *,
	case
	when TongSoTienthang4nam2019 > TongSoTienthang6nam2019 then 'Thang 4> thang 6'
	when TongSoTienthang4nam2019 < TongSoTienthang6nam2019 then 'Thang 4<thang 6'
	when TongSoTienthang4nam2019 = TongSoTienthang6nam2019 then'Thang 4=thang 6'
	end as 'so sanh'
from tbla
;
--11.So sánh số tiền mua hàng của từng khách hàng trong tháng 4 và tháng 6
with tblb as
	(select [Tên khách hàng],
		sum(case 
				when year(Trans_Time)=2019 and month(Trans_Time)=04 then '42019'
				else 0
				end) as TongSoTienthang4nam2019,
		sum(case 
				when year(Trans_Time)=2019 and month(Trans_Time)=06 then '62019'
				else 0
				end) as TongSoTienthang6nam2019
from Lession1_SQL.dbo.transaction_import_lesion1
group by [Tên khách hàng])
select *,
	case
	when TongSoTienthang4nam2019 > TongSoTienthang6nam2019 then 'Thang 4> thang 6'
	when TongSoTienthang4nam2019 < TongSoTienthang6nam2019 then 'Thang 4<thang 6'
	when TongSoTienthang4nam2019 = TongSoTienthang6nam2019 then'Thang 4=thang 6'
	end as 'So Sanh'
from tblb
;