//
//  SetupProfileViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit
import FirebaseAuth

// MARK: - SetupProfileViewController

class SetupProfileViewController: UIViewController {
    
    // Scroll View
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //Labels
    let setupProfileLabel = UILabel(text: "Set up profile!", font: .helvetica26())
    let fullNameLabel = UILabel(text: "Full name")
    let aboutmeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")

    //Text fields
    let fullNameTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let aboutmeTextField = OneLineTextField(font: .helvetica20(), isSecure: false)

    //Segmented control
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")

    //Button
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, isShadow: true)

    //View
    let fillImageView = AddPhotoView()
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addTargets()
    }

    private func addTargets() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
    }

    @objc private func goToChatsButtonTapped() {
       // guard let email = currentUser.email else { return }
        FirestoreService.shared.saveProfileWith(
            id: currentUser.uid,
            email: currentUser.email!,
            username: fullNameTextField.text,
            avatarImageString: "nil",
            description: aboutmeTextField.text,
            sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            
            case .success(let muser):
                self.showAlert(with: "Success!", and: "Enjoy chatting")
                print(muser)
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup views

extension SetupProfileViewController {
    private func setupViews() {

        view.applyGradients()
        setupScrollView(scrollView, with: contentView)

        //Stack views
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField],
            axis: .vertical,
            spacing: 0)
        let aboutmeStackView = UIStackView(arrangedSubviews: [aboutmeLabel, aboutmeTextField],
            axis: .vertical,
            spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl],
            axis: .vertical,
            spacing: 12)

        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let stackView = UIStackView(arrangedSubviews: [fullNameStackView, aboutmeStackView,
            sexStackView, goToChatsButton],
            axis: .vertical,
            spacing: 35)

        let views = [setupProfileLabel, fillImageView, stackView]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        contentView.addSubview(setupProfileLabel)
        contentView.addSubview(fillImageView)
        contentView.addSubview(stackView)

        //Constraints
        NSLayoutConstraint.activate([
            setupProfileLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            setupProfileLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: setupProfileLabel.bottomAnchor, constant: 40),
            fillImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
            ])

    }
}

// MARK: - Canvas

import SwiftUI

// MARK: - SetupProfileVCProvider

struct SetupProfileVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let setupProfileVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!)

        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            return setupProfileVC
        }

        func updateUIViewController(_ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) { }
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
