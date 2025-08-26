//
//  ProfileViewController.swift
//  ExpenseTracker
//
//  Created by ThienTran on 23/8/25.
//

import UIKit

class ProfileViewController: UIViewController {
    private let viewModel = AuthViewModel()

    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "person.circle") // ảnh mặc định
        iv.tintColor = .gray
        return iv
    }()

    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let createdAtLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        setupUI()
        loadUser()
    }

    private func setupUI() {
      usernameLabel.translatesAutoresizingMaskIntoConstraints = false
      emailLabel.translatesAutoresizingMaskIntoConstraints = false
      createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(createdAtLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 12),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            createdAtLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            createdAtLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func loadUser() {
        guard let user = viewModel.getCurrentUser() else {
            usernameLabel.text = "Guest"
            emailLabel.text = "Not logged in"
            createdAtLabel.text = ""
            return
        }

        usernameLabel.text = "Username: \(user.username ?? "")"
        emailLabel.text = "Email: \(user.email ?? "")"

        if let createdAt = user.createdAt {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            createdAtLabel.text = "Joined: \(formatter.string(from: createdAt))"
        }
    }
}

