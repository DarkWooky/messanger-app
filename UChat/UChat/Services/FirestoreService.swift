//
//  FirestoreService.swift
//  UChat
//
//  Created by Egor Mihalevich on 18.09.21.
//

import Firebase
import FirebaseFirestore
import Foundation

// MARK: - FirestoreService

class FirestoreService {
    // MARK: Internal

    static let shared = FirestoreService()

    let db = Firestore.firestore()
    
    // MARK: Private

    private var usersRef: CollectionReference {
        return db.collection("users")
    }

    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> ()) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, _ in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }

    func saveProfileWith(id: String, email: String, username: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> ()) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }

        guard Validators.isValidName(username) else {
            completion(.failure(UserError.invalidName))
            return
        }

        let muser = MUser(username: username!,
                          email: email,
                          avatarStringURL: "not exist",
                          description: description!,
                          sex: sex!,
                          id: id)
        usersRef.document(muser.id).setData(muser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(muser))
            }
        }
    }
}
