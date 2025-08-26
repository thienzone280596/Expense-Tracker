//
//  ButtonView.swift
//  ExpenseTracker
//
//  Created by ThienTran on 21/8/25.
//

import UIKit


protocol ButtonViewDelegate: AnyObject {
  func onTapButton(sender: UIView)
}

class ButtonView: UIView {
  enum WEButtonState: Int {
    case Enable
    case Disable
  }
  
  @IBOutlet var containerView: UIView!
  @IBOutlet weak var vContent: UIView!
  @IBOutlet weak var btnConfirm: UIButton!
  
  weak var delegate: ButtonViewDelegate?
  private var onTouch: Bool = false
  private var state: WEButtonState = .Enable
  
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
    Bundle.main.loadNibNamed("ButtonView", owner: self, options: nil)
    addSubview(containerView)
    containerView.frame = bounds
    containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.vContent.backgroundColor = .clear
    self.btnConfirm.backgroundColor = .clear
    containerView.layer.cornerRadius = 20
    self.btnConfirm.layer.cornerRadius = 20
    self.vContent.layer.cornerRadius = 20
    self.btnConfirm.titleLabel?.textColor = AppColors.kFFFFFF
    self.btnConfirm.titleLabel?.font = AppFonts.Afacad_Medium.withSize(16)
  }
  
  func setTitlteFont(font: UIFont) {
    self.btnConfirm.titleLabel?.font = font
  }
  
  func setTitleColor(color: UIColor?) {
    self.btnConfirm.setTitleColor(color, for: .normal)
  }
  
  func setText(str: String, isEnable: Bool = true, isDisableInteractable: Bool = false, titleColor: UIColor? = AppColors.kFFFFFF) {

    self.btnConfirm.setTitle(str, for: .normal)
    if isEnable {
      enableButton()
    } else {
      disableButton(isInteracable: isDisableInteractable, titleColor: titleColor)
    }
  }
  
  func enableButton() {
      self.vContent.backgroundColor = AppColors.k0066D8
      self.btnConfirm.setTitleColor(.white, for: .normal)
      self.btnConfirm.titleLabel?.font = AppFonts.Afacad_Medium.withSize(16)
      self.isUserInteractionEnabled = true
  }

  func disableButton(isInteracable: Bool = false, titleColor: UIColor? = AppColors.kFFFFFF) {
      self.vContent.backgroundColor = AppColors.k677687
      self.btnConfirm.setTitleColor(titleColor, for: .normal)
      self.btnConfirm.titleLabel?.font = AppFonts.Afacad_Medium.withSize(16)
      self.isUserInteractionEnabled = isInteracable
  }

  @IBAction func actionTapButton(_ sender: Any) {
    if let delegate = self.delegate {
      delegate.onTapButton(sender: self)
    }
  }
}
