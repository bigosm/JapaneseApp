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
    
    private let disposeBag = DisposeBag()
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
    
    @objc func loginButtonTapped() {
        dismissKeyboard()
        viewModel.inputs.loginButtonTapped()
    }
    
    @objc func textFieldDidChangeValue(_ sender: UITextField) {
        guard let value = sender.text else { return }
        switch sender {
        case usernameTextField: viewModel.inputs.setUsername(value)
        case passwordTextField: viewModel.inputs.setPassword(value)
        default: return
        }
    }
    
    @objc func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel.outputs.username.bind { [weak self] value in
            self?.usernameTextField.text = value
            print(value)
        }.disposed(by: disposeBag)
        
        viewModel.outputs.password.bind { [weak self] value in
            self?.passwordTextField.text = value
            print(value)
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isLoginButtonActive.bind { [weak self] value in
            self?.loginButton.isEnabled = value
            print(value)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Setup View
    
    lazy var logoView: UIStackView = {
        let x = UIStackView(arrangedSubviews: [dayTimeImageView, logoLabel])
        x.axis = .vertical
        x.spacing = 20
        x.alignment = .center
        x.distribution = .equalSpacing
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var logoLabel: UILabel = {
        let x = UILabel()
        x.font = .boldSystemFont(ofSize: 35)
        x.textAlignment = .center
        x.numberOfLines = 1
        x.text = "YumeApp"
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    private lazy var dayTimeImageView: UIImageView = {
        let x = UIImageView()
        x.image = dayTimeImage
        x.contentMode = .scaleAspectFill
        x.tintColor = Theme.primaryColor
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var usernameTextField: TextField = {
        let x = basicTextField
        x.placeholder = "E-mail..."
        x.keyboardType = .emailAddress
        return x
    }()
    
    lazy var passwordTextField: TextField = {
        let x = basicTextField
        x.isSecureTextEntry = true
        x.placeholder = "Password..."
        return x
    }()
    
    private var basicTextField: TextField {
        let x = TextField()
        x.returnKeyType = .next
        x.backgroundColor = Theme.secondaryBackgroundColor
        x.font = .systemFont(ofSize: 20)
        x.layer.cornerRadius = 25
        x.textInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        x.delegate = self
        x.addTarget(self, action: #selector(textFieldDidChangeValue(_:)), for: .editingChanged)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }
    
    lazy var loginButton: Button = {
        let x = Button(customType: .primaryRounded)
        x.setTitle("Login", for: .normal)
        x.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()

    private lazy var dayTimeImage: UIImage? = {
        switch Calendar.current.component(.hour, from: Date()) {
        case 5...8:
            return UIImage(systemName: "sunrise.fill")
        case 9...18:
            return UIImage(systemName: "sun.max.fill")
        case 19...21:
            return UIImage(systemName: "sunset.fill")
        default:
            return UIImage(systemName: "moon.zzz.fill")
        }
    }()
    
    private func setupView() {
        // setup view
        
        view.backgroundColor = Theme.primaryBackgroundColor
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        )
        
        // Setup view hierarchy
        
        view.addSubview(logoView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // Setup constraints
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            dayTimeImageView.widthAnchor.constraint(equalToConstant: 80),
            dayTimeImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
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

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            if viewModel.outputs.isLoginButtonActive.value {
                textField.resignFirstResponder()
                loginButtonTapped()
            } else {
                usernameTextField.becomeFirstResponder()
            }
        default: return false
        }
        return true
    }
}
