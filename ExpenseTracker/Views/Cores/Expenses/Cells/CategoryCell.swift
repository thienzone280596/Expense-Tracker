//
//  CategoryCell.swift
//  ExpenseTracker
//
//  Created by ThienTran on 25/8/25.
//

import UIKit

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

  private func setupUI() {
      imageView.contentMode = .scaleAspectFit

      titleLabel.textAlignment = .center
      titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      titleLabel.numberOfLines = 2
      titleLabel.lineBreakMode = .byWordWrapping
  }


  func configure(category: Category) {
      titleLabel.text = category.name

      if let imageName = category.image {
          imageView.image = UIImage(named: imageName)
      } else {
          imageView.image = UIImage(systemName: "questionmark.circle")
      }
  }

}

