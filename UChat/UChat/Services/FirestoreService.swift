//
//  FirestoreService.swift
//  UChat
//
//  Created by Egor Mihalevich on 18.09.21.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveProfileWith(id: String?, emal: String?, username: String?, avatarImageString: String?, description: String?, sex: String?,)
}


