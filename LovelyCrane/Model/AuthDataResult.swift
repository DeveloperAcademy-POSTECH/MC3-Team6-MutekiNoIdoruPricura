//
//  AuthDataResultModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation
import FirebaseAuth

struct AuthDataResult {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
