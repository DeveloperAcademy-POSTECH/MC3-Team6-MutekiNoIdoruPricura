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
    @Binding var savedNickname: Bool
    
    init(savedNickname: Binding<Bool>) {
        _savedNickname = savedNickname
        
        let navBarAppearance = UINavigationBar.appearance()
        if let uiFont = convertToUIFont(.headlinefont(), size: 20) {
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: uiFont]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: uiFont]
        }
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
                    .padding(.trailing, 35)
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
                .font(.headlinefont())
                .foregroundColor(.primaryLabel)
        }
    }
    
    private func makeNicknameTextField() -> some View {
        TextField("", text: $viewModel.nickname)
            .font(.bodyfont())
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
                            .font(.bodyfont())
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
                .font(.footnotefont())
                .foregroundColor(viewModel.nickname.count > 8 ? Color.defaultYellow : Color.tertiaryLabel)
        }
    }
    
    private func makeUpdateNicknameButton() -> some View {
        Button(action: {
            Task{
                do {
                    try await viewModel.updateNickName(nickName: viewModel.nickname)
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            savedNickname = true
                        }
                    }
                }
                catch{
                    print("error")
                }
            }
        }, label: {
            Text("저장하기")
                .font(.bodyfont())
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
    
    private func convertToUIFont(_ font: Font, size: CGFloat) -> UIFont? {
        if let customFont = UIFont(name: "omyu pretty", size: size) {
            return customFont
        }
        return nil
    }
}

struct UpdateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateNicknameView(savedNickname: .constant(false))
    }
}
