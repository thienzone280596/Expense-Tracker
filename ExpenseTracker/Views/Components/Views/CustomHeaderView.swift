//
//  CustomHeaderView.swift
//  ExpenseTracker
//
//  Created by ThienTran on 25/8/25.
//

import UIKit


protocol CustomHeaderViewDelegate: AnyObject {
    func didTapLeftButton(in header: UIView)
    func didTapRightButton(in header: UIView)
}


enum HeaderType {
    case left
    case leftTitle
    case right
    case rightTitle
    case full
    case titleOnly
}


class CustomHeaderView: UIView {
  @IBOutlet var containerView: UIView!
   @IBOutlet weak var leftButton: UIButton!
   @IBOutlet weak var rightButton: UIButton!
   @IBOutlet weak var titleLabel: UILabel!


    weak var delegate: CustomHeaderViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
      commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
      commonInit()
    }



   private func commonInit() {
       Bundle.main.loadNibNamed("CustomHeaderView", owner: self, options: nil)
       addSubview(containerView)
       containerView.frame = bounds
       containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

       setupUI()
   }

   private func setupUI() {
       titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
       titleLabel.textColor = .black

       leftButton.tintColor = .black
       rightButton.tintColor = .black
   }

   // MARK: - Configure
   func configure(type: HeaderType,
                  background: UIColor = .white,
                  title: String? = nil,
                  leftImage: UIImage? = nil,
                  rightImage: UIImage? = nil) {

      containerView.backgroundColor = background
       leftButton.isHidden = true
       rightButton.isHidden = true
       titleLabel.isHidden = true

       titleLabel.text = title

       if let leftImage = leftImage {
           leftButton.setImage(leftImage, for: .normal)
       }
       if let rightImage = rightImage {
           rightButton.setImage(rightImage, for: .normal)
       }

       switch type {
       case .left:
           leftButton.isHidden = false
       case .leftTitle:
           leftButton.isHidden = false
           titleLabel.isHidden = false
       case .right:
           rightButton.isHidden = false
       case .rightTitle:
           rightButton.isHidden = false
           titleLabel.isHidden = false
       case .full:
           leftButton.isHidden = false
           rightButton.isHidden = false
           titleLabel.isHidden = false
       case .titleOnly:
           titleLabel.isHidden = false
       }
   }

   // MARK: - Actions
   @IBAction func leftButtonTapped(_ sender: UIButton) {
       delegate?.didTapLeftButton(in: self)
   }

   @IBAction func rightButtonTapped(_ sender: UIButton) {
       delegate?.didTapRightButton(in: self)
   }
}
