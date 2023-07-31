//
//  SettingView2.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = SettingViewModel()
    @EnvironmentObject var viewRouter : ViewRouter
    
    init() {
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
            ZStack(alignment: .topLeading) {
                Color(.backGround).ignoresSafeArea()
                
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        NavigationLink {
                            UpdateNicknameView()
                        } label: {
                            makeCell(name: "닉네임 수정")
                        }

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
                .padding(.horizontal, 16)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.tertiaryLabel)
                        .padding(.trailing, 15)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension SettingView {
    
    private func makeCell(name: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
