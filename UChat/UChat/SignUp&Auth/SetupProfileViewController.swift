//
//  SetupProfileViewController.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit
import FirebaseAuth
import SDWebImage

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
    let fullImageView = AddPhotoView()

    private let currentUser: User

    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)

        if let username = currentUser.displayName {
            fullNameTextField.text = username
        }

        if let photoURL = currentUser.photoURL {
            fullImageView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
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
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }

    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    @objc private func goToChatsButtonTapped() {
        guard let email = currentUser.email else { return }
        FirestoreService.shared.saveProfileWith(
            id: currentUser.uid,
            email: email,
            username: fullNameTextField.text,
            avatarImage: fullImageView.circleImageView.image,
            description: aboutmeTextField.text,
            sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
            switch result {

            case .success(let muser):
                self.showAlert(with: "Success!", and: "Enjoy chatting") {
                    let mainTabBar = MainTabBarController(currentUser: muser)
                    mainTabBar.modalPresentationStyle = .fullScreen
                    self.present(mainTabBar, animated: true, completion: nil)
                }
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

        view.backgroundColor = .mainWhite()
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

        let views = [setupProfileLabel, fullImageView, stackView]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        contentView.addSubview(setupProfileLabel)
        contentView.addSubview(fullImageView)
        contentView.addSubview(stackView)

        //Constraints
        NSLayoutConstraint.activate([
            setupProfileLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            setupProfileLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: setupProfileLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        fullImageView.circleImageView.image = image
    }
}

