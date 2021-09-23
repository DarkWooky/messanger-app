//
//  Chat.swift
//  UChat
//
//  Created by Egor Mihalevich on 6.09.21.
//

import UIKit

struct MChat: Hashable, Decodable {
    var friendUsername: String
    var friendAvatarStringURL: String
    var lastMessageContent : String
    var friendId: String
    
    var representation: [String : Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["friendId"] = friendId
        rep["lastMessage"] = lastMessageContent
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
    
//    static func timeFormatter(from date: String, format: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = dateFormatter.date(from: date)!
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = format
//        return timeFormatter.string(from: date)
//    }
}
