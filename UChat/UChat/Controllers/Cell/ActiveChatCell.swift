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
  //  let lastMsgTimeLbl = UILabel(text: "2:00", font: .helvetica16())
//    let unreadMessageCountLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Color-2")//?.withAlphaComponent(0.2)
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendNameLabel.text = chat.friendUsername
        lastMessageLabel.text = chat.lastMessageContent
        friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
    }
}

// MARK: - SetupViews

extension ActiveChatCell {

    private func setupViews() {
        let chatStackView = UIStackView(arrangedSubviews: [friendNameLabel, lastMessageLabel],
                                        axis: .vertical,
                                        spacing: 8)
        chatStackView.alignment = .leading

        let views = [friendImageView, friendNameLabel, lastMessageLabel, chatStackView, /*lastMsgTimeLbl*/]
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        lastMessageLabel.numberOfLines = 2

        friendImageView.layer.cornerRadius = layer.bounds.height / 3
        friendImageView.clipsToBounds = true

        addSubview(friendImageView)
        addSubview(chatStackView)
   //     addSubview(lastMsgTimeLbl)

        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            friendImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            friendImageView.heightAnchor.constraint(equalToConstant: 75),
            friendImageView.widthAnchor.constraint(equalToConstant: 75),
            ])
        NSLayoutConstraint.activate([
            chatStackView.topAnchor.constraint(equalTo: friendImageView.topAnchor, constant: -2),
            chatStackView.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            chatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            ])
//        NSLayoutConstraint.activate([
//            lastMsgTimeLbl.topAnchor.constraint(equalTo: chatStackView.topAnchor, constant: 2),
//            lastMsgTimeLbl.leadingAnchor.constraint(equalTo: chatStackView.trailingAnchor, constant: 5),
//            lastMsgTimeLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
//            ])
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
