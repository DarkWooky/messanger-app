//
//  LoginViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {
    //Labels
    let welcomeLabel = UILabel(text: "Welcome Back!", font: .helvetica26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")

    //Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: .systemGray6, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .white, isShadow: true)
    let signUpButton = UIButton(title: "Sign Up", titleColor: .systemPurple, backgroundColor: nil)
    
    //TextFields
    let emailTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let passwordTextField = OneLineTextField(font: .helvetica20())

    override func viewDidLoad() {
        super.viewDidLoad()

        //assignBackground(backgroundName: "background")
        googleButton.customizeGoogleButton()
        setupView()
    }
}

extension LoginViewController {
    private func setupView() {
        //Stack view
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

        let stackView = UIStackView(arrangedSubviews: [loginWithView, orLabel, emailStackView,
                                                       passwordStackView, loginButton, bottomStackView],
                                    axis: .vertical,
                                    spacing: 40)

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(welcomeLabel)
        view.addSubview(stackView)

        //Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
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
