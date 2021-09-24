//
//  ListenerService.swift
//  UChat
//
//  Created by Egor Mikhalevich on 23.09.21.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    
    static let shared = ListenerService()
    
    private var db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    private var currentnUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func userObserver(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> ()) -> ListenerRegistration? {
        var users = users
        let usersListener = userRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                guard let user = MUser(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !users.contains(user) else { return }
                    guard user.id != self.currentnUserId else { return }
                    users.append(user)
                case .modified:
                    guard let index = users.firstIndex(of: user) else { return }
                    users[index] = user
                case .removed:
                    guard let index = users.firstIndex(of: user) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    } //usersObserver
    
    func waitingChatsObserver(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> ()) -> ListenerRegistration? {
        var chats = chats
        let chatsRef = db.collection(["users", currentnUserId, "waitingChats"].joined(separator: "/"))
        let chatsListener = chatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                guard let chat = MChat(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !chats.contains(chat) else { return }
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats.remove(at: index)
                }
            }
            completion(.success(chats))
        }
        return chatsListener
    }
}
