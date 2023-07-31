//
//  InputCodeView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct InputCodeView: View {
    @State private var successconnect: Bool = false
    @State private var isShowingFaiulreMessage = false
    @State private var inputcode: String = ""
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Binding var isopenfullscreen : Bool
    let userManager = UserManager.shared

    var body: some View {
        ZStack {
            Color(.backGround)
                .ignoresSafeArea()
            VStack{
                Spacer()
                    .frame(maxHeight: UIScreen.getHeight(190))
                Image(Assets.inputpartner)
                makeTextNoti()
                makeinputCodeField()
                Spacer()
                if isShowingFaiulreMessage {
                    ToastAlert(label: "연결에 실패했어요 ㅠㅠ\n 다시 한 번 입력해보시겠어요?")
                        .frame(height: UIScreen.getHeight(78))
                        .padding(.bottom, UIScreen.getHeight(10))
                }
                else{
                    makeConnectBtn()
                        .padding(.bottom, UIScreen.getHeight(10))
                }
            }        }
        .onAppear {
            isFocused = true
        }
        .fullScreenCover(isPresented: $successconnect) {
            SuccessCouplingView(isOpenModal: $isopenfullscreen)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("상대방 코드 입력하기")
        .onTapGesture {
            isFocused = false
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {dismiss()})
                    {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                    }
            }
        }
    }
    private func makeTextNoti() -> some View {
        Text("상대방의 코드를 입력 후\n종이학 편지를 선물할수 있어요")
            .lineSpacing(UIScreen.getHeight(7))
            .foregroundColor(.primaryLabel)
            .multilineTextAlignment(.center)
            .padding(.horizontal, UIScreen.getWidth(80))
            .padding(.bottom,UIScreen.getHeight(36))
            .padding(.top, UIScreen.getHeight(20))
            .font(Font.bodyfont())
    }
    private func makeinputCodeField() -> some View {
        TextField("",text: $inputcode,
                  prompt: Text("코드를 입력해주세요")
            .font(Font.bodyfont())
            .foregroundColor(.quarternaryLabel))
            .foregroundColor(.primaryLabel)
            .font(Font.bodyfont())
            .padding(.vertical,UIScreen.getHeight(15.5))
            .multilineTextAlignment(.center)
            .background(Color.gray4)
            .cornerRadius(8)
            .padding(.horizontal,UIScreen.getWidth(24))
            .padding(.bottom,UIScreen.getHeight(20))
            .focused($isFocused)
    }
    private func makeConnectBtn() -> some View {
        Button {
            Task {
                successconnect = try await userManager.connectUsertoUser(to: inputcode)
                if !successconnect {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isShowingFaiulreMessage.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    withAnimation(.easeInOut){
                        isShowingFaiulreMessage = false
                    }
                }
            }
        } label: {
            Text("연결하기")
                .font(Font.bodyfont())
                .foregroundColor(inputcode.isEmpty ? Color.quarternaryLabel : Color.black)
                .padding(.vertical,UIScreen.getHeight(18))
                .frame(maxWidth: .infinity)

        }
        .disabled(inputcode.isEmpty)
        .background(RoundedRectangle(cornerRadius: 8)
        .fill(inputcode.isEmpty ? Color.gray3 : Color.lightPink))

        .padding(.horizontal,UIScreen.getWidth(24))
    }
}
struct InputCodeView_Previews: PreviewProvider {
    static var previews: some View {
        InputCodeView(isopenfullscreen: .constant(true))
    }
}
