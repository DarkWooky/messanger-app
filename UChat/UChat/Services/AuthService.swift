//
//  AuthService.swift
//  UChat
//
//  Created by Egor Mihalevich on 16.09.21.
//

import Firebase
import GoogleSignIn
import UIKit

class AuthService {
    // MARK: Internal

    static let shared = AuthService()

    private let auth = Auth.auth()

    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> ()) {
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }

        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }

    func login(email: String?, password: String?) {
        AuthService.shared.login(email: email,
            password: password) { result in
            switch result {
            case .success(let user):
                UIApplication.getTopViewController()?.showAlert(with: "Success!", and: "You signed in") {
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let muser):
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainTabBar, animated: true, completion: nil)
                        case .failure(let error):
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                UIApplication.getTopViewController()?.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }

    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User, Error>) -> ()) {
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let authentication = user?.authentication,
            let idToken = authentication.idToken else { return }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
            accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: UIApplication.getTopViewController().unsafelyUnwrapped) { user, error in
            AuthService.shared.googleLogin(user: user, error: error) { result in
                switch result {
                case .success(let user):
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let muser):
                            UIApplication.getTopViewController()?.showAlert(with: "Success", and: "You signed up") {
                                let mainTabBar = MainTabBarController(currentUser: muser)
                                mainTabBar.modalPresentationStyle = .fullScreen
                                UIApplication.getTopViewController()?.present(mainTabBar, animated: true, completion: nil)
                            }
                        case .failure(let error):
                            UIApplication.getTopViewController()?.showAlert(with: "Success", and: "You signed up") {
                                UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                    }
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "Error", and: error.localizedDescription)
                }
            }
        }
    }

    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> ()) {
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }

        guard password!.lowercased() == confirmPassword!.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }

        guard Validators.isValidEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }

        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }

            completion(.success(result.user))
        }
    }
}
