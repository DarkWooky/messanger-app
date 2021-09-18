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
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> ()) {
        
        guard let email = email, let password = password else { return }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> ()) {
        guard let email = email, let password = password else { return }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
    
            completion(.success(result.user))
        }
    }
}
