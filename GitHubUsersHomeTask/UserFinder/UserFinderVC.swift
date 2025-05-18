//
//  ViewController.swift
//  GitHubUsersHomeTask
//
//  Created by Rəşad Əliyev on 5/15/25.
//

import UIKit
import Kingfisher

final class UserFinderVC: BaseViewController {
    
    private let viewModel = UserFinderViewModel()
    
    private let centerStackView: BaseStackView = {
        let stackView = BaseStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    private let topStackView: BaseStackView = {
        let stackView = BaseStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write username"
        textField.backgroundColor = .systemRed
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let mainStackView: BaseStackView = {
        let stackView = BaseStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "gitDefaultImage")
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.layer.cornerRadius = 60
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    private let userBioLabel: UILabel = {
        let label = UILabel()
        label.text = "bio".uppercased()
        return label
    }()
    
    private let userInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        return view
    }()
    
    private let userInfoStackView: BaseStackView = {
        let stackView = BaseStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let followers: UILabel = {
        let label = UILabel()
        label.text = "0 followers"
        return label
    }()
    
    private let following: UILabel = {
        let label = UILabel()
        label.text = "0 following"
        return label
    }()
    
    private let publicRepos: UILabel = {
        let label = UILabel()
        label.text = "0 public Repos"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupButtons()
        
        viewModel.subscribe(self)
    }
    
    private func setupButtons() {
        searchButton.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
    }
    
    @objc private func didTapSearch() {
        viewModel.fetchUserData(username: userNameTextField.text ?? "")
        self.userNameTextField.text = ""
    }
    
    private func setupUI() {
        [centerStackView, topStackView, mainStackView, userInfoView].forEach { control in
            view.addSubview(control)
        }
        
        [topStackView, mainStackView, userInfoView].forEach { view in
            centerStackView.addArrangedSubview(view)
        }
        
        [userNameTextField, searchButton].forEach { control in
            topStackView.addArrangedSubview(control)
        }
        
        [userImage, userName, userBioLabel].forEach { view in
            mainStackView.addArrangedSubview(view)
        }
        
        userInfoView.addSubview(userInfoStackView)
        
        [followers, following, publicRepos].forEach { label in
            userInfoStackView.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            
            centerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            centerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
//            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
//            mainStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
//            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
//            userInfoView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32),
//            userInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            userInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            userInfoStackView.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 16),
            userInfoStackView.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 16),
            userInfoStackView.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor, constant: -16),
            userInfoStackView.bottomAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: -16)
        ])
    }
}

private let stockImage: String = "https://i.sstatic.net/frlIf.png"

extension UserFinderVC: UserFinderDelegate {
    func render(_ state: State) {
        switch state {
        case .loaded(let model):
            DispatchQueue.main.async {
                self.userName.text = model.login ?? "User not found"
                self.followers.text = "\(model.followers ?? 0) followers"
                self.following.text = "\(model.following ?? 0) following"
                self.publicRepos.text = "\(model.publicRepos ?? 0) public repos"
                self.userImage.kf.setImage(with: URL(string: model.avatarUrl ?? stockImage))
                if self.userName.text == model.login {
                    self.showAlert(title: "Success", message: "User is found")
                } else {
                    self.showAlert(title: "Fail", message: "User not found")
                    print(self.userNameTextField.text ?? "")
                    print(model.login ?? "")
                }
            }
        case .error(let error):
            print(error)
        }
    }
}
