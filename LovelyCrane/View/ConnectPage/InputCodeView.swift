//
//  InputCodeView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct InputCodeView: View {
    @StateObject var vm = InputCodeViewModel()
    @State private var successconnect: Bool = false
    @State private var isShowingFaiulreMessage = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @Binding var isopenfullscreen : Bool
    var body: some View {
        ZStack {
            Color(.backGround)
                .ignoresSafeArea()
            VStack{
                Spacer().frame(maxHeight: UIScreen.getHeight(190))
                Image(Assets.InputCodeImage)
                makeTextNoti()
                makeinputCodeField()
                Spacer()
                if isShowingFaiulreMessage {
                    ToastAlert(label: "연결에 실패했어요 ㅠㅠ\n 다시 한 번 입력해보시겠어요?")
                        .frame(height: UIScreen.getHeight(78))
                }
                else{
                    makeConnectBtn()
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
            .foregroundColor(.primaryLabel)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 80)
            .padding(.bottom,36)
            .padding(.top, 20)
    }
    private func makeinputCodeField() -> some View {
        TextField("",text: $vm.inputcode,
                  prompt: Text("코드를 입력해주세요")
            .foregroundColor(.quarternaryLabel))
            .foregroundColor(.white)
            .padding(.vertical,16)
            .multilineTextAlignment(.center)
            .background(Color.gray4)
            .cornerRadius(8)
            .padding(.horizontal,24)
            .padding(.bottom,20)
            .focused($isFocused)
    }
    private func makeConnectBtn() -> some View {
        Button {
            Task {
                successconnect = try await vm.connectPartner()
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
                .foregroundColor(vm.inputcode.isEmpty ? Color.quarternaryLabel : Color.black)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .disabled(vm.inputcode.isEmpty)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(vm.inputcode.isEmpty ? Color.gray3 : Color.lightPink))
        .padding(.horizontal,24)
    }
}
struct InputCodeView_Previews: PreviewProvider {
    static var previews: some View {
        InputCodeView(isopenfullscreen: .constant(true))
    }
}
