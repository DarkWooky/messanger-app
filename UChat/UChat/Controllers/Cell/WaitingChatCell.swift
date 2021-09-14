//
//  WaitingChatCell.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
        
    static var reuseId: String = "WaitingChatCell"

    let friendImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let chat: Chat = value as? Chat else { return }
        friendImageView.image = UIImage(named: chat.userImageString)
    }

    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.layer.cornerRadius = layer.bounds.height / 2.4
        friendImageView.clipsToBounds = true
        
        addSubview(friendImageView)

        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

// MARK: - ActiveChatProvider

struct WaitingChatProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }

        func updateUIViewController(_ uiViewController: WaitingChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) { }
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
