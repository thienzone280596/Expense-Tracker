//
//  SearchViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//

import UIKit

class SearchViewController: UIViewController {

  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  

  var viewModel = ExpenseViewModel()
  var filteredExpenses: [Expense] = []
  var userID: UUID? { SessionManager.shared.currentUserID }

  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white

      lblTitle.text = "Search Expense"
      setupSearchTextField()
      setupTableView()
      loadExpenses()
    self.hideKeyboardWhenTappedAround()
  }

  private func setupSearchTextField() {
      searchTextField.delegate = self
      searchTextField.placeholder = "Tìm kiếm chi tiêu..."

      searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }

  private func setupTableView() {
      tableView.dataSource = self
      tableView.delegate = self
      let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
  }

  private func loadExpenses() {
      guard let userID = userID else { return }
      viewModel.onExpensesUpdated = { [weak self] in
          guard let self = self else { return }
          self.filteredExpenses = self.viewModel.expenses
          self.tableView.reloadData()
      }
      viewModel.loadExpenses(for: userID)
  }

  @objc private func textFieldDidChange(_ textField: UITextField) {
      filterExpenses(for: textField.text ?? "")
  }

  private func filterExpenses(for searchText: String) {
      if searchText.isEmpty {
          filteredExpenses = viewModel.expenses
      } else {
          filteredExpenses = viewModel.expenses.filter {
            $0.title?.lowercased().contains(searchText.lowercased()) ?? false
              || ($0.category?.lowercased().contains(searchText.lowercased()) ?? false)
          }
      }
      tableView.reloadData()
  }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredExpenses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ExpenseTableViewCell",
            for: indexPath
        ) as? ExpenseTableViewCell else {
            return UITableViewCell()
        }
        let expense = filteredExpenses[indexPath.row]
        cell.configure(with: expense)
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
