//
//  SettingView2.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct SettingView2: View {
    
    @StateObject private var vm = SettingViewModel()
    @EnvironmentObject var viewRouter : ViewRouter
    
    init() {
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
//    let buttonNames = ["닉네임 수정", "연인 연결 관리", "로그아웃", "회원탈퇴", "만든 사람들"]
    
    var body: some View {
            ZStack(alignment: .topLeading) {
                Color(.backGround).ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        makeCell(name: "닉네임 수정")
                        makeCell(name: "연인 연결 관리")
                        makeCell(name: "로그아웃")
                            .onTapGesture {
                                Task {
                                    do {
                                        try vm.logout()
                                        viewRouter.currentPage = .launchsScreenView
                                        
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        makeCell(name: "회원탈퇴")
                            .onTapGesture {
                                Task {
                                    do {
                                        try await vm.deleteUser()
                                        try vm.logout()
                                        viewRouter.currentPage = .authenticationView
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        makeCell(name: "만든 사람들")
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView2_Previews: PreviewProvider {
    static var previews: some View {
        SettingView2()
    }
}


extension SettingView2 {
    
    private func makeCell(name: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundColor(.white)
                .padding()
//            Divider()
//                .frame(height: 0.5)
//                .background(Color.gray)
//                .padding(.horizontal)
        }
    }
}
