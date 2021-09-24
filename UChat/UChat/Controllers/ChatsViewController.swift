//
//  ChatsViewController.swift
//  UChat
//
//  Created by Egor Mikhalevich on 24.09.21.
//

import UIKit
import MessageKit

class ChatsViewController: MessagesViewController {
    
    private var messages: [MMessage] = []
    
    private let user: MUser
    private let chat: MChat
    
    init(user: MUser, chat: MChat) {
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        
        title = chat.friendUsername
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChatsViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(senderId: user.id, displayName: user.username)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.item]
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    
}
