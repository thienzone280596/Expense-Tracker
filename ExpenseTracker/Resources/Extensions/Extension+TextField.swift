//
//  Extension+TextField.swift
//  ExpenseTracker
//
//  Created by ThienTran on 21/8/25.
//

import UIKit

extension UITextField{
    func setCursor(position: Int) {
            let position = self.position(from: beginningOfDocument, offset: position)!
            selectedTextRange = textRange(from: position, to: position)
    }
}
