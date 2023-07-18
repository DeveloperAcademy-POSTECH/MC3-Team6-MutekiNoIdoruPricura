//
//  NickNameView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/17.
//


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

