//
//  updateNicknameView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/30.
//

import Firebase
import SwiftUI

struct UpdateNicknameView: View {
    
    @StateObject private var viewModel = NicknameViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    @FocusState private var nicknameInFocus: Bool

    var body: some View {
        
        ZStack {
            Color(.backGround).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack(alignment: .center, spacing: 40) {

                    VStack(spacing: 5) {
                        Image(Assets.nicknameViewImage)

                        Text("사용하실 닉네임을 알려주세요")
                            .foregroundColor(.primaryLabel)
                    }

                    VStack {
                        TextField("닉네임을 입력해주세요", text: $viewModel.nickname)
                            .focused($nicknameInFocus)
                            .foregroundColor(.primaryLabel)
                            .multilineTextAlignment(TextAlignment.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background (
                                ZStack {
                                    Color.textFieldGray
                                    if viewModel.nickname.count == 0 {
                                        Text("닉네임을 입력해주세요")
                                            .foregroundColor(Color.tertiaryLabel)
                                    }
                                }
                            )
                            .cornerRadius(10)
                        
                        HStack {
                            Image(Assets.exclamationMark)
                                .opacity(viewModel.nickname.count > 8 ? 1 : 0)
                            Text("닉네임은 8자 이하로 입력해주세요")
                                .foregroundColor(viewModel.nickname.count > 8 ? Color.defaultYellow : Color.tertiaryLabel)
                        }
                    }
                }
                Spacer()
                
                makeUpdateNicknameButton()
                    .disabled(viewModel.nickname.isEmpty || viewModel.nickname.count > 8)
                    .padding(.bottom, 25)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            nicknameInFocus = true
        }
    }
}

extension UpdateNicknameView {
    
    func makeUpdateNicknameButton() -> some View {
        Button(action: {
            Task{
                do {
                    try await viewModel.updateNickName(nickName: viewModel.nickname)
                    viewRouter.currentPage = .mainView
                }
                catch{
                    print("error")
                }
            }
        }, label: {
            Text("완료")
                .foregroundColor(viewModel.isValidNickName() ? .gray1 : .quarternaryLabel)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    viewModel.isValidNickName() ? Color.lightPink : Color.gray3
                )
                .cornerRadius(10)
        })
    }
}

struct UpdateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewRouter = ViewRouter()
        UpdateNicknameView()
            .environmentObject(viewRouter)
    }
}
