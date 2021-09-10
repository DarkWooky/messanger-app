//
//  VerificationService.swift
//  UChat
//
//  Created by Egor Mihalevich on 9.09.21.
//

import Foundation

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

class VerificationService {

    static let simpleRegex = "^(?=.*[a-z])(?=.*[0-9]).{8,}$"
    static let averageRegex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
    static let strongRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,12}"
    static let excellentRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{12,}"


    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }

    static func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePred.evaluate(with: name)
    }

    static func isValidPassword(_ pass: String) -> PasswordStrength {
        if NSPredicate(format: "SELF MATCHES %@", excellentRegex).evaluate(with: pass) {
            return .excellent
        } else if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
            return .strong
        } else if NSPredicate(format: "SELF MATCHES %@", averageRegex).evaluate(with: pass) {
            return .average
        } else if NSPredicate(format: "SELF MATCHES %@", simpleRegex).evaluate(with: pass) {
            return .simple
        } else {
            return .weak
        }
    }

    static func isPasswordConfirmed (pass1: String, pass2: String) -> Bool {
        return pass1 == pass2
    }
}
