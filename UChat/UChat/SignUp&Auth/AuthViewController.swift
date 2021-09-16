//
//  ViewController.swift
//  ChatU
//
//  Created by Egor Mihalevich on 31.08.21.
//

import UIKit

// MARK: - AuthViewController

class AuthViewController: UIViewController {
    //Image View
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)

    //Labels
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")

    //Buttons
    let googleButton = UIButton(title: "Google", backgroundColor: UIColor(named: "buttonBg"), isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, isShadow: true)
    let loginButton = UIButton(title: "Login", backgroundColor: UIColor(named: "buttonBg"), isShadow: true)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTargets()
    }
    
    private func setupTargets() {
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func emailButtonTapped() {
        print(#function)
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
        present(loginVC, animated: true, completion: nil)
        
    }
}

// MARK: - Setup views

extension AuthViewController {
    private func setupViews() {

        view.applyGradients()
        googleButton.customizeGoogleButton()
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)

        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView],
                                    axis: .vertical,
                                    spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(logoImageView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 150),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}

// MARK: - Canvas

import SwiftUI

// MARK: - AuthVCProvider

struct AuthVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {}
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
