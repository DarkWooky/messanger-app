//
//  WaitingChatsNavigation.swift
//  UChat
//
//  Created by Egor Mikhalevich on 24.09.21.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
