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
    func addmemeber(myuid: String) async throws {
//        let randommycode = String.createRandomStr(length: 10)
        let randommycode = UUID().uuidString
        let infodata = Info(mycode: randommycode, nickname: nickname, partnerId: "", uuid: myuid)
        try await UserManager.shared.createNewUser(user: infodata)
    }
}

import SwiftUI
struct NickNameView: View {
    @StateObject var viewModel = NickNameViewModel()
    @Binding var myuid: String
    var body: some View {
        VStack {
            TextField("Enter your nickname", text: $viewModel.nickname)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            Button(action: {
                Task{
                    do {
                        try await viewModel.addmemeber(myuid: myuid)
                    }
                    catch{
                        print("error")
                    }
                }
            }, label: {
                Text("next view")
            }
            )
            Text("hello \(viewModel.nickname)")
        }
    }
}

