//
//  User.swift
//  UChat
//
//  Created by Egor Mihalevich on 9.09.21.
//

import Foundation

struct User: Hashable, Decodable {
    var username: String
    var avatarImageString: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
