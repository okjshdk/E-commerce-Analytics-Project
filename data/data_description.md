# 📘 Olist Brazilian E-Commerce Dataset

Nguồn dữ liệu: [Kaggle – Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 🧩 1. `olist_customers_dataset`
**Mô tả:** Thông tin khách hàng.  

| Cột | Mô tả |
|------|-------|
| `customer_id` | ID khách hàng (ẩn danh). |
| `customer_unique_id` | Định danh duy nhất của khách hàng (dùng để nhóm). |
| `customer_zip_code_prefix` | Mã vùng. |
| `customer_city` | Thành phố khách hàng. |
| `customer_state` | Bang khách hàng (SP, RJ, v.v.). |

---

## 📦 2. `olist_orders_dataset`
**Mô tả:** Thông tin đơn hàng.  

| Cột | Mô tả |
|------|-------|
| `order_id` | ID đơn hàng. |
| `customer_id` | Liên kết đến bảng `customers`. |
| `order_status` | Trạng thái đơn (delivered, shipped, canceled...). |
| `order_purchase_timestamp` | Thời gian đặt hàng. |
| `order_approved_at` | Thời điểm duyệt đơn. |
| `order_delivered_carrier_date` | Ngày giao hàng cho đơn vị vận chuyển. |
| `order_delivered_customer_date` | Ngày khách nhận hàng. |
| `order_estimated_delivery_date` | Ngày giao hàng dự kiến. |

---

## 🛒 3. `olist_order_items_dataset`
**Mô tả:** Chi tiết từng sản phẩm trong đơn hàng.  

| Cột | Mô tả |
|------|-------|
| `order_id` | ID đơn hàng. |
| `order_item_id` | Thứ tự sản phẩm trong đơn. |
| `product_id` | ID sản phẩm. |
| `seller_id` | ID người bán. |
| `shipping_limit_date` | Hạn chót người bán giao hàng cho đơn vị vận chuyển. |
| `price` | Giá sản phẩm. |
| `freight_value` | Phí vận chuyển. |

---

## 🧾 4. `olist_products_dataset`
**Mô tả:** Thông tin sản phẩm.  

| Cột | Mô tả |
|------|-------|
| `product_id` | ID sản phẩm. |
| `product_category_name` | Danh mục sản phẩm (Bồ Đào Nha). |
| `product_name_lenght` | Độ dài tên sản phẩm. |
| `product_description_lenght` | Độ dài mô tả sản phẩm. |
| `product_photos_qty` | Số lượng ảnh. |
| `product_weight_g` | Trọng lượng (gram). |
| `product_length_cm` | Chiều dài (cm). |
| `product_height_cm` | Chiều cao (cm). |
| `product_width_cm` | Chiều rộng (cm). |

---

## 🏪 5. `olist_sellers_dataset`
**Mô tả:** Thông tin người bán.  

| Cột | Mô tả |
|------|-------|
| `seller_id` | ID người bán. |
| `seller_zip_code_prefix` | Mã vùng. |
| `seller_city` | Thành phố người bán. |
| `seller_state` | Bang người bán. |

---

## 💳 6. `olist_order_payments_dataset`
**Mô tả:** Thông tin thanh toán.  

| Cột | Mô tả |
|------|-------|
| `order_id` | ID đơn hàng. |
| `payment_sequential` | Thứ tự thanh toán (nếu chia nhỏ). |
| `payment_type` | Phương thức thanh toán (credit_card, boleto, voucher...). |
| `payment_installments` | Số kỳ trả góp. |
| `payment_value` | Số tiền thanh toán. |

---

## ⭐ 7. `olist_order_reviews_dataset`
**Mô tả:** Đánh giá từ khách hàng.  

| Cột | Mô tả |
|------|-------|
| `review_id` | ID đánh giá. |
| `order_id` | ID đơn hàng. |
| `review_score` | Điểm đánh giá (1–5). |
| `review_comment_title` | Tiêu đề nhận xét. |
| `review_comment_message` | Nội dung nhận xét. |
| `review_creation_date` | Ngày đánh giá. |
| `review_answer_timestamp` | Ngày phản hồi. |

---

## 🌍 8. `olist_geolocation_dataset`
**Mô tả:** Thông tin địa lý.  

| Cột | Mô tả |
|------|-------|
| `geolocation_zip_code_prefix` | Mã vùng. |
| `geolocation_lat` | Vĩ độ. |
| `geolocation_lng` | Kinh độ. |
| `geolocation_city` | Thành phố. |
| `geolocation_state` | Bang. |

---

## 🗂️ 9. `product_category_name_translation`
**Mô tả:** Dịch tên danh mục sản phẩm.  

| Cột | Mô tả |
|------|-------|
| `product_category_name` | Danh mục tiếng Bồ Đào Nha. |
| `product_category_name_english` | Danh mục tiếng Anh. |
