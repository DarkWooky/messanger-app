//
//  Chat.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit

struct Chat: Hashable, Decodable {
    var username: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id
    }
}

