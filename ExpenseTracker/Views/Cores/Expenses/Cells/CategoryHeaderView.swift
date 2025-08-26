//
//  CategoryHeaderView.swift
//  ExpenseTracker
//
//  Created by ThienTran on 25/8/25.
//

import UIKit

class CategoryHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .darkGray
    }
}

