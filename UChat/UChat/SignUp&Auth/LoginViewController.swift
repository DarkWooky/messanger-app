//
//  LoginViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {
    // MARK: Internal
    
    // Scroll View
    let scrollView = UIScrollView()
    let contentView = UIView()

    // Labels
    let welcomeLabel = UILabel(text: "Welcome Back!", font: .helvetica26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")

    // Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: UIColor(named: "buttonBg"), isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .white, isShadow: true)
    let signUpButton = UIButton(title: "Sign Up", backgroundColor: nil)

    // TextFields
    let emailTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let passwordTextField = OneLineTextField(font: .helvetica20())

    weak var delegate: AuthNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addTargets()
    }

    @objc func googleButtonTapped() {
        AuthService.shared.signInWithGoogle()
    }
    
    @objc func loginButtonTapped() {
        print(#function)
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text)
    }

    @objc func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }

    // MARK: Private

    private func addTargets() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
    }
}

extension LoginViewController {
    private func setupView() {
        
        view.applyGradients()
        setupScrollView(scrollView, with: contentView)
        googleButton.customizeGoogleButton()

        // Stack view
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                         axis: .vertical,
                                         spacing: 5)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField],
                                            axis: .vertical,
                                            spacing: 5)

        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton],
                                          axis: .horizontal,
                                          spacing: 12)
        bottomStackView.alignment = .firstBaseline

        let stackView = UIStackView(arrangedSubviews: [loginWithView, orLabel, emailStackView, passwordStackView, loginButton, bottomStackView],
                                    axis: .vertical,
                                    spacing: 40)

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(welcomeLabel)
        contentView.addSubview(stackView)

        // Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
}

// MARK: - Canvas

import SwiftUI

// MARK: - LoginVCProvider

struct LoginVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let loginVC = LoginViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            return loginVC
        }

        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {}
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
