//
//  Extension+UINib.swift
//  ExpenseTracker
//
//  Created by ThienTran on 21/8/25.
//

import Foundation
import UIKit

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
