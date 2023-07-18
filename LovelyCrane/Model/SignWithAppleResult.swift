//
//  SignWithAppleResult.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation

// MARK: 애플 로그인 결과에 관련된 정보를 담은 구조체
struct SignInWithAppleResult {
    let token: String
    let nonce: String
    let userName: String?
    let email: String?
}
