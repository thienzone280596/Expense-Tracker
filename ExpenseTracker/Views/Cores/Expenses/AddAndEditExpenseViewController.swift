//
//  ExpenseViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 24/8/25.
//

import UIKit

class AddAndEditExpenseViewController: UIViewController {
  @IBOutlet weak var headerView: CustomHeaderView!
  @IBOutlet weak var previewContentView: UIView!
  @IBOutlet weak var categoryContentView: UIView!
  @IBOutlet weak var titleContentView: UIView!
  @IBOutlet weak var amountContentView: UIView!
  @IBOutlet weak var locationContentView: UIView!
  @IBOutlet weak var noteContentView: UIView!
  @IBOutlet weak var lblPreviewTitle: UILabel!
  @IBOutlet weak var lblPreviewNote: UILabel!
  @IBOutlet weak var lblPreviewDate: UILabel!
  @IBOutlet weak var lblPreviewLocation: UILabel!

  @IBOutlet weak var vExpense: UIView!
  @IBOutlet weak var lblPreviewAmount: UILabel!
  @IBOutlet weak var txtTitle: UITextField!
  @IBOutlet weak var txtAmount: UITextField!

  @IBOutlet weak var viewDate: UIView!
  @IBOutlet weak var tvNote: UITextView!
  @IBOutlet weak var txtLocation: UITextField!
  @IBOutlet weak var btnAddCategory: UIButton!
  @IBOutlet weak var imgCategory: UIImageView!
  @IBOutlet weak var titleCateogry: UILabel!
  @IBOutlet weak var btnSelectDate: UIButton!
  @IBOutlet weak var lblSelectDate: UILabel!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var imgPreview: UIImageView!
  @IBOutlet weak var btnConfirm: ButtonView!

  @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
  var viewModel = ExpenseViewModel()
  var category: Category?
  var editingExpense: Expense?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupTextFields()

    if let expense = editingExpense {
      setupForEditing(expense)
    }
    self.hideKeyboardWhenTappedAround()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  private func setupUI() {
    previewContentView.layer.cornerRadius = 8
    categoryContentView.layer.cornerRadius = 8
    titleContentView.layer.cornerRadius = 8
    amountContentView.layer.cornerRadius = 8
    locationContentView.layer.cornerRadius = 8
    noteContentView.layer.cornerRadius = 8
    btnConfirm.layer.cornerRadius = btnConfirm.frame.height / 2
    vExpense.layer.cornerRadius = 8
    viewDate.layer.cornerRadius = 8
    lblPreviewTitle.numberOfLines = 1
    lblPreviewNote.numberOfLines = 1
    lblPreviewDate.numberOfLines = 1
    lblPreviewLocation.numberOfLines = 1
    txtAmount.keyboardType = .numberPad
    imgCategory.alpha = 0
    titleCateogry.alpha = 0
    txtAmount.delegate = self

    self.navigationController?.isNavigationBarHidden = true
    self.btnConfirm.delegate = self
    btnConfirm.setText(str: "Xác nhận", isEnable: false)

    headerView.configure(type: .leftTitle,
                         background: AppColors.kEAEAEC!,
                         title: "Category",
                         leftImage: UIImage(systemName: "chevron.backward"))
    self.headerView.delegate = self
    segmentControl.removeAllSegments()
    segmentControl.insertSegment(withTitle: "Thu nhập", at: 0, animated: false)
    segmentControl.insertSegment(withTitle: "Chi tiêu", at: 1, animated: false)
    segmentControl.selectedSegmentIndex = 0

    segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
    segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)

    segmentControl.backgroundColor = .white
    segmentControl.selectedSegmentTintColor = .systemBlue
    segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)

  }

  @objc func keyboardWillShow(notification: Notification) {
    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
      print("Keyboard height: \(keyboardFrame.height)")
      self.view.frame.origin.y = -keyboardFrame.height / 2
    }
  }


  @objc func keyboardWillHide(notification: Notification) {
    self.view.frame.origin.y = 0
  }

  private func setupTextFields() {
    txtTitle.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    txtAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    txtLocation.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    tvNote.delegate = self
  }

  @objc private func textFieldDidChange(_ textField: UITextField) {
    updatePreview()
    validateInputs()
  }

  @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      print("Đã chọn Thu nhập")
      lblPreviewAmount.textColor = .systemGreen
    } else {
      print("Đã chọn Chi tiêu")
      lblPreviewAmount.textColor = .systemRed
    }
  }


  private func updatePreview() {
    lblPreviewTitle.text = txtTitle.text?.isEmpty == false ? txtTitle.text : "Chưa nhập tiêu đề"
    lblPreviewAmount.text = txtAmount.text?.isEmpty == false ? txtAmount.text : "0"
    lblPreviewNote.text = tvNote.text?.isEmpty == false ? tvNote.text : "Chưa có ghi chú"
    lblPreviewLocation.text = txtLocation.text?.isEmpty == false ? txtLocation.text : "Chưa có địa điểm"

    if let amountText = txtAmount.text, !amountText.isEmpty {
      lblPreviewAmount.text = "\(amountText) VND"
    } else {
      lblPreviewAmount.text = "0 VND"
    }
  }

  private func updateCategoryUI() {
    imgCategory.alpha = 1
    titleCateogry.alpha = 1
    guard let category = category else { return }
    titleCateogry.text = category.name
    if let imageName = category.image {
      imgCategory.image = UIImage(named: imageName)
      imgPreview.image = UIImage(named: imageName)

    } else {
      imgCategory.image = nil
      imgPreview.image = nil
    }
  }

  private func showDatePicker() {
    let alert = UIAlertController(title: "Chọn ngày", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)

    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 20, width: alert.view.bounds.width - 20, height: 200))
    datePicker.datePickerMode = .date
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }

    alert.view.addSubview(datePicker)

    let okAction = UIAlertAction(title: "Xong", style: .default) { _ in
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      let selectedDate = formatter.string(from: datePicker.date)

      self.lblPreviewDate.text = selectedDate
      self.lblSelectDate.text = selectedDate
    }

    let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)

    alert.addAction(okAction)
    alert.addAction(cancelAction)

    present(alert, animated: true, completion: nil)
  }

  private func saveExpense() {
    guard let title = txtTitle.text, !title.isEmpty else { return }
    guard let amountText = txtAmount.text?
            .replacingOccurrences(of: ",", with: ""),
          let amount = Double(amountText), amount > 0 else { return }
    guard let userID = SessionManager.shared.currentUserID else {
      print("Không tìm thấy userID khi lưu expense")
      return
    }
    guard let image = category?.image else { return }

    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    var date = Date()
    if let dateText = lblSelectDate.text, !dateText.isEmpty {
      date = formatter.date(from: dateText) ?? Date()
    }

    let type = segmentControl.selectedSegmentIndex == 0 ? "income" : "expense"
    let categoryName = category?.name ?? "Khác"

    if let expense = editingExpense {
      // Update
      viewModel.updateExpense(
        expense,
        title: title,
        amount: amount,
        date: date,
        category: categoryName,
        image: image,
        type: type,
        location: txtLocation.text,
        notes: tvNote.text,
        userID: userID
      )
    } else {
      // Add
      viewModel.addExpense(
        title: title,
        amount: amount,
        date: date,
        category: categoryName,
        image: image,
        type: type,
        location: txtLocation.text,
        notes: tvNote.text,
        userID: userID
      )
    }
    navigationController?.popViewController(animated: true)
  }

  private func setupForEditing(_ expense: Expense) {
      // Title
      txtTitle.text = expense.title
      lblPreviewTitle.text = expense.title?.isEmpty == false ? expense.title : "Chưa nhập tiêu đề"

      // Amount với format
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.groupingSeparator = ","
      formatter.maximumFractionDigits = 0
      if let formattedAmount = formatter.string(from: NSNumber(value: expense.amount)) {
          txtAmount.text = formattedAmount
          lblPreviewAmount.text = "\(formattedAmount) VND"
      } else {
          txtAmount.text = "\(expense.amount)"
          lblPreviewAmount.text = "\(expense.amount) VND"
      }

      // Location
      txtLocation.text = expense.location
      lblPreviewLocation.text = expense.location?.isEmpty == false ? expense.location : "Chưa có địa điểm"

      // Note
      tvNote.text = expense.notes
      lblPreviewNote.text = expense.notes?.isEmpty == false ? expense.notes : "Chưa có ghi chú"

      // Date
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .medium
      dateFormatter.timeStyle = .none
      if let date = expense.date {
          let dateString = dateFormatter.string(from: date)
          lblSelectDate.text = dateString
          lblPreviewDate.text = dateString
      }

      // Category: fetch từ Core Data
      if let categoryName = expense.category {
          let service = CategoryService()
          let categories = service.getAllCategories()
          if let matchedCategory = categories.first(where: { $0.name == categoryName }) {
              self.category = matchedCategory
              titleCateogry.text = matchedCategory.name
              if let imageName = matchedCategory.image {
                  imgCategory.image = UIImage(named: imageName)
                  imgPreview.image = UIImage(named: imageName)
              }
              imgCategory.alpha = 1
              titleCateogry.alpha = 1
          } else {
              // Không tìm thấy category → ẩn UI
              self.category = nil
              imgCategory.alpha = 0
              titleCateogry.alpha = 0
          }
      }

      // Type (income / expense)
      segmentControl.selectedSegmentIndex = (expense.type == "income") ? 0 : 1
      segmentValueChanged(segmentControl) // cập nhật màu amount

      // Confirm button
      btnConfirm.setText(str: "Cập nhật", isEnable: true)
  }


  private func validateInputs() {
      let isTitleValid = !(txtTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)

      let rawAmountText = txtAmount.text?.replacingOccurrences(of: ",", with: "") ?? ""
      let amount = Double(rawAmountText) ?? 0
      let isAmountValid = amount > 0
      let isCategoryValid = (category != nil) || (editingExpense != nil)
      if isTitleValid && isAmountValid && isCategoryValid {
          btnConfirm.enableButton()
      } else {
          btnConfirm.disableButton()
      }
  }

  @IBAction func actionAddCategory(_ sender: Any) {
    let categoryVC = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
       categoryVC.delegate = self
       navigationController?.pushViewController(categoryVC, animated: true)
  }

  @IBAction func actionSelectDate(_ sender: Any) {
    showDatePicker()
  }

}


extension AddAndEditExpenseViewController: CustomHeaderViewDelegate {
  func didTapLeftButton(in header: UIView) {
    navigationController?.popViewController(animated: true)
  }

  func didTapRightButton(in header: UIView) {

  }
}

extension AddAndEditExpenseViewController: CategorySelectionDelegate {
  func didSelectCategory(_ category: Category) {
      imgCategory.alpha = 1
      titleCateogry.alpha = 1
      self.category = category
      titleCateogry.text = category.name
      if let imageName = category.image, let img = UIImage(named: imageName) {
          imgCategory.image = img
          imgPreview.image = img
      } else {
          imgCategory.image = nil
          imgPreview.image = nil
      }

      validateInputs()
    }
}

extension AddAndEditExpenseViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    updatePreview()
  }
}

extension AddAndEditExpenseViewController:ButtonViewDelegate {
  func onTapButton(sender: UIView) {
    saveExpense()
  }
}

extension AddAndEditExpenseViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
      if textField == txtAmount {

          let currentText = textField.text ?? ""
          let newString = (currentText as NSString).replacingCharacters(in: range, with: string)

          let digits = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
          guard let number = Int(digits) else {
              textField.text = ""
              return false
          }

          let formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          formatter.groupingSeparator = ","
          formatter.maximumFractionDigits = 0

          if let formatted = formatter.string(from: NSNumber(value: number)) {
              textField.text = formatted
          }

          return false
      }
      return true
  }
}


