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


enum Regex: Int{
    case simpleRegex
    case averageRegex
    case strongRegex
    case excellentRegex
    case emailRegex
    case nameRegex

    func description() -> String {
        switch self {
        case .simpleRegex:
            return "^(?=.*[a-z])(?=.*[0-9]).{6,}$"
        case .averageRegex:
            return "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$"
        case .strongRegex:
            return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{6,10}"
        case .excellentRegex:
            return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{10,}"
        case .emailRegex:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .nameRegex:
            return "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        }

    }
}

enum PasswordStrength: Int {
    case weak
    case simple
    case average
    case strong
    case excellent

    func description() -> String {
        switch self {
        case .weak:
            return "Weak"
        case .simple:
            return "Simple"
        case .average:
            return "Average"
        case .strong:
            return "Strong"
        case .excellent:
            return "Excellent"
        }
    }
}

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Incorrect email format", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Passwords don't match", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        }
    }
}

enum UserError {
    case notFilled
    case invalidName
    case photoNotExist
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User didn't choose a photo", comment: "")
        case .invalidName:
            return NSLocalizedString("Incorrect name format", comment: "")
        }
    }
}

