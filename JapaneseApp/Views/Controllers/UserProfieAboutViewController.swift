//
//  UserProfieAboutViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class UserProfileAboutViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: UserProfileAboutViewModelType = UserProfileAboutViewModel()
    
    // MARK: - View Lifecycle
    
     override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputs.viewWillAppear()
    }
    
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    @objc func logoutButtonTapped() {
        viewModel.inputs.logout()
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.preferredName.bind { [weak self] value in
            self?.preferredName.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.username.bind { [weak self] value in
            self?.username.text = value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - SetupView
    
    lazy var logoutButton: Button = {
        let x = Button(customType: .primary)
        x.setImage(UIImage(systemName: "escape"), for: .normal)
        x.setTitle("Logout", for: .normal)
        x.imageView?.contentMode = .scaleAspectFit
        x.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
        x.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        x.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8+2, bottom: 8, right: 16+2)
        x.titleLabel?.font = .preferredFont(forTextStyle: .body)
        x.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var userPicture: UIImageView = {
        let x = UIImageView()
        let size = Theme.Size.Height.screen(x568: 120)
        x.layer.cornerRadius = size / 2
        x.layer.masksToBounds = true
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 5
        x.contentMode = .scaleAspectFill
        x.image = AppImage.profileUserImagePlaceholder
        x.tintColor = Theme.Background.tertiaryColor
        x.translatesAutoresizingMaskIntoConstraints = false
        x.widthAnchor.constraint(equalToConstant: size).isActive = true
        x.heightAnchor.constraint(equalToConstant: size).isActive = true
        return x
    }()
    
    lazy var preferredName: UILabel = {
        let x = UILabel()
        x.adjustsFontSizeToFitWidth = true
        x.textAlignment = .center
        x.font = .preferredFont(forTextStyle: .largeTitle)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var username: UILabel = {
        let x = UILabel()
        x.adjustsFontSizeToFitWidth = true
        x.textAlignment = .center
        x.font = .preferredFont(forTextStyle: .caption1)
        x.textColor = Theme.Text.Color.secondary
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private func setupView() {
        view.addSubview(logoutButton)
        view.addSubview(userPicture)
        view.addSubview(preferredName)
        view.addSubview(username)
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.topAnchor),
            logoutButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Size.Padding.standard),
            
            userPicture.topAnchor.constraint(equalTo: view.topAnchor),
            userPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            preferredName.topAnchor.constraint(
                equalTo: userPicture.bottomAnchor,
                constant: Theme.Size.Spacing.section),
            preferredName.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Size.Padding.standard),
            preferredName.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Theme.Size.Padding.standard),
            
            username.topAnchor.constraint(
                equalTo: preferredName.bottomAnchor,
                constant: Theme.Size.Spacing.common),
            username.leadingAnchor.constraint(equalTo: preferredName.leadingAnchor),
            username.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            username.trailingAnchor.constraint(equalTo: preferredName.trailingAnchor),
        ])
    }

}
