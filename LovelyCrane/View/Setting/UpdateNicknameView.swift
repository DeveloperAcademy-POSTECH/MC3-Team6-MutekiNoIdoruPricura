////
////  updateNicknameView.swift
////  LovelyCrane
////
////  Created by Toughie on 2023/07/30.
////
//
import Firebase
import SwiftUI

struct UpdateNicknameView: View {
    
    @StateObject private var viewModel = NicknameViewModel()
    @FocusState private var nicknameInFocus: Bool

    @Environment(\.dismiss) var dismiss
    
    init() {
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        ZStack {
            Color(.backGround).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 40) {

                    makeHeaderImageText()

                    VStack {
                    makeNicknameTextField()
                    makeNicknameCountCaution()
                    }
                }
                Spacer()
                
                makeUpdateNicknameButton()
            }
            .padding(.horizontal, 24)
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
        .navigationTitle("닉네임 수정")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            nicknameInFocus = true
        }
    }
}

extension UpdateNicknameView {
    
    private func makeHeaderImageText() -> some View {
        VStack(spacing: 5) {
            Image(Assets.nicknameViewImage)
                .resizable()
                .frame(width: UIScreen.getWidth(124), height: UIScreen.getHeight(48))

            Text("사용하실 닉네임을 알려주세요")
                .foregroundColor(.primaryLabel)
        }
    }
    
    private func makeNicknameTextField() -> some View {
        TextField("", text: $viewModel.nickname)
            .focused($nicknameInFocus)
            .foregroundColor(.primaryLabel)
            .multilineTextAlignment(TextAlignment.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background (
                ZStack {
                    Color.textFieldGray
                    if viewModel.nickname.count == 0 {
                        Text("닉네임을 입력해주세요.")
                            .foregroundColor(Color.tertiaryLabel)
                    }
                }
            )
            .cornerRadius(10)
    }
    
    private func makeNicknameCountCaution() -> some View {
        HStack {
            Image(Assets.exclamationMark)
                .resizable()
                .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
                .opacity(viewModel.nickname.count > 8 ? 1 : 0)
            Text("닉네임은 8자 이하로 입력해주세요")
                .foregroundColor(viewModel.nickname.count > 8 ? Color.defaultYellow : Color.tertiaryLabel)
        }
    }
    
    private func makeUpdateNicknameButton() -> some View {
        Button(action: {
            Task{
                do {
                    try await viewModel.updateNickName(nickName: viewModel.nickname)
                    dismiss()
                }
                catch{
                    print("error")
                }
            }
        }, label: {
            Text("저장하기")
                .foregroundColor(viewModel.isValidNickName() ? .gray1 : .quarternaryLabel)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(
                    viewModel.isValidNickName() ? Color.lightPink : Color.gray3
                )
                .cornerRadius(10)
        })
        .disabled(viewModel.nickname.isEmpty || viewModel.nickname.count > 8)
        .padding(.bottom, 25)
    }
}

struct UpdateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateNicknameView()
    }
}
