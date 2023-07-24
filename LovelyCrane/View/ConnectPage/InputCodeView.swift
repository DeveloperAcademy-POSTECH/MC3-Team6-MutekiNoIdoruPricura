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
            Color(Color.backGround)
                .ignoresSafeArea()
            VStack{
                Image(Assets.couplingpaper)
                Text("상대방의 코드를 입력 후 종이학 편지를 선물할수 있어요")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 80)
                    .padding(.bottom,80)
                inputCodeField()
                Button {
                    Task {
                        connectFail = try await vm.connectPartner()
                    }
                } label: {
                    Text("연결하기")
                        .foregroundColor(vm.inputcode.isEmpty ? Color.secondary : Color.black)
                        .padding(.vertical,16)
                        .frame(maxWidth: .infinity)
                }
                .disabled(vm.inputcode.isEmpty)
                .background(RoundedRectangle(cornerRadius: 8)
                .fill(vm.inputcode.isEmpty ? Color.black : Color.pink))
                .padding(.horizontal,24)
                Spacer()
                if connectFail {
                    connectFailureMessage()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                connectFail = false
                            }
                        }
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
    private func connectFailureMessage() -> some View {
        Text("연결에 실패했어요 ㅠㅠ\n 다시 한 번 입력해보시겠어요?")
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.vertical,17)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom,10)
            .padding(.horizontal,25)
    }
    private func inputCodeField() -> some View {
        TextField("코드를 입력해주세요",text: $vm.inputcode)
            .padding(.vertical,16)
            .multilineTextAlignment(.center)
            .background(Color.fontGray)
            .cornerRadius(8)
            .padding(.horizontal,24)
            .padding(.bottom,20)
    }
}
struct InputCodeView_Previews: PreviewProvider {
    static var previews: some View {
        InputCodeView()
    }
}
