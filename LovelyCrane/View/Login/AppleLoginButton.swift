//
//  AppleLoginButton.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import AuthenticationServices
// MARK: 애플 로그인 버튼
struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    
    let buttonType: ASAuthorizationAppleIDButton.ButtonType
    let buttonStyle: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: buttonType, authorizationButtonStyle: buttonStyle)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}
