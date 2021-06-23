use demo2006
-- BÀI TẬP ÔN TẬP SQL
-- Bài quản lý sản phẩm
-- 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 19/6/2006 và ngày 20/6/2006.
-- 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 6/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
-- 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 19/06/2007
select customer.id,customer.name 
from customer join orderr on customer.id=orderr.id
where orderr.time = "2006-09-19";

-- 10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select product.id,product.name
from product,customer join orderr on customer.id=orderr.id
where customer.name ="Nguyễn Văn A" and month(orderr.time)=10 and year(orderr.time)=2006;
-- 11. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”.
select orderr.id,orderr.time
from orderr join orderdetail on orderr.id=orderdetail.orderId
			join product on orderdetail.productId=product.id
where product.name="Máy Giặt" or product.name ="Tủ Lạnh"
group by orderr.id, orderr.time;
-- 12. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT orderr.id, product.name, orderr.time
FROM orderdetail , product , orderr
where orderdetail.productId = product.id 
and orderr.id = orderdetail.orderid 
and (product.name like 'Máy Giặt%' or product.name like 'Tủ lạnh%') 
and orderdetail.quantity >=10 
and orderdetail.quantity <=20
group by orderr.id;
-- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm “Máy giặt” và “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
-- 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
select product.id,product.name as "Sản phẩm không bán được"
from product
group by product.id,product.name 
having product.name not in(select product.name from product join orderdetail on orderdetail.productId= product.id);

-- 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
select product.id,product.name as "Sản phẩm không bán được năm 2006"
from product
group by product.id,product.name 
having product.name not in(select product.name from product join orderdetail on orderdetail.productId= product.id)
and product.id in(select orderdetail.productId from orderdetail,orderr where year(orderr.time)=2006  )  ;
-- 17. In ra danh sách các sản phẩm (MASP,TENSP) có giá >300 sản xuất bán được trong năm 2006.
select  product.id, product.name
from product
where product.price>300
and product.id  in (select orderdetail.productId from orderdetail,orderr where year(orderr.time)=2006);
-- 18. Tìm số hóa đơn đã mua tất cả các sản phẩm có giá >200.
select orderdetail.orderid
from orderdetail join product on product.id = orderdetail.productId
where product.price>200
group by orderdetail.orderid;
-- 19. Tìm số hóa đơn trong năm 2006 đã mua tất cả các sản phẩm có giá <300.
​
select orderdetail.orderId from orderdetail, product, orderr
where orderdetail.productid = product.id
and orderdetail.orderId = orderr.id
and year(time) = 2006
group by orderdetail.orderid
having max(product.price) < 300;
-- 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.

-- 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
select min(orderdetail.quantity*product.price) as "min", max(orderdetail.quantity*product.price) as "max"
from orderdetail join product on product.id=orderdetail.productID;
-- 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
-- 24. Tính doanh thu bán hàng trong năm 2006.
-- 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
-- 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.

-- 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) mua nhiều hàng nhất (tính theo số lượng).
select customer.id, customer.name, sum(orderdetail.quantity) as amount
from orderdetail join orderr  on orderdetail.orderid = orderr.id join customer  on customer.id = orderr.customerid
group by customer.Id
order by amount desc
limit 3;

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
-- 29. In ra danh sách các sản phẩm (MASP, TENSP) có tên bắt đầu bằng chữ M, có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
-- 32. Tính tổng số sản phẩm giá <300.
select count(product.price)
from product
where price<300;
-- 33. Tính tổng số sản phẩm theo từng giá.
-- 34. Tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm bắt đầu bằng chữ M.
select max(price) as "Giá cao nhất", min(price) as "Giá thấp nhất", avg(price) as "Giá TB"
from product
where product.name like "M%";
-- 35. Tính doanh thu bán hàng mỗi ngày.
-- 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
-- 37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
-- 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select orderdetail.orderId as"Hoa don mua it nhat 4 san pham khac nhau"
from orderdetail
group by orderdetail.orderId
having count(orderdetail.productId)>=4;
-- 39. Tìm hóa đơn có mua 3 sản phẩm có giá <300 (3 sản phẩm khác nhau).
select orderr.id as "Hoa don mua 3 san pham khac nhau co gia <300"
from product join orderdetail on product.id=orderdetail.productId join orderr on orderr.id=orderdetail.orderId 
where product.price<300 and orderr.id in ( select orderr.id from orderr join orderdetail on orderr.id=orderdetail.orderId 
 group by orderr.id 
 having count(distinct orderdetail.productId)>=3 )
  group by orderr.id;

-- 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.

-- create view viewview as
select name, count(orderr.customerId) as "hihi"
from customer join orderr  on customer.id=orderr.customerId ;
select  name,max(hihi)
from viewview; 


-- 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
-- 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
-- 45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
