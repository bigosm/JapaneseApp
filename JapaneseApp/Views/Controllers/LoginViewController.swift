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
        }.disposed(by: disposeBag)
        
        viewModel.outputs.password.bind { [weak self] value in
            self?.passwordTextField.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.errorMessage.bind { [weak self] value in
            self?.errorLabel.text = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isLoginButtonActive.bind { [weak self] value in
            self?.loginButton.isEnabled = value
        }.disposed(by: disposeBag)
        
        viewModel.outputs.isRequestInProcess.bind { [weak self] isProcessing in
            self?.usernameTextField.isEnabled = !isProcessing
            self?.passwordTextField.isEnabled = !isProcessing
            if isProcessing {
                self?.requestIndicator.startAnimating()
            } else {
                self?.requestIndicator.stopAnimating()
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Setup View
    
    lazy var logoView: UIStackView = {
        let x = UIStackView(arrangedSubviews: [dayTimeImageView, logoLabel])
        x.axis = .vertical
        x.spacing = 10
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
        x.backgroundColor = Theme.Background.secondaryColor
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
    
    lazy var errorLabel: UILabel = {
        let x = UILabel()
        x.numberOfLines = 0
        x.textAlignment = .center
        x.textColor = Theme.alertColor
        x.font = .systemFont(ofSize: 20)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    lazy var requestIndicator: LoadingIndicatorView = {
        let x = LoadingIndicatorView()
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()

    private lazy var dayTimeImage: UIImage? = {
        switch Calendar.current.component(.hour, from: Date()) {
        case 5...8: return UIImage(systemName: "sunrise.fill")
        case 9...18: return UIImage(systemName: "sun.max.fill")
        case 19...21: return UIImage(systemName: "sunset.fill")
        default: return UIImage(systemName: "moon.zzz.fill")
        }
    }()
    
    private func setupView() {
        // setup view
        
        view.backgroundColor = Theme.Background.primaryColor
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        )
        
        // Setup view hierarchy
        
        view.addSubview(logoView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)
        view.addSubview(requestIndicator)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Theme.Size.Height.screen(x568: 10, x667: 20, x736: 30)),
            logoView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Size.Padding.standard),
            logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Size.Padding.standard),
        ])
        let dayTimeImageSize = Theme.Size.Height.screen(x568: 50, x667: 70, x736: 80)
        NSLayoutConstraint.activate([
            dayTimeImageView.widthAnchor.constraint(equalToConstant: dayTimeImageSize),
            dayTimeImageView.heightAnchor.constraint(equalToConstant: dayTimeImageSize),
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(
                equalTo: logoView.bottomAnchor,
                constant: Theme.Size.Height.screen(x568: 10, x667: 20)),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Size.Padding.standard),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Theme.Size.Padding.standard),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(
                equalTo: usernameTextField.bottomAnchor,
                constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: Theme.Size.Height.screen(x568: 10, x667: 30)),
            loginButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: loginButton.buttonHeight),
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: Theme.Size.Height.screen(x568: 10, x736: 20)),
            errorLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            requestIndicator.topAnchor.constraint(
                equalTo: errorLabel.bottomAnchor,
                constant: Theme.Size.Height.screen(x568: 10, x736: 20)),
            requestIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
