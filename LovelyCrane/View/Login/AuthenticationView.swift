//
//  AuthenticationView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct AuthenticationView: View {
    @StateObject private var vm = AuthenticaitonViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backGround).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Image("AuthenticationViewImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGSize.deviceWidth * 0.7)
                        
                        VStack(alignment: .center, spacing: 8) {
                            Text("사랑의 종이학")
                                .font(.title)
                            Text("사랑하는 마음을 차곡차곡 모아")
                                .font(.callout)
                            Text("상대방에게 선물해요")
                                .font(.callout)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.bottom, 20)
                    
                    Spacer()
                    
                    VStack {
                        signInWithAppleButton()
                        customSignInWithGoogleButton()
                    }
                }
                .padding()
            }
        }
    }
}

extension AuthenticationView {
    
    func signInWithAppleButton() -> some View {
        Button {
            Task {
                do {
                    let authUser = try await vm.signInApple()
                    let userCollection = Firestore.firestore().collection(FieldNames.Users.rawValue)
                    guard
                        let myDocument = try? await userCollection.document(authUser.uid).getDocument(),
                        let myNickname = myDocument[FieldNames.nickname.rawValue] as? String else { return }
                    
                    viewRouter.currentPage = myNickname.isEmpty ? .nicknameView : .mainView
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
                    let authUser = try await vm.signInGoogle()
                    let userCollection = Firestore.firestore().collection(FieldNames.Users.rawValue)
                    guard
                        let myDocument = try? await userCollection.document(authUser.uid).getDocument(),
                        let myNickname = myDocument[FieldNames.nickname.rawValue] as? String else { return }
                    
                    viewRouter.currentPage = myNickname.isEmpty ? .nicknameView : .mainView
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
        
        let viewRouter = ViewRouter()
        
        NavigationView {
            AuthenticationView()
                .environmentObject(viewRouter)
        }
    }
}
