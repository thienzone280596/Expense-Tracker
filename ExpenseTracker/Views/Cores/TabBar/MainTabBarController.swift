//
//  MainViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 22/8/25.
//

import UIKit

class MainTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabs()
  }

  private func setupTabs() {
    // Tab 1: Expenses
          let homeVC = UINavigationController(rootViewController: HomeViewController())
          homeVC.tabBarItem = UITabBarItem(title: "Expenses",
                                               image: UIImage(systemName: "list.bullet"),
                                               selectedImage: UIImage(systemName: "list.bullet.rectangle.fill"))

          // Tab 2: Categories
          let searchVC = UINavigationController(rootViewController: SearchViewController())
    searchVC.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))

          // Tab 3: Profile
          let profileVC = UINavigationController(rootViewController: ProfileViewController())
          profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                              image: UIImage(systemName: "person.circle"),
                                              selectedImage: UIImage(systemName: "person.circle.fill"))

          viewControllers = [homeVC, searchVC, profileVC]

          tabBar.tintColor = .systemBlue
          tabBar.backgroundColor = .white
  }
}
