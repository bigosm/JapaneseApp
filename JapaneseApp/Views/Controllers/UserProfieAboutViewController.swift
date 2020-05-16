//
//  UserProfieAboutViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class UserProfileAboutViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: UserProfileAboutViewModelType = UserProfileAboutViewModel()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputs.viewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.userName.bind { [weak self] value in
            self?.userNameLabel.text = value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - SetupView
    
    lazy var userNameLabel: UILabel = {
        let x = UILabel()
        x.adjustsFontSizeToFitWidth = true
        x.textAlignment = .center
        x.font = .preferredFont(forTextStyle: .largeTitle)
        return x
    }()
    
    lazy var userPicture: UIImageView = {
        let x = UIImageView()
        x.layer.cornerRadius = 75
        x.layer.masksToBounds = true
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 10
        x.contentMode = .scaleAspectFill
        x.image = AppImage.profileUserImagePlaceholder
        x.tintColor = .darkGray
        return x
    }()
    
    private func setupView() {
        view.addSubview(userPicture)
        view.addSubview(userNameLabel)
        
        userPicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userPicture.topAnchor.constraint(equalTo: view.topAnchor),
            userPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPicture.widthAnchor.constraint(equalToConstant: 150),
            userPicture.heightAnchor.constraint(equalToConstant: 150)
        ])

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: userPicture.bottomAnchor, constant: 20),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
