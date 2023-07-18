//
//  AuthenticationView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var vm = AuthenticaitonViewModel()
    @Binding var myuid: String
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            //MARK: 애플 로그인 버튼
            Button {
                Task {
                    do {
                        myuid = try await vm.signInApple()
                        showSignInView = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(buttonType: .default, buttonStyle: .whiteOutline)
                    .allowsHitTesting(false)
            }
            .frame(height: 55)
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            AuthenticationView(showSignInView: .constant(false))
//        }
//    }
//}

