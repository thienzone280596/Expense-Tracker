//
//  HomeHeaderView.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//

import UIKit

protocol HomeHeaderDelegate: AnyObject {
  func didTapNotification()
}

class HomeHeaderView: UIView {

  @IBOutlet var containerView: UIView!
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var imgUser: UIImageView!
  @IBOutlet weak var lblHello: UILabel!
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var btnNotification: UIButton!

  weak var delegate: HomeHeaderDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    customInit()
  }

  fileprivate func customInit() {
    Bundle.main.loadNibNamed("HomeHeaderView", owner: self, options: nil)
    addSubview(containerView)
    containerView.frame = bounds
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.imgUser.layer.cornerRadius = self.imgUser.frame.height / 2
    self.lblHello.font = AppFonts.Afacad_Medium.withSize(24)
    self.lblHello.textColor = AppColors.k000000
    self.lblName.font = AppFonts.Afacad_Medium.withSize(14)
    self.lblName.textColor = AppColors.kCCCCCC
  }



  @IBAction func actionNotification(_ sender: Any) {

  }
}
