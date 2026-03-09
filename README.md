# okjshdk-E-commerce-Analytics-Project

Phân tích dataset Olist về hành vi và trải nghiệm khách hàng  nhằm **nâng cao chất lượng dịch vụ, đề xuất chiến lược giữ chân khách hàng, góp phần tăng doanh thu cho doanh nghiệp**.

---

## 1. RFM Customer Segmentation (SQL + Power BI + K-Means)
### Mục tiêu
Phân khúc khách hàng dựa trên **Recency – Frequency – Monetary** để xác định nhóm khách hàng tiềm năng và rủi ro.

### Insight
- Hai nhóm **Promising** và **Can’t Lose Them** chiếm **>80% doanh thu**.  
- Doanh thu tập trung ở khu vực **SP, RJ, MG**.  
- Nhóm **Promising** có tần suất mua thấp nhưng giá trị cao → cần remarketing.  
- Nhóm **Can’t Lose Them** có xu hướng giảm tương tác → cần chiến dịch tái kích hoạt.  
- Thanh toán qua **credit card** chiếm tỷ lệ cao nhất → nên có chính sách ưu đãi thẻ.

### Mô hình K-Means
- Sử dụng thuật toán K-Means để phân khúc khách hàng.
- Chuẩn hóa RFM, chọn **k=11** bằng Elbow Method và xác định nhóm theo hành vi.  

---

## 2. Customer Experience Analysis (SQL + Power BI)
### Mục tiêu
Phân tích trải nghiệm của khách hàng nhằm cải thiện nâng cao chất lượng dịch vụ.

### Insight
- **Điểm đánh giá giảm mạnh khi giao hàng trễ:**  
  Đơn trễ >30% có review_score ≤ 2.   
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
