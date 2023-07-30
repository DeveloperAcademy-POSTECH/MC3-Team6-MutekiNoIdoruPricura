//
//  SettingsView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject private var vm = SettingViewModel()

    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        List {
            Button {
                Task {
                    do {
                        try vm.logout()
                        viewRouter.currentPage = .launchsScreenView
                        
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
                        viewRouter.currentPage = .authenticationView
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("회원탈퇴")
            }
        }
        .navigationTitle("설정")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingView()
        }
    }
}
