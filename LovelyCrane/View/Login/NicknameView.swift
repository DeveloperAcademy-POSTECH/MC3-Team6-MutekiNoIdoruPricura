//
//  NickNameView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/17.
//

import Firebase
import SwiftUI

struct NicknameView: View {
    
    @StateObject var viewModel = NicknameViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var partnerToken: String = ""
    
    var body: some View {
        
        ZStack {
            Color(uiColor: Color.backGround).ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    TextField("Enter your nickname", text: $viewModel.nickname)
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                    
                    Text("닉네임은 8자 이하로 입력해주세요")
                        .foregroundColor(.gray)
                }
                updateNicknameButton()
            }
            .padding(.horizontal, 20)
            .onAppear {
                checkNickname()
            }
        }
    }
}

extension NicknameView {
    
    func updateNicknameButton() -> some View {
        Button(action: {
            Task{
                do {
                    try await viewModel.updateNickName(nickName: viewModel.nickname)
                    
                    viewRouter.currentPage = .MainView
                }
                catch{
                    print("error")
                }
            }
        }, label: {
            Text("완료")
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        })
    }
    
    func checkNickname() {
        if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
            Task {
                let userCollection = Firestore.firestore().collection(FieldNames.Users.rawValue)
                guard let myDocument = try? await userCollection.document(authUser.uid).getDocument() else { return }
                guard let myNickname = myDocument[FieldNames.nickname.rawValue] as? String else { return }
                
                if !myNickname.isEmpty {
                    viewRouter.currentPage = .MainView
                }
            }
        }
    }
}

struct NicknameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NicknameView()
        }
    }
}
// refactored_ 추가 개선 필요




// MARK: 커플링 관련 코드

// MARK: - 내UUID클립보드로 옮긴후 복붙.
//            Button {
//                UIPasteboard.general.string = Auth.auth().currentUser?.uid ?? ""
//            } label: {
//                Label(Auth.auth().currentUser?.uid ?? "", systemImage: "doc.on.doc")
//            }
//            .buttonStyle(.bordered)
//            // MARK: - 파트너토큰을 입력하고 클릭을 하게되면 실제 있는 uuid면 서로연결이됨.
//            TextField("Enter your partnertoken", text: $partnerToken)
//                .padding()
//                .background(Color(uiColor: .secondarySystemBackground))
//            Button(action: {
//                Task{
//                    do {
//                        try await viewModel.connectWithUser(partnertoken: partnerToken)
//                    }
//                    catch{
//                        print("error")
//                    }
//                }
//            }, label: {
//                Text("연결해")
//            })
//            Text("hello \(viewModel.nickname)")

//    func addmemeber() async throws {
//        let infodata = Info(nickname: nickname, partnerId: "", uuid: "")
//        try await UserManager.shared.createNewUser(user: infodata)
//    }

//func connectWithUser(partnertoken: String) async throws {
//    try await UserManager.shared.connectUsertoUser(to: partnertoken)
//}
