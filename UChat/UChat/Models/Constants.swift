//
//  Constants.swift
//  UChat
//
//  Created by Egor Mihalevich on 2.09.21.
//

import UIKit

enum Constants: CGFloat {
    case maxScreenHeight = 926
}

enum Section: Int, CaseIterable {
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

