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
        viewModel.outputs.preferredName.bind { [weak self] value in
            self?.preferredName.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.username.bind { [weak self] value in
            self?.username.text = value
        }.disposed(by: disposeBag)
    }
    
    // MARK: - SetupView
    
    lazy var userPicture: UIImageView = {
        let x = UIImageView()
        x.layer.cornerRadius = 75
        x.layer.masksToBounds = true
        x.layer.borderColor = Theme.Background.secondaryColor?.cgColor
        x.layer.borderWidth = 10
        x.contentMode = .scaleAspectFill
        x.image = AppImage.profileUserImagePlaceholder
        x.tintColor = .darkGray
        x.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(userPicture)
        view.addSubview(preferredName)
        view.addSubview(username)
        
        NSLayoutConstraint.activate([
            userPicture.topAnchor.constraint(equalTo: view.topAnchor),
            userPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPicture.widthAnchor.constraint(equalToConstant: 150),
            userPicture.heightAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            preferredName.topAnchor.constraint(equalTo: userPicture.bottomAnchor, constant: 20),
            preferredName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            preferredName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: preferredName.bottomAnchor, constant: 10),
            username.leadingAnchor.constraint(equalTo: preferredName.leadingAnchor),
            username.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            username.trailingAnchor.constraint(equalTo: preferredName.trailingAnchor)
        ])
    }
}
