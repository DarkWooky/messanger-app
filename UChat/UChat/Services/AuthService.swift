//
//  AuthService.swift
//  UChat
//
//  Created by Egor Mihalevich on 16.09.21.
//

import UIKit
import Firebase

class AuthService {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    func login(email: String?, password: String?, comletion: @escaping (Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                comletion(.failure(error!))
                return
            }
            comletion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, comletion: @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                comletion(.failure(error!))
                return
            }
            
            comletion(.success(result.user))
        }
    }
}
