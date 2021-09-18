//
//  AuthNavigationDelegate.swift
//  UChat
//
//  Created by Egor Mihalevich on 16.09.21.
//

import Foundation

// MARK: - AuthNavigationDelegate

protocol AuthNavigationDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}
