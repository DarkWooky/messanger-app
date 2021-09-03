//
//  SetupProfileViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

// MARK: - SetupProfileViewController

class SetupProfileViewController: UIViewController {
    let setupProfileLabel = UILabel(text: "Set up profile!", font: .helvetica26())

    let fullNameLabel = UILabel(text: "Full name")
    let aboutmeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")

    let fullNameTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let aboutmeTextField = OneLineTextField(font: .helvetica20(), isSecure: false)
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")

    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .systemPurple, isShadow: true)

    let fillImageView = AddPhotoView()

    override func viewDidLoad() {
        super.viewDidLoad()

        assignBackground(backgroundName: "background")
        setupViews()
    }
}

extension SetupProfileViewController {
    private func setupViews() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel,
                                                               fullNameTextField],
                                            axis: .vertical,
                                            spacing: 0)
        let aboutmeStackView = UIStackView(arrangedSubviews: [aboutmeLabel,
                                                              aboutmeTextField],
                                           axis: .vertical,
                                           spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel,
                                                          sexSegmentedControl],
                                       axis: .vertical,
                                       spacing: 12)

        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            fullNameStackView,
            aboutmeStackView,
            sexStackView,
            goToChatsButton
        ],
        axis: .vertical,
        spacing: 40)

        setupProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(setupProfileLabel)
        view.addSubview(fillImageView)
        view.addSubview(stackView)


        NSLayoutConstraint.activate([
            setupProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            setupProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: setupProfileLabel.bottomAnchor, constant: 60),
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
}

// MARK: - Canvas

import SwiftUI

// MARK: - SetupProfileVCProvider

struct SetupProfileVCProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let setupProfileVC = SetupProfileViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            return setupProfileVC
        }

        func updateUIViewController(_ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) {}
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
