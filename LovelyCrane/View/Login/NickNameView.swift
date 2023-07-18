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
        let randommycode = String.createRandomStr(length: 10)
        let uuid = String.createRandomStr(length: 13)
        let infodata = Info(mycode: randommycode, nickname: nickname, partnerId: "", uuid: uuid)
        try await UserManager.shared.createNewUser(user: infodata)
    }
}

import SwiftUI
struct NickNameView: View {
    @StateObject var viewModel = NickNameViewModel()
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
            }
            )
            Text("hello \(viewModel.nickname)")
        }
    }
}

