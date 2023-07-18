//
//  AuthenticationView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    @StateObject private var vm = AuthenticaitonViewModel()

    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "bird")
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                Spacer()
                
                VStack {
                    // MARK: 애플 로그인 버튼
                    signInWithAppleButton()
                    // MARK: 구글 로그인 버튼
                    signInWithGoogleButton()
                    // MARK: 구글 로그인 버튼(커스텀)
                    customSignInWithGoogleButton()
                }
            }
            .padding()
            .navigationTitle("사랑의 종이학")
        }
    }
}

extension AuthenticationView {
    
    func signInWithAppleButton() -> some View {
        Button {
            Task {
                do {
                    try await vm.signInApple()
                    showSignInView = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            SignInWithAppleButtonViewRepresentable(buttonType: .default, buttonStyle: .whiteOutline)
                .allowsHitTesting(false)
        }
        .frame(height: 45)
    }
    
    func signInWithGoogleButton() -> some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
            Task {
                do {
                    try await vm.signInGoogle()
                    showSignInView = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func customSignInWithGoogleButton() -> some View {
        Button {
            Task {
                do {
                    try await vm.signInGoogle()
                    showSignInView = false
                } catch {
                    print(error.localizedDescription)
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(height: 45)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                Text("G Sign in with Google")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
        }
    }
}


struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
