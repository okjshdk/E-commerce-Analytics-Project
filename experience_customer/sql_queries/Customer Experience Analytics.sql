/*

-	Data Exploration: Phân tích trải nghiệm khách hàng sau khi mua
-	Data: Olist (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
-	Purpose:
		+	Phân tích các yếu tố ảnh hưởng đến trải nghiệm khách hàng sau mua
		+	Kiểm tra mối quan hệ giữa review_score và thời gian giao hàng, trạng thái đơn hàng, khu vực, sản phẩm
-	Skills Used: Joins, CTEs, Window Functions, Aggregate Functions, Converting Data Types



*/


--	Trung bình điểm đánh giá theo từng tháng trong năm
--	Mục tiêu: Theo dõi sự thay đổi chất lượng dịch vụ theo thời gian

select 
	datepart(yyyy, r.review_creation_date) as year, 
	datepart(m, r.review_creation_date) as month, 
	avg(r.review_score) as score
from OlistProject..order_reviews r
group by datepart(yyyy, r.review_creation_date), datepart(m, r.review_creation_date)
order by 1, 2



--	Trung bình điểm đánh giá theo trạng thái đơn hàng
--	Mục tiêu: Kiểm tra trạng thái đơn hàng có ảnh hưởng đến điểm đánh giá không

select 
	o.order_status, 
	avg(r.review_score) as avg_score, 
	count(*) as orders
from OlistProject..order_reviews r
join OlistProject..orders o
	on r.order_id = o.order_id
group by o.order_status
having count(*) > 100
order by 2 asc;



--	Tổng số đơn hàng và số đơn hàng bị trễ theo từng mức điểm đánh giá
--	Mục tiêu: Kiểm tra số lượng đơn hàng bị trễ chiếm bao nhiêu % ở từng mức điểm đánh giá

select 
	r.review_score, 
	count(*) as orders,
	round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_orders,
	sum(case when o.order_estimated_delivery_date < o.order_delivered_customer_date then 1 else 0 end) as order_delay,
	round(sum(case when o.order_estimated_delivery_date < o.order_delivered_customer_date then 1 else 0 end) 
	* 100.0 / count(*), 2) as percentage_orders_delay
from OlistProject..order_reviews r
join OlistProject..orders o on r.order_id = o.order_id
group by r.review_score
order by 5 desc;



--	Điểm đánh giá theo vùng địa lý

select 
	c.customer_state as state, 
	avg(r.review_score) as avg_score
from OlistProject..order_reviews r
join OlistProject..orders o on r.order_id = o.order_id
join OlistProject..customers c on c.customer_id = o.customer_id
group by c.customer_state
order by 2 desc;


--	Top trung bình điểm đánh giá thấp nhất theo danh mục sản phẩm
--	Mục tiêu: Cho biết danh mục sản phẩm nào thường có điểm đánh giá thấp

with products_eng as (
	select 
		p. product_id, 
		pcnt.product_category_name_english
	from OlistProject..products p
	join OlistProject..product_category_name_trans pcnt on p.product_category_name = pcnt.product_category_name
	where p.product_category_name is not null
)

select 
	pe.product_category_name_english as category, 
	avg(review_score) as score,
	count(distinct oi.order_id) as orders
from OlistProject..order_reviews r
join OlistProject..order_items oi on r.order_id = oi.order_id
join products_eng pe on oi.product_id = pe.product_id
group by pe.product_category_name_english
having count(distinct oi.order_id) >= 100
order by 2 asc;
