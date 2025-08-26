//
//  AppFont.swift
//  ExpenseTracker
//
//  Created by ThienTran on 20/8/25.
//

import UIKit

enum AppFonts: String {
    case Afacad = "Afacad-Regular"
    case Afacad_Italic = "Afacad-Italic"
    case Afacad_Medium = "Afacad-Medium"
    case Afacad_Bold = "Afacad-Bold"
    case Afacad_SemiBold = "Afacad-SemiBold"


}

extension AppFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }
}
