//
//  Extension+UIWindow.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import UIKit

extension UIWindow {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated else { self.rootViewController = vc; self.makeKeyAndVisible(); return }
        let snapshot = self.snapshotView(afterScreenUpdates: true) ?? UIView()
        vc.view.addSubview(snapshot)
        self.rootViewController = vc
        self.makeKeyAndVisible()
        UIView.transition(with: snapshot, duration: 0.3, options: .transitionCrossDissolve, animations: {
            snapshot.alpha = 0
        }, completion: { _ in snapshot.removeFromSuperview() })
    }
}
