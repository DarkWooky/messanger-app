//
//  ActiveChatCell.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit

// MARK: - ActiveChatCell

class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    // MARK: Internal

    static var reuseId: String = "ActiveChatCell"

    let friendImageView = UIImageView()
    let friendNameLabel = UILabel(text: "User name", font: .helveticaNeueMedium20())
    let lastMessageLabel = UILabel(text: "How are you?", font: .helveticaNeue18())
    let lineView = UIView()
    let lastMsgTimeLbl = UILabel(text: "2:00", font: .helveticaNeue18())
//    let unreadMessageCountLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "mainColor-1")?.withAlphaComponent(0.5)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let chat: Chat = value as? Chat else { return }
        friendImageView.image = UIImage(named: chat.userImageString)
        friendNameLabel.text = chat.username
        lastMessageLabel.text = chat.lastMessage
        lastMsgTimeLbl.text = Chat.timeFormatter(from: chat.date, format: "HH:mm")
    }
}

// MARK: - SetupViews

extension ActiveChatCell {

    private func setupViews() {
        let chatStackView = UIStackView(arrangedSubviews: [friendNameLabel, lastMessageLabel], axis: .vertical, spacing: 8)
        chatStackView.alignment = .leading

        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        chatStackView.translatesAutoresizingMaskIntoConstraints = false
        lastMsgTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .brown

        lastMessageLabel.numberOfLines = 2

        friendImageView.layer.cornerRadius = layer.bounds.height / 2.8
        friendImageView.clipsToBounds = true

        addSubview(friendImageView)
        addSubview(chatStackView)
        addSubview(lastMsgTimeLbl)
        addSubview(lineView)

        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            friendImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            friendImageView.heightAnchor.constraint(equalToConstant: 88),
            friendImageView.widthAnchor.constraint(equalToConstant: 88),
            ])
        NSLayoutConstraint.activate([
            chatStackView.topAnchor.constraint(equalTo: friendImageView.topAnchor),
            chatStackView.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            chatStackView.trailingAnchor.constraint(equalTo: lastMsgTimeLbl.leadingAnchor, constant: -10)
            ])
        NSLayoutConstraint.activate([
            lastMsgTimeLbl.topAnchor.constraint(equalTo: chatStackView.topAnchor, constant: 2),
            lastMsgTimeLbl.leadingAnchor.constraint(equalTo: chatStackView.trailingAnchor, constant: 5),
            lastMsgTimeLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            ])
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: chatStackView.leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}

import SwiftUI

// MARK: - ActiveChatProvider

struct ActiveChatProvider: PreviewProvider {
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }

        func updateUIViewController(_ uiViewController: ActiveChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) { }
    }

    static var previews: some View {
        ContainerView().preferredColorScheme(.light).edgesIgnoringSafeArea(.all)
    }
}
