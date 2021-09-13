//
//  SignUpViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

// MARK: - SignUpViewController

class SignUpViewController: UIViewController {

    private var isValidEmail = false
    private var isPassConfirmed = false
    private var passwordStrength: PasswordStrength = .weak

    //Scroll View
    let scrollView = UIScrollView()
    let contentView = UIView()

    //Labels
    let welcomeLabel = UILabel(text: "Good to see you!", font: .helvetica26())

    let emailLabel = UILabel(text: "Enter your email")
    let passwordLabel = UILabel(text: "Enter strong password")
    let alreadyOnBoardLabel = UILabel(text: "Already onboard?")

    //Error labels
    let emailErrorLabel = UILabel(text: "Incorrect email", font: .helvetica14(), textColor: .systemRed, isHidden: true)
    let passwordErrorLabel = UILabel(text: "Weak password", font: .helvetica14(), textColor: .systemRed, isHidden: true)
    let passwordRuleLabel = UILabel(text: "Your password must be a minimum of 8 characters and contain one lowercase letter and one number.", font: .helvetica16(), textColor: .systemGray)
    let confirmPasswordlErrorLabel = UILabel(text: "Passwords do not match", font: .helvetica14(), textColor: .systemRed, isHidden: true)

    //Text fields
    let emailTextField = OneLineTextField(font: .helvetica20(),
        isSecure: false,
        placeholder: "Email",
        textContentType: .emailAddress)
    let passwordTextField = OneLineTextField(font: .helvetica20(),
        placeholder: "Password",
        textContentType: .newPassword)
    let confirmPasswordTextField = OneLineTextField(font: .helvetica20(),
        placeholder: "Confirm password",
        textContentType: .newPassword)

    //Buttons
    let signUpButton = UIButton(title: "Sign Up", titleColor: .systemGray6, backgroundColor: .systemPurple, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .systemPurple, backgroundColor: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.isEnabled = false
        setupViews()
        //assignBackground(backgroundName: "background")
        setupScrollView(scrollView: scrollView, with: contentView)

        addTargets()
    }
}

// MARK: - Setup views

extension SignUpViewController {

    private func setupViews() {
        // Main StackView
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailErrorLabel], axis: .vertical, spacing: 10)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField, passwordErrorLabel, passwordRuleLabel], axis: .vertical, spacing: 10)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordTextField, confirmPasswordlErrorLabel], axis: .vertical, spacing: 10)
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        signUpButton.alpha = 0.5

        passwordRuleLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            passwordStackView,
            confirmPasswordStackView,
            signUpButton
            ], axis: .vertical, spacing: 40)

        // Bottom StackView
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

        // Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
            ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100),
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
            ])
    }
}

// MARK: - Verification

extension SignUpViewController {
    
    private func updateBtnState() {
        signUpButton.isEnabled = isValidEmail && isPassConfirmed && (passwordStrength != .weak)
        signUpButton.alpha = signUpButton.isEnabled ? 1 : 0.5
    }

    private func updatePassErrorLbl(pass1: String, pass2: String) {
        if passwordStrength != .weak {
            isPassConfirmed = VerificationService.isPasswordConfirmed(pass1: pass1, pass2: pass2)
            confirmPasswordlErrorLabel.isHidden = isPassConfirmed
        }
    }
    
    private func addTargets() {
        let textFields = [emailTextField, passwordTextField, confirmPasswordTextField]
        textFields.forEach { textField in
            textField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            guard let email = emailTextField.text else { return }
            isValidEmail = VerificationService.isValidEmail(email)
            emailErrorLabel.isHidden = isValidEmail
            updateBtnState()
        case passwordTextField:
            guard let pass1 = passwordTextField.text,
                let pass2 = confirmPasswordTextField.text else { return }
            passwordStrength = VerificationService.isValidPassword(pass1)
            passwordErrorLabel.textColor = passwordStrength != .weak ? .systemGreen : .systemRed
            passwordErrorLabel.isHidden = pass1 == ""
            passwordErrorLabel.text = "\(passwordStrength.description()) password"
            updatePassErrorLbl(pass1: pass1, pass2: pass2)
            updateBtnState()
        case confirmPasswordTextField:
            guard let pass1 = passwordTextField.text,
                let pass2 = confirmPasswordTextField.text else { return }
            updatePassErrorLbl(pass1: pass1, pass2: pass2)
            //confirmPasswordlErrorLabel.isHidden = pass2 == ""
            
            updateBtnState()
        default:
            print("")
        }
    }
}

import SwiftUI

// MARK: - SignUpVCProvider

struct SignUpVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let signUpVC = SignUpViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            return signUpVC
        }

        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) { }
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
