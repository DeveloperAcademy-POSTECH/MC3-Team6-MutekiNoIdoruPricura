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
class NickNameViewModel: ObservableObject {
    @Published var nickname: String = ""
    func addmemeber() async throws {
        let infodata = Info(nickname: nickname, partnerId: "", uuid: "")
        try await UserManager.shared.createNewUser(user: infodata)
    }
    func connectWithUser(partnertoken: String) async throws {
        try await UserManager.shared.connectUsertoUser(to: partnertoken)
    }
}

import SwiftUI
struct NickNameView: View {
    @StateObject var viewModel = NickNameViewModel()
    @State var partnerToken: String = ""
    var body: some View {

        VStack {
            TextField("Enter your nickname", text: $viewModel.nickname)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            Button(action: {
                Task{
                    do {
                        try await viewModel.addmemeber()
                    }
                    catch{
                        print("error")
                    }
                }
            }, label: {
                Text("next view")
            })
            // MARK: - 내UUID클립보드로 옮긴후 복붙.
            Button {
                UIPasteboard.general.string = Auth.auth().currentUser?.uid ?? ""
            } label: {
                Label(Auth.auth().currentUser?.uid ?? "", systemImage: "doc.on.doc")
            }
            .buttonStyle(.bordered)
            // MARK: - 파트너토큰을 입력하고 클릭을 하게되면 실제 있는 uuid면 서로연결이됨.
            TextField("Enter your partnertoken", text: $partnerToken)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            Button(action: {
                Task{
                    do {
                        try await viewModel.connectWithUser(partnertoken: partnerToken)
                    }
                    catch{
                        print("error")
                    }
                }
            }, label: {
                Text("연결해")
            })
            Text("hello \(viewModel.nickname)")
        }
    }
}

