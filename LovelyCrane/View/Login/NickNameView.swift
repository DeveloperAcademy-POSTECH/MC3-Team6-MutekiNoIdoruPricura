//
//  NickNameView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/17.
//
//Marmktest용입니다. 이후 사용가능한곳에서
// MARK: - 파이어베이스관련 연습코드. 필요한곳에서 사용하시면 됩니다.
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

class NickNameViewModel: ObservableObject {
    
    @Published var nickname: String = ""
    
//    func addmemeber() async throws {
//        let infodata = Info(nickname: nickname, partnerId: "", uuid: "")
//        try await UserManager.shared.createNewUser(user: infodata)
//    }
    
    func addmemeber() async throws {
        
        guard let user = Auth.auth().currentUser else { return }
        let authDataResult =  AuthDataResult(user: user)
        let dbUser = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: dbUser)
    }
    
    func updateNickName(nickName: String) async throws {
        guard let user = Auth.auth().currentUser else { return }
        let userCollection = Firestore.firestore().collection("Users")
        let document = userCollection.document(user.uid)
        
//        let serverNickName = try await document.getDocument(as: DBUser.self).nickname
//        //만약 닉네임이 ""이 아니라면
//        if !serverNickName.isEmpty {
//            return
//        } else {
//            //만약 닉네임이 ""이라면
            let data: [String: Any] = [DBUser.CodingKeys.nickname.rawValue : nickname]
            try await document.updateData(data)
//        }
    }
    
    
    
    func connectWithUser(partnertoken: String) async throws {
        try await UserManager.shared.connectUsertoUser(to: partnertoken)
    }
}

struct NickNameView: View {
    @StateObject var viewModel = NickNameViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showSignInView: Bool
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

                Button(action: {
                    Task{
                        do {
                            //                        try await viewModel.addmemeber()
                            try await viewModel.updateNickName(nickName: viewModel.nickname)
                            showSignInView = false
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
            .padding(.horizontal, 20)
            .onAppear {
                if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                    Task {
                        let userCollection = Firestore.firestore().collection("Users")
                        
                        guard let myDocument = try? await userCollection.document(authUser.uid).getDocument() else { return }
                        guard let myNickname = myDocument["nickname"] as? String else { return }
                        
                        if !myNickname.isEmpty {
                            viewRouter.currentPage = .MainView
                        }
                    }
                }
        }
        }
    }
}

struct NickNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NickNameView(showSignInView: .constant(false))
        }
    }
}

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
