//
//  Constants.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

enum ListSection: Int, CaseIterable {
    case waitingChats, activeChats
    
    func description() -> String {
        switch self {
        case .waitingChats:
            return "Waiting chats"
        case .activeChats:
            return "Active chats"
        }
    }
}

enum PeopleSection: Int, CaseIterable {
    case users
    
    func description(userCount: Int) -> String {
        switch self {
        case .users:
            return "\(userCount) people nearby"
        }
    }
}

