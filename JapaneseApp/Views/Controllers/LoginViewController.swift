//
//  LoginViewController.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

public final class LoginViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    private let viewModel: LoginViewModelType = LoginViewModel()
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        self.setupView()
        self.bindViewModel()
        self.viewModel.inputs.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.inputs.viewWillAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.inputs.viewWillDisappear()
    }
    
    // MARK: - Instance Methods
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.username.addObserver(self) { [weak self] value, _ in
            self?.usernameTextField.text = value
        }
        
        viewModel.outputs.password.addObserver(self) { [weak self] value, _ in
            self?.passwordTextField.text = value
        }
        
        viewModel.outputs.isLoginButtonActive.addObserver(self) { [weak self] value, _ in
            self?.loginButton.isEnabled = value
        }
    }
    
    // MARK: - View Position Layout
    
    lazy var usernameTextField: UITextField = {
        let x = UITextField()
        x.placeholder = "E-mail..."
        x.backgroundColor = Theme.secondaryBackgroundColor
        x.font = .systemFont(ofSize: 20)
        x.layer.cornerRadius = 25
        x.delegate = self
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var passwordTextField: UITextField = {
        let x = UITextField()
        x.isSecureTextEntry = true
        x.placeholder = "Password..."
        x.backgroundColor = Theme.secondaryBackgroundColor
        x.font = .systemFont(ofSize: 20)
        x.layer.cornerRadius = 25
        x.delegate = self
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var loginButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("Login", for: .normal)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private func setupView() {
        view.backgroundColor = Theme.primaryBackgroundColor
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: loginButton.buttonHeight),
        ])

    }
}

extension LoginViewController: UITextFieldDelegate {

}
