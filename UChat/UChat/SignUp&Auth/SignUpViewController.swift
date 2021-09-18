//
//  SignUpViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 1.09.21.
//

import UIKit

// MARK: - SignUpViewController

class SignUpViewController: UIViewController {
    // MARK: Internal

    // Scroll View
    let scrollView = UIScrollView()
    let contentView = UIView()

    // Labels
    let welcomeLabel = UILabel(text: "Good to see you!", font: .helvetica26())

    let emailLabel = UILabel(text: "Enter your email")
    let passwordLabel = UILabel(text: "Enter strong password")
    let alreadyOnBoardLabel = UILabel(text: "Already onboard?")

    // Error labels
    let emailErrorLabel = UILabel(text: "Incorrect email", font: .helvetica14(), textColor: .systemRed, isHidden: true)
    let passwordErrorLabel = UILabel(text: "Weak password", font: .helvetica14(), textColor: .systemRed, isHidden: true)
    let passwordRuleLabel = UILabel(text: "Your password must be a minimum of 6 characters and contain one lowercase letter and one number.", font: .helvetica16())
    let confirmPasswordlErrorLabel = UILabel(text: "Passwords do not match", font: .helvetica14(), textColor: .systemRed, isHidden: true)

    // Text fields
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

    // Buttons
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, isShadow: true, isEnabled: false)
    let loginButton = UIButton(title: "Login", backgroundColor: nil)

    weak var delegate: AuthNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
    }

    @objc func signUpButtonTapped() {
        print(#function)
        AuthService.shared.register(email: emailTextField.text,
                                    password: passwordTextField.text,
                                    confirmPassword: confirmPasswordTextField.text) { result in
            switch result {
            case .success:
                self.showAlert(with: "Success!", and: "You signed up") {
                    self.present(SetupProfileViewController(), animated: true, completion: nil)
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }

    @objc func loginButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }

    // MARK: Private

    private var isValidEmail = false
    private var isPassConfirmed = false
    private var passwordStrength: PasswordStrength = .weak

    private func addTargets() {
        let textFields = [emailTextField, passwordTextField, confirmPasswordTextField]
        textFields.forEach { $0.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        }

        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Setup views

extension SignUpViewController {
    private func setupViews() {
        
        view.applyGradients()
        setupScrollView(scrollView, with: contentView)
        
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

        let views = [welcomeLabel, stackView, bottomStackView]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        contentView.addSubview(welcomeLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(bottomStackView)

        // Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
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
            VerificationService.updatePassErrorLbl1(pass1, pass2, passwordStrength, &isPassConfirmed, confPassErrLbl: confirmPasswordlErrorLabel, passErrLbl: passwordErrorLabel)

            updateBtnState()
        case confirmPasswordTextField:
            guard let pass1 = passwordTextField.text,
                  let pass2 = confirmPasswordTextField.text else { return }

            VerificationService.updatePassErrorLbl1(pass1, pass2, passwordStrength, &isPassConfirmed, confPassErrLbl: confirmPasswordlErrorLabel)

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

        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {}
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
