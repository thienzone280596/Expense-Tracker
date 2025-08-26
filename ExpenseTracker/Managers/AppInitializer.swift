//
//  AppInitializer.swift
//  ExpenseTracker
//
//  Created by ThienTran on 24/8/25.
//

class AppInitializer {
    static func preloadCategories() {
        let service = CategoryService()
        if service.getAllCategories().isEmpty {
            // Income
            service.addCategory(name: "Lương", type: "income", image: "salary")
            service.addCategory(name: "Thưởng", type: "income", image: "medal")
            service.addCategory(name: "Được tặng", type: "income", image: "pay")
            service.addCategory(name: "Tiền khác", type: "income", image: "savings")

            // Ăn uống
            service.addCategory(name: "Cafe", type: "Food", image: "coffee-cup")
            service.addCategory(name: "Ăn Tiệm", type: "Food", image: "restaurant")
            service.addCategory(name: "Đi chợ/siêu thị", type: "Food", image: "grocery-cart")
            service.addCategory(name: "Ăn sáng", type: "Food", image: "cutlery")
            service.addCategory(name: "Ăn trưa", type: "Food", image: "bibimbap")
            service.addCategory(name: "Ăn tối", type: "Food", image: "christmas-dinner")
          //dịch vụ sinnh hoạt
          service.addCategory(name: "Internet", type: "Living Services", image: "cloud-computing")
          service.addCategory(name: "Nước", type: "Living Services", image: "water-tap")
          service.addCategory(name: "Điện", type: "Living Services", image: "electrical-service")
          service.addCategory(name: "Điện thoại di động", type: "Living Services", image: "cellphone")
          service.addCategory(name: "Gas", type: "living services", image: "gas-cylinder")
          service.addCategory(name: "Giúp việc", type: "living services", image: "healthcare-and-medical")
          service.addCategory(name: "Truyền hình", type: "living services", image: "television")
          // đi lại
          service.addCategory(name: "Xăng xe", type: "Vehicle Cost", image: "gas-station")
          service.addCategory(name: "Bảo hiểm xe", type: "Vehicle Cost", image: "insurance")
          service.addCategory(name: "Gửi xe", type: "Vehicle Cost", image: "parking-lot")
          service.addCategory(name: "Rửa xe", type: "Vehicle Cost", image: "car-wash")
          service.addCategory(name: "Sửa xe", type: "Vehicle Cost", image: "car")
          service.addCategory(name: "Taxi", type: "Vehicle Cost", image: "taxi")
          // Trang phục
          service.addCategory(name: "Quần áo", type: "skin", image: "brand")
          service.addCategory(name: "Giày dép", type: "skin", image: "shoes")
          service.addCategory(name: "Phụ kiện", type: "skin", image: "fashion-accessories")
          //con cái
          service.addCategory(name: "Học phí", type: "Children", image: "tuition-fees")
          service.addCategory(name: "Sách vở", type: "Children", image: "book")
          service.addCategory(name: "Sữa", type: "Children", image: "milk")
          service.addCategory(name: "Tiêu vặt", type: "Children", image: "wallet")
          service.addCategory(name: "Đồ chới", type: "Children", image: "toys")
          //Hưởng thụ
          service.addCategory(name: "Vui chơi giải trí", type: "enjoy", image: "cinema")
          service.addCategory(name: "Du lịch", type: "enjoy", image: "transport")
          service.addCategory(name: "Làm đẹp", type: "enjoy", image: "cosmetics")
          service.addCategory(name: "Mỹ phẩm", type: "enjoy", image: "makeup-pouch")
          service.addCategory(name: "Phim ảnh ca nhạc", type: "enjoy", image: "movie")
          //Hiếu hỉ
          service.addCategory(name: "Biếu tặng", type: "Party costs", image: "giftbox")
          service.addCategory(name: "Cưới xin", type: "Party costs", image: "wedding-ring")
          service.addCategory(name: "Ma chay", type: "Party costs", image: "lotus-flower")
          service.addCategory(name: "Thăm hỏi", type: "Party costs", image: "fever")
          //Nhà cửa
          service.addCategory(name: "Mua sắm đồ đạc", type: "House", image: "locker")
          service.addCategory(name: "Sửa chửa nhà cửa", type: "House", image: "house")
          service.addCategory(name: "Thuê nhà", type: "House", image: "lease")
          //sức khoẻ
          service.addCategory(name: "Khám chữa bệnh", type: "Health", image: "advice")
          service.addCategory(name: "Thuốc men", type: "Health", image: "syringe")
          service.addCategory(name: "Thể thao", type: "Health", image: "sports")
        }
    }
}
