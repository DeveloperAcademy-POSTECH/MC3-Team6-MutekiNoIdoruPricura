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
                TextField("코드를 입력해주세요",text: $vm.inputcode)
                    .padding(.vertical,16)
                    .multilineTextAlignment(.center)
                    .background(Color.fontGray)
                    .cornerRadius(8)
                    .padding(.horizontal,24)
                    .padding(.bottom,20)
                Button {
                    Task {
                        connectFail = try await vm.connectPartner()
                    }
                } label: {
                    Text("연결하기")
                        .foregroundColor(vm.inputcode.isEmpty ? Color.secondary : Color.black)
                        .padding(.vertical,16)
                        .frame(maxWidth: .infinity)
                }.disabled(vm.inputcode.isEmpty)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(vm.inputcode.isEmpty ? Color.black : Color.pink))
                    .padding(.horizontal,24)
                Spacer()
                Text("연결에 실패했어요 ㅠㅠ\n 다시 한 번 입력해보시겠어요?")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical,17)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom,10)
                    .padding(.horizontal,25)
                    .animation(.easeInOut, value: 2)

            }
            .padding(.top,140)
        }
    }
}
class InputCodeViewModel: ObservableObject {
    @Published var inputcode: String = ""
    func connectPartner() async throws -> Bool{
        let result = try await UserManager.shared.connectUsertoUser(to: inputcode)
        print(result)
        return result
    }

}
struct InputCodeView_Previews: PreviewProvider {
    static var previews: some View {
        InputCodeView()
    }
}
