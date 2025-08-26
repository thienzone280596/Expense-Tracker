//
//  HomeViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
  @IBOutlet weak var headerView: HomeHeaderView!
  
  private let viewModel = ExpenseViewModel()
  
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.dataSource = self
    table.delegate = self
    let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
    table.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
    return table
  }()
  
  private lazy var emptyView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    let label = UILabel()
    label.text = "No expenses yet"
    label.textAlignment = .center
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(label)
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    return view
  }()
  
  private lazy var floatingButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .systemBlue
    button.tintColor = .white
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.layer.cornerRadius = 28
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOpacity = 0.3
    button.layer.shadowOffset = CGSize(width: 2, height: 2)
    button.layer.shadowRadius = 4
    button.addTarget(self, action: #selector(didTapAddExpense), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    if let userID = SessionManager.shared.currentUserID {
            viewModel.loadExpenses(for: userID)
        }
    }

  private func setupUI() {
    view.addSubview(tableView)
    view.addSubview(emptyView)
    view.addSubview(floatingButton)

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      floatingButton.widthAnchor.constraint(equalToConstant: 56),
      floatingButton.heightAnchor.constraint(equalToConstant: 56),
      floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
      floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
    ])
    
    bindViewModel()
  }
}

extension HomeViewController {
  private func bindViewModel() {
    viewModel.onExpensesUpdated = { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.updateUI()
      }
    }
    
    if let userID = SessionManager.shared.currentUserID {
      viewModel.loadExpenses(for: userID)
    }
  }
  
  private func updateUI() {
    print("Expenses count: \(viewModel.expenses)")
    if viewModel.expenses.isEmpty {
      tableView.isHidden = true
      emptyView.isHidden = false
    } else {
      tableView.isHidden = false
      emptyView.isHidden = true
      tableView.reloadData()
    }
  }
  
  @objc private func didTapAddExpense() {
       let addVC = AddAndEditExpenseViewController()
        addVC.hidesBottomBarWhenPushed = true 
       navigationController?.pushViewController(addVC, animated: true)
  }



}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.expenses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let expense = viewModel.expenses[indexPath.row]
   guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell", for: indexPath) as? ExpenseTableViewCell else  {
      return UITableViewCell()
    }
    cell.configure(with: expense)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let expense = viewModel.expenses[indexPath.row]
    let addEditVC = AddAndEditExpenseViewController()
    addEditVC.editingExpense = expense 
    navigationController?.pushViewController(addEditVC, animated: true)

  }

  func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Xoá") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let expense = self.viewModel.expenses[indexPath.row]

            if let userID = SessionManager.shared.currentUserID {
                self.viewModel.deleteExpense(expense, userID: userID)
            }
            completion(true)
        }

        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
