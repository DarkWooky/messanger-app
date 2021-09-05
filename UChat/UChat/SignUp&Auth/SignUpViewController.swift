//
//  SignUpViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

// MARK: - SignUpViewController

class SignUpViewController: UIViewController {
    var scrollView: UIScrollView!
    var contentView: UIView!

    let welcomeLabel = UILabel(text: "Good to see you!", font: .helvetica26())

    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm password")
    let alreadyOnBoardLabel = UILabel(text: "Already onboard?", textColor: .white)
    
    //MARK: – TODO: Add Error!
    let emailErrorLabel = UILabel(text: "Incorrect email", font: .helvetica14(), textColor: .systemRed)

    let emailTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let passwordTextField = OneLineTextField(font: .helvetica20())
    let confirmPasswordTextField = OneLineTextField(font: .helvetica20())

    let signUpButton = UIButton(title: "Sign Up", titleColor: .systemGray6, backgroundColor: .systemPurple, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .systemPurple, backgroundColor: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        assignBackground(backgroundName: "background")
    }
}

extension SignUpViewController {
    
     //MARK: - ScrollView
    private func setupScrollView() {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.contentSize = CGSize(width: screenWidth, height: Constants.maxScreenHeight.rawValue)
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    // MARK: - Views
    private func setupViews() {
        
        //Main StackView
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailErrorLabel], axis: .vertical, spacing: 5)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField], axis: .vertical, spacing: 5)
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            passwordStackView,
            confirmPasswordStackView,
            signUpButton
        ], axis: .vertical, spacing: 40)

        //Bottom StackView
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [
            alreadyOnBoardLabel,
            loginButton
        ], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline

        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(welcomeLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(bottomStackView)

        //Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 200),
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - Canvas

import SwiftUI

// MARK: - SignUpVCProvider

struct SignUpVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let signUpVC = SignUpViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return signUpVC
        }

        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {}
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
