//
//  ExpenxeTableViewCell.swift
//  ExpenseTracker
//
//  Created by ThienTran on 26/8/25.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

  @IBOutlet weak var imgCategory: UIImageView!

  @IBOutlet weak var title: UILabel!

  @IBOutlet weak var lblNote: UILabel!

  @IBOutlet weak var lblAmount: UILabel!

  @IBOutlet weak var lblDate: UILabel!

  @IBOutlet weak var lblLocation: UILabel!

  @IBOutlet weak var imgExpense: UIImageView!


  override func awakeFromNib() {
    super.awakeFromNib()
    imgCategory.clipsToBounds = true
    imgExpense.clipsToBounds = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imgCategory.layer.cornerRadius = imgCategory.frame.width / 2
    imgExpense.layer.cornerRadius = imgExpense.frame.width / 2
  }

  func configure(with expense: Expense) {
    title.text = expense.title
    lblNote.text = expense.notes ?? "Không có ghi chú"
    lblLocation.text = expense.location ?? "Không có địa điểm"

    // Format số tiền
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "VN"
    if let amountText = formatter.string(from: NSNumber(value: expense.amount)) {
      lblAmount.text = amountText
    } else {
      lblAmount.text = "\(expense.amount)"
    }

    lblAmount.textColor = expense.type == "income" ? .systemGreen : .systemRed

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    lblDate.text = dateFormatter.string(from: expense.date ?? Date())

    // Ảnh category
    if let image = expense.image {
      imgCategory.image = UIImage(named: image)
    } else {
      imgCategory.image = UIImage(named: "category_default")
    }

    if expense.type == "income" {
      imgExpense.image = UIImage(named: "increase")
    } else {
      imgExpense.image = UIImage(named: "decrease")
    }
  }
}
