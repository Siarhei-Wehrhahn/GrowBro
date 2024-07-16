//
//  FireBaseManager.swift
//  GrowBro
//
//  Created by Siarhei Wehrhahn on 16.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager: ObservableObject {
    static let shared = FirebaseManager()
    
    let authenticator = Auth.auth()
    let fireStore = Firestore.firestore()
    
    var userId: String? {
        authenticator.currentUser?.uid
    }
}
