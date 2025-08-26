//
//  CategoryViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 24/8/25.
//

import UIKit

protocol CategorySelectionDelegate: AnyObject {
  func didSelectCategory(_ category: Category)
}

class CategoryViewController: UIViewController {
  @IBOutlet weak var headerView: CustomHeaderView!
  @IBOutlet weak var tftSearch: UITextField!
  @IBOutlet weak var collectionView: UICollectionView!


  private let viewModel = CategoryViewModel()
  private var groupedCategories: [String: [Category]] = [:]
  private var sectionTitles: [String] = []
  weak var delegate: CategorySelectionDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    AppInitializer.preloadCategories()
    setupView()
    setupSearchBar()
    setupCollectionView()
    loadCategories()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  // MARK: - Setup

  private func setupView() {
    self.headerView.delegate = self
    headerView.configure(type: .leftTitle,
                         title: "Category",
                         leftImage: UIImage(systemName: "chevron.backward"))
  }

  private func setupSearchBar() {
    tftSearch.placeholder = "Tìm kiếm danh mục"
    tftSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
  }

  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 12
    let itemsPerRow: CGFloat = 4

    let totalPadding = padding * (itemsPerRow + 1)
    let availableWidth = view.frame.width - totalPadding
    let itemWidth = availableWidth / itemsPerRow

    layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
    layout.minimumInteritemSpacing = padding
    layout.minimumLineSpacing = padding
    layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40)

    collectionView.collectionViewLayout = layout
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white

    collectionView.register(UINib(nibName: "CategoryCell", bundle: nil),
                            forCellWithReuseIdentifier: "CategoryCell")

    collectionView.register(UINib(nibName: "CategoryHeaderView", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "CategoryHeaderView")
  }

  // MARK: - Data
  private func groupCategories(categories: [Category]) {
    let grouped = Dictionary(grouping: categories, by: { $0.type ?? "Khác" })
    groupedCategories = grouped
    let allTypes = ["Thu nhập", "Chi tiêu"]
    sectionTitles = allTypes.filter { grouped.keys.contains($0) }
    let others = grouped.keys.filter { !allTypes.contains($0) }.sorted()
    sectionTitles.append(contentsOf: others)
  }

  private func loadCategories() {
    let all = viewModel.loadCategories()
    groupCategories(categories: all)
    collectionView.reloadData()
  }

  @objc private func textFieldDidChange(_ textField: UITextField) {
    let searchText = textField.text ?? ""
    let filtered = viewModel.filterCategories(keyword: searchText)
    groupCategories(categories: filtered)
    collectionView.reloadData()
  }
}


extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sectionTitles.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let key = sectionTitles[section]
    return groupedCategories[key]?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    let key = sectionTitles[indexPath.section]
    if let category = groupedCategories[key]?[indexPath.row] {
      cell.configure(category: category)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: "CategoryHeaderView",
                                                                   for: indexPath) as! CategoryHeaderView
      header.titleLabel.text = sectionTitles[indexPath.section]
      return header
    }
    return UICollectionReusableView()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let key = sectionTitles[indexPath.section]
    if let category = groupedCategories[key]?[indexPath.row] {
      delegate?.didSelectCategory(category)   // gửi về cho AddAndEditExpenseViewController
      navigationController?.popViewController(animated: true) // quay lại
    }
  }
}

extension CategoryViewController: CustomHeaderViewDelegate {
  func didTapLeftButton(in header: UIView) {
    if let nav = navigationController {
      nav.popViewController(animated: true)
    } else {
      dismiss(animated: true, completion: nil)
    }
  }

  func didTapRightButton(in header: UIView) {

  }


}
