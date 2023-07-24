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
            Color(uiColor: Color.backGround).ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 50) {
                Spacer()
                
                VStack(spacing: 5) {
                    Image("NicknameViewImage")
                    
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
                                Color(Color.textFieldGray)
                                if viewModel.nickname.count == 0 {
                                    Text("닉네임을 입력해주세요")
                                        .foregroundColor(.fontGray)
                                }
                            }
                        )
                        .cornerRadius(10)
                    
                    HStack {
                        Image("exclamationMark")
                            .opacity(viewModel.nickname.count > 8 ? 1 : 0)
                        Text("닉네임은 8자 이하로 입력해주세요")
                            .foregroundColor(viewModel.nickname.count > 8 ? Color(Color.fontYellow) : Color.fontGray)
                    }
                }
                Spacer()
                makeUpdateNicknameButton()
                    .disabled(viewModel.nickname.isEmpty || viewModel.nickname.count > 8)
                    .padding(.bottom, 12)
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
                .foregroundColor(viewModel.isValidNickName() ? Color(Color.fontBrown) : Color(Color.darkFontGray))
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    viewModel.isValidNickName() ? Color(Color.buttonPink) : Color(Color.buttonGray)
                )
                .cornerRadius(10)
        })
    }
}

struct NicknameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NicknameView()
        }
    }
}

