//
//  InputCodeView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct InputCodeView: View {
    @StateObject var vm = InputCodeViewModel()
    @State private var connectFail = false
    var body: some View {
        ZStack {
            Color(.backGround)
                .ignoresSafeArea()
            VStack{
                Image(Assets.InputCodeImage)
                Text("상대방의 코드를 입력 후\n종이학 편지를 선물할수 있어요")
                    .foregroundColor(.primaryLabel)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 80)
                    .padding(.bottom,36)
                    .padding(.top, 20)
                makeinputCodeField()
                Spacer()
                if connectFail {
                    makeconnectFailureMessage()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                connectFail = false
                            }
                        }
                }
                else{
                    makeConnectBtn().padding(.bottom,20)
                }
            }
            .padding(.top,140)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack{
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                    Text("상대방 코드 입력하기")
                    .foregroundColor(.white)}
            }
        }
    }
    private func makeconnectFailureMessage() -> some View {
        Text("연결에 실패했어요 ㅠㅠ\n 다시 한 번 입력해보시겠어요?")
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.vertical,17)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom,10)
            .padding(.horizontal,25)
    }
    private func makeinputCodeField() -> some View {
        TextField("",text: $vm.inputcode, prompt: Text("코드를 입력해주세요").foregroundColor(.quarternaryLabel))
            .foregroundColor(.white)
            .padding(.vertical,16)
            .multilineTextAlignment(.center)
            .background(Color.gray4)
            .cornerRadius(8)
            .padding(.horizontal,24)
            .padding(.bottom,20)
    }
    private func makeConnectBtn() -> some View {
        Button {
            Task {
                connectFail = try await vm.connectPartner()
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
        InputCodeView()
    }
}
