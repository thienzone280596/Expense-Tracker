# 📊 ExpenseTracker

Ứng dụng quản lý thu chi cá nhân được viết bằng **Swift + Core Data**.  
Hỗ trợ đăng ký / đăng nhập, quản lý chi tiêu/thu nhập, tìm kiếm, và thống kê cơ bản.

---

## 🚀 Tính năng chính

### 🔐 Xác thực (Authentication)
- **Đăng ký (Register)**: Người dùng có thể tạo tài khoản mới với thông tin cơ bản (email, mật khẩu, tên hiển thị).  
- **Đăng nhập (Login)**: Đăng nhập vào ứng dụng với tài khoản đã đăng ký.  
- **Lưu trạng thái đăng nhập**: Giữ session bằng `UserDefaults` để không cần đăng nhập lại mỗi lần mở app.  

---

### 💰 Quản lý Thu chi (Expense Management)
- **Thêm chi tiêu / thu nhập (Add Expense/Income)**  
  - Nhập **tiêu đề**, **số tiền**, **danh mục**, **ngày**, **ghi chú**, **địa điểm**, **hình ảnh**.  
  - Tự động format số tiền theo thời gian thực (ví dụ: `1,000 → 10,000 → 100,000`).  
- **Chỉnh sửa (Edit Expense/Income)**  
  - Cập nhật thông tin khoản chi tiêu/thu nhập đã tạo.  
- **Xóa (Delete)**  
  - Xóa một khoản chi tiêu/thu nhập bất kỳ.  
- **Danh sách Expense**  
  - Hiển thị toàn bộ chi tiêu/thu nhập theo ngày.  
  - Tích hợp **UISearchBar / TextField** để tìm kiếm theo **tiêu đề**, **ghi chú**, hoặc **danh mục**.  

---

### 🗂️ Quản lý Danh mục (Category Management)
- Danh mục mặc định: `Thu nhập`, `Chi tiêu` (có icon).  
- Người dùng có thể **thêm danh mục mới** (ví dụ: Ăn uống, Giải trí, Mua sắm).  
- Hiển thị bằng `UICollectionView`, phân nhóm theo **Thu nhập / Chi tiêu**.  
- Hỗ trợ tìm kiếm danh mục theo từ khóa.  

---

### 🔍 Tìm kiếm & Lọc (Search & Filter)
- Tìm kiếm chi tiêu theo **tên**, **Category**
- Lọc theo danh mục hoặc khoảng thời gian.  

---

### 🗑️ Xóa (Delete)
- Vuốt sang trái trong danh sách để xóa một khoản chi tiêu.  
- Xác nhận trước khi xóa để tránh thao tác nhầm.  

---

## 🛠️ Công nghệ sử dụng
- **Swift 5**
- **UIKit + XIB**
- **Core Data** (lưu trữ dữ liệu cục bộ)
- **MVVM (ViewModel)** cho quản lý dữ liệu
- **AutoLayout (NSLayoutConstraint)** để tương thích đa màn hình

---

## 📂 Cấu trúc thư mục

