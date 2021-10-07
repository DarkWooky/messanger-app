//
//  WaitingChatCell.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
        
    static var reuseId: String = "WaitingChatCell"

    let friendImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
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
