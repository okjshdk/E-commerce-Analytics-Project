# okjshdk-E-commerce-Analytics-Project

Phân tích dữ liệu hành vi và trải nghiệm khách hàng từ hệ thống Olist nhằm **tối ưu chiến lược giữ chân, cải thiện trải nghiệm và tăng doanh thu**.

---

## 1. RFM Customer Segmentation (SQL + Power BI + K-Means)
### Mục tiêu
Phân khúc khách hàng dựa trên **Recency – Frequency – Monetary** để xác định nhóm tiềm năng và rủi ro.

### Insight chính
- Hai nhóm **Promising** và **Can’t Lose Them** chiếm **>80% doanh thu**.  
- Doanh thu tập trung ở khu vực **SP, RJ, MG**.  
- **Promising** có tần suất mua thấp nhưng giá trị cao → cần remarketing.  
- **Can’t Lose Them** có xu hướng giảm tương tác → cần chiến dịch tái kích hoạt.  
- Thanh toán qua **credit card** chiếm tỷ lệ cao nhất → nên tập trung ưu đãi thẻ.

### Mô hình K-Means
- Chuẩn hóa RFM, chọn **k=11** bằng Elbow Method.  
- Đặt tên nhóm theo hành vi (Champions, Loyal, Promising, At Risk,...).  

---

## 2. Customer Experience Analysis (SQL + Power BI)
### Insight chính
- **Điểm đánh giá giảm mạnh khi giao hàng trễ:**  
  Đơn trễ >30% có review_score ≤ 2.  
- **Delivered orders** đạt điểm cao nhất (4.16), các trạng thái khác <2.0.  
- **Các bang có điểm thấp:** RR, MA, AL, BA → cần cải thiện logistics.  
- **Danh mục sản phẩm điểm thấp:** office_furniture, male_fashion, computers_accessories → cần kiểm soát chất lượng.  
→ **Yếu tố ảnh hưởng lớn nhất:** thời gian giao hàng.

---

## 3. Churn Prediction Model (Random Forest)
### Mục tiêu
Dự đoán khả năng khách hàng rời bỏ để chủ động chăm sóc, giữ chân.

### ⚙️ Hiệu quả mô hình
| Metric | Value |
|:--------|:------:|
| Accuracy | **81.1%** |
| ROC-AUC | **89.1%** |
| Precision (Churn) | **81%** |
| Recall (Churn) | **89%** |

→ Mô hình giúp **phát hiện sớm 89% khách hàng có nguy cơ rời bỏ**, hỗ trợ tối ưu chiến lược **chăm sóc và giữ chân**.

---

## Kết quả tổng hợp
- **Xác định nhóm khách hàng trọng điểm & rủi ro cao.**  
- **Phát hiện yếu tố ảnh hưởng trải nghiệm:** thời gian giao hàng & vùng địa lý.  
- **Cải thiện hiệu quả chiến dịch remarketing**, hướng tới **giảm chi phí và tăng retention rate**.
