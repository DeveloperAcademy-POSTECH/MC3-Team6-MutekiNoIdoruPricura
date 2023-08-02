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
    
    @State var savedNickname = false

    init() {
        let navBarAppearance = UINavigationBar.appearance()
        if let uiFont = convertToUIFont(.headlinefont(), size: 20) {
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: uiFont]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: uiFont]
        }
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .topLeading) {
                    Color(.backGround).ignoresSafeArea()
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            NavigationLink {
                                UpdateNicknameView(savedNickname: $savedNickname)
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
                            .padding(.trailing, 35)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            
            FadeAlertView(showAlert: $savedNickname, alertType: .nickNameSaved)
        }
    }
}

extension SettingView {
    
    private func convertToUIFont(_ font: Font, size: CGFloat) -> UIFont? {
        if let customFont = UIFont(name: "omyu pretty", size: size) {
            return customFont
        }
        return nil
    }
    
    private func makeCell(name: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headlinefont())
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
