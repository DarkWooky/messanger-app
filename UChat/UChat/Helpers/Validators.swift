//
//  VerificationService.swift
//  UChat
//
//  Created by Egor Mihalevich on 9.09.21.
//

import UIKit

class Validators {

    static func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        let emailPred = NSPredicate(format: "SELF MATCHES %@", Regex.emailRegex.description())
        return emailPred.evaluate(with: email)
    }

    static func isValidName(_ name: String?) -> Bool {
        guard let name = name else {
            return false
        }
        let namePred = NSPredicate(format: "SELF MATCHES %@", Regex.nameRegex.description())
        return namePred.evaluate(with: name)
    }

    static func isValidPassword(_ pass: String) -> PasswordStrength {
        if NSPredicate(format: "SELF MATCHES %@", Regex.excellentRegex.description()).evaluate(with: pass) {
            return .excellent
        } else if NSPredicate(format: "SELF MATCHES %@", Regex.strongRegex.description()).evaluate(with: pass) {
            return .strong
        } else if NSPredicate(format: "SELF MATCHES %@", Regex.averageRegex.description()).evaluate(with: pass) {
            return .average
        } else if NSPredicate(format: "SELF MATCHES %@", Regex.simpleRegex.description()).evaluate(with: pass) {
            return .simple
        } else {
            return .weak
        }
    }

    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
            let confirmPassword = confirmPassword,
            let email = email,
            password != "",
            confirmPassword != "",
            email != "" else {
            return false
        }
        return true
    }

    static func isFilled(username: String?, description: String?, sex: String?) -> Bool {
        guard let username = username,
            let description = description,
            let sex = sex,
            username != "",
            description != "",
            sex != "" else {
            return false
        }
        return true
    }

    static func updatePassErrorLbl(_ pass1: String, _ pass2: String, _ passwordStrength: PasswordStrength, _ isPassConfirmed: inout Bool, confPassErrLbl: UILabel, passErrLbl: UILabel? = nil) {
        if passwordStrength != .weak {
            isPassConfirmed = pass1 == pass2
            confPassErrLbl.isHidden = isPassConfirmed
        }
        guard let passErrLbl = passErrLbl else { return }
        passErrLbl.textColor = passwordStrength != .weak ? .systemGreen : .systemRed
        passErrLbl.isHidden = pass1 == ""
        passErrLbl.text = "\(passwordStrength.description()) password"
    }
}
