//
//  SettingsView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var vm = SettingsViewModel()
//    @Binding var showSignInView: Bool
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        
        List {
            Button {
                Task {
                    do {
                        try vm.logout()
//                        showSignInView = true
                        viewRouter.currentPage = .AuthenticationView
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("로그아웃")
            }
            
            //회원 탈퇴
            Button(role: .destructive) {
                Task {
                    do {
                        
                        try await vm.deleteUser()
                        try vm.logout()
//                        showSignInView = true
                        viewRouter.currentPage = .AuthenticationView
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("회원탈퇴")
            }
        }
        .navigationTitle("설정화면")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
//            SettingsView(showSignInView: .constant(false))
            SettingsView()
        }
    }
}
