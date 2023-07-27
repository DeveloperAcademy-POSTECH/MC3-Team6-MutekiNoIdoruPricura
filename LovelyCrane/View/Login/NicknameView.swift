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
                        Image("NicknameViewImage")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 124, height: 48)
                        
                        Text("사용하실 닉네임을 알려주세요")
                            .foregroundColor(.white)
                    }

                    VStack {
                        TextField("닉네임을 입력해주세요", text: $viewModel.nickname)
                            .focused($nicknameInFocus)
                            .foregroundColor(.white)
                            .multilineTextAlignment(TextAlignment.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background (
                                ZStack {
                                    Color.textFieldGray
                                    if viewModel.nickname.count == 0 {
                                        Text("닉네임을 입력해주세요")
                                            .foregroundColor(Color.fontGray)
                                    }
                                }
                            )
                            .cornerRadius(10)
                        
                        HStack {
                            Image("exclamationMark")
                                .opacity(viewModel.nickname.count > 8 ? 1 : 0)
                            Text("닉네임은 8자 이하로 입력해주세요")
                                .foregroundColor(viewModel.nickname.count > 8 ? Color.fontYellow : Color.fontGray)
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
                .foregroundColor(viewModel.isValidNickName() ? Color.fontBrown : Color.darkFontGray)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    viewModel.isValidNickName() ? Color.buttonPink : Color.buttonGray
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
