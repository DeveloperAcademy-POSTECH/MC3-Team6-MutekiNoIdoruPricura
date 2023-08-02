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
import FirebaseFirestore

struct AuthenticationView: View {
    @StateObject private var vm = AuthenticaitonViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.backGround).ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    makeLoginImageTextView()
                    
                    VStack {
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
                            Image("appleidButton")
                                .resizable()
                                .frame(height: UIScreen.getHeight(45))
                                .padding(.horizontal)
                        }
                        
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
                            Image("googleidButton")
                                .resizable()
                                .frame(height: UIScreen.getHeight(45))
                                .padding(.horizontal)
                        }


//                        signInWithAppleButton()
//                        customSignInWithGoogleButton()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

extension AuthenticationView {
    
    private func makeLoginImageTextView() -> some View {
        VStack(spacing: 15) {
            Image("login")
                .resizable()
                .scaledToFit()
                .frame(width: CGSize.deviceWidth * 0.6)
            
            VStack(alignment: .center, spacing: 8) {
                Text("사랑의 종이학")
                    .font(.title2font())
                Text("사랑하는 마음을 차곡차곡 모아")
                    .font(.footnotefont())
                Text("상대방에게 선물해요")
                    .font(.footnotefont())
            }
            .foregroundColor(.white)
        }
        .padding(.bottom, 20)
    }
    
    private func signInWithAppleButton() -> some View {
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
        .frame(height: UIScreen.getHeight(44))
    }
    //MARK: 순정 구글 로그인 버튼
    private func signInWithGoogleButton() -> some View {
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
    
    private func customSignInWithGoogleButton() -> some View {
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
                    .frame(height: UIScreen.getHeight(44))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                HStack(spacing: 5.5) {
                    Image("googleLogo")
                        .resizable()
                        .frame(width: UIScreen.getWidth(10), height: UIScreen.getHeight(10))
                        .padding(.leading, 11)
                    Text("Sign in with Google")
                        .font(.system(size: 16.7, weight: .medium, design: .default))
                        .foregroundColor(.black)
                }
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
