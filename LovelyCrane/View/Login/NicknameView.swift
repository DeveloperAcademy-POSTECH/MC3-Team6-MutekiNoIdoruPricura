//
//  NickNameView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/17.
//

import Firebase
import SwiftUI

struct NicknameView: View {
    
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
                            .resizable()
                            .frame(width: UIScreen.getWidth(124), height: UIScreen.getHeight(48))

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
                                .resizable()
                                .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
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

extension NicknameView {
    
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

struct NicknameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewRouter = ViewRouter()
        NicknameView()
            .environmentObject(viewRouter)
    }
}
