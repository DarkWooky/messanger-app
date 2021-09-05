//
//  Chat.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit

struct Chat: Hashable {
    var username: String?
    var userImage: UIImage?
    var lastMessage: String?
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Chat {
    static var activeChats: [Chat] = [
        Chat(username: "Nick", userImage: UIImage(named: "human1"), lastMessage: "Hello"),
        Chat(username: "Sam", userImage: UIImage(named: "human2"), lastMessage: "Kiss"),
        Chat(username: "Margo", userImage: UIImage(named: "human3"), lastMessage: "LOL"),
    ]
}

