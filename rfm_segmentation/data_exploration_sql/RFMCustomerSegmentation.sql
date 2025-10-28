/*

Data Exploration: Phân khúc khách hàng theo Recency - Frequency - Monetary
Data: Olist (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
Tools: SQL Server
Skills used: Joins, Views, CTE's, Subquery, Windows Functions, Aggregate Functions,
            Date and Time Functions, String Functions, CASE Expressions
  
*/


--  Tính các chỉ số RFM cho từng khách hàng

use OlistProject;

go

create or alter view rfm_base as

select 
    c.customer_unique_id,
    datediff(day, max(o.order_purchase_timestamp), 
        (select max(order_purchase_timestamp) 
        from OlistProject..orders where order_status = 'delivered')) as recency,
    count(distinct o.order_id) as frequency,
    sum(op.payment_value) as monetary
from OlistProject..customers c
join OlistProject..orders o on c.customer_id = o.customer_id
join OlistProject..order_payments op on o.order_id = op.order_id
where o.order_status = 'delivered'
group by c.customer_unique_id

go

select *
from rfm_base
order by 4 desc;

--  Chuẩn hóa thang điểm RFM (thang 5)

go

create or alter view rfm_score as

select
    rb.customer_unique_id,
    ntile(5) over (order by rb.recency desc) as r_score,
    case 
        when rb.frequency = 1 then 1
        when rb.frequency = 2 then 2
        when rb.frequency = 3 then 3
        when rb.frequency = 4 then 4
        else 5
    end as f_score,
    ntile(5) over (order by rb.monetary asc) as m_score
from rfm_base rb

go

select *
from rfm_score rs;



--  Phân nhóm khách hàng theo RFM

go

create or alter view rfm_customer_segment as

select
    customer_unique_id,
    case
        when concat(r_score, f_score, m_score) in ('555','554','544','545','454','455','445') then 'champions'
        when concat(r_score, f_score, m_score) in ('543','444','435','355','354','345','344','335') then 'loyal customers'
        when concat(r_score, f_score, m_score) in (
            '553','551','552','541','542','533','532','531','452','451','442','441','431',
            '453','433','432','423','353','352','351','342','341','333','323'
        ) then 'potential loyalist'
        when concat(r_score, f_score, m_score) in ('512','511','422','421','412','411','311') then 'recent customers'
        when concat(r_score, f_score, m_score) in (
            '525','524','523','522','521','515','514','513','425','424','413','414','415','315','314','313'
        ) then 'promising'
        when concat(r_score, f_score, m_score) in ('535','534','443','434','343','334','325','324') then 'customers needing attention'
        when concat(r_score, f_score, m_score) in ('331','321','312','221','213') then 'about to sleep'
        when concat(r_score, f_score, m_score) in (
            '255','254','245','244','253','252','243','242','235','234','225','224','153','152',
            '145','143','142','135','134','133','125','124'
        ) then 'at risk'
        when concat(r_score, f_score, m_score) in ('155','154','144','214','215','115','114','113') then 'can’t lose them'
        when concat(r_score, f_score, m_score) in (
            '332','322','231','241','251','233','232','223','222','132','123','122','212','211'
        ) then 'hibernating'
        when concat(r_score, f_score, m_score) in ('111','112','121','131','141','151') then 'lost'
    end as segment
from rfm_score;

go

select *
from rfm_customer_segment rcs;



--  Phân bố khách hàng theo từng phân khúc RFM

select
    rcs.segment,
    count(*) as num_customers,
    100.0 * count(*) / sum(count(*)) over () as percentage_customers
from rfm_customer_segment rcs
group by rcs.segment
order by 2 desc;



--  Trung bình recency, frequency và tổng doanh thu theo từng phân khúc RFM

select 
    rcs.segment,
    avg(rb.recency * 1.0) as avg_recency,
    avg(rb.frequency * 1.0) as avg_frequency,
    sum(rb.monetary) as total_revenue, 
    100.0 * sum(rb.monetary) / sum(sum(rb.monetary)) over () as percentage_revenue
from rfm_customer_segment rcs
join rfm_base rb on rcs.customer_unique_id = rb.customer_unique_id
group by rcs.segment
order by 4 desc;

--  Vị trí địa lý của từng nhóm khách hàng theo RFM

select 
    rcs.segment,
    c.customer_state,
    count(rcs.customer_unique_id) as num_customers,
    100.0 * count(rcs.customer_unique_id) / sum(count(rcs.customer_unique_id)) over () as percentage_customer,
    100.0 * sum(rb.monetary) / sum(sum(rb.monetary)) over () as percentage_revenue
from rfm_customer_segment rcs
join OlistProject..customers c on rcs.customer_unique_id = c.customer_unique_id
join rfm_base rb on rcs.customer_unique_id = rb.customer_unique_id
group by rcs.segment, c.customer_state
order by 1, 5 desc;


--  Top danh mục sản phẩm ưu chuộng của từng nhóm khách hàng RFM

with customer_product as (
    select c.customer_unique_id, oi.product_id
    from OlistProject..customers c
    join OlistProject..orders o on c.customer_id = o.customer_id
    join OlistProject..order_items oi on oi.order_id = o.order_id
),

customer_category_eng as (
    select cp.customer_unique_id, pcnt.product_category_name_english
    from customer_product cp
    join OlistProject..products p on cp.product_id = p.product_id
    join OlistProject..product_category_name_trans pcnt on pcnt.product_category_name = p.product_category_name
)

select rcs.segment, cce.product_category_name_english, count(rcs.customer_unique_id) as num_customers
from rfm_customer_segment rcs
join customer_category_eng cce on rcs.customer_unique_id = cce.customer_unique_id
group by  rcs.segment, cce.product_category_name_english
order by 1, 3 desc;


--  Phương thức trả tiền của từng nhóm khách hàng RFM

with customer_payment as (
    select c.customer_unique_id, op.payment_type
    from OlistProject..customers c
    join OlistProject..orders o on c.customer_id = o.customer_id
    join OlistProject..order_payments op on op.order_id = o.order_id 
)

select rcs.segment, cp.payment_type, count(rcs.customer_unique_id) as num_customers,
        100.0 * count(rcs.customer_unique_id) / sum(count(rcs.customer_unique_id)) over () as percentage_customer
from rfm_customer_segment rcs
join customer_payment cp on rcs.customer_unique_id = cp.customer_unique_id
group by rcs.segment, cp.payment_type
order by 1, 4 desc