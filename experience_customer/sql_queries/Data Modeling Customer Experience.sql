/*

-	Data modeling:	Trải nghiệm khách hàng sau khi mua
-	Data: Olist (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
-	Purpose:
		+	Xây dựng mô hình dữ liệu phục vụ phân tích trải nghiệm khách hàng sau mua
		+	Chuẩn hóa theo mô hình star schema với 1 fact + 4 dim
-	Các fact, dim:
		+	Fact: fact_customer_experience
		+	Dims: dim_regions, dim_product, dim_date, dim_order_status
*/


--	Fact table: fact_customer_experience

use OlistProject;

go

create or alter view fact_customer_experience as

select
	r.review_id, r.order_id, c.customer_state as state,
	pcnt.product_category_name_english as category,
	o.order_status ,
	convert(date, r.review_creation_date) as date,
	r.review_score, 
	datediff(day, o.order_purchase_timestamp, o.order_delivered_customer_date) as delivered_time
from OlistProject..order_reviews r
join OlistProject..orders o on o.order_id = r.order_id
join OlistProject..customers c on c.customer_id = o.customer_id
join OlistProject..order_items oi on oi.order_id = o.order_id
join OlistProject..products p on p.product_id = oi.product_id
join OlistProject..product_category_name_trans pcnt on pcnt.product_category_name = p.product_category_name;


--	Dim table: dim_regions

go

create or alter view dim_regions as

select distinct c.customer_state as state
from OlistProject..customers c;



--	Dim table: dim_product

go

create or alter view dim_product as

select distinct pcnt.product_category_name_english as category
from OlistProject..products p
join OlistProject..product_category_name_trans pcnt on pcnt.product_category_name = p.product_category_name;


--	Dim table: dim_date

go

create or alter view dim_date as

select distinct
	convert(date, r.review_creation_date) as date, 
	datepart(d, r.review_creation_date) as day,
	datepart(m, r.review_creation_date) as month,
	datepart(q, r.review_creation_date) as quarter,
	datepart(yyyy, r.review_creation_date) as year
from OlistProject..order_reviews r;


--	Dim table: dim_order_status

go

create or alter view dim_order_status as

select distinct o.order_status
from OlistProject..orders o;

