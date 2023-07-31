//
//  SuccessCouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/26.
//

import SwiftUI
struct SuccessCouplingView: View {
    @Binding var isOpenModal:Bool
    var body: some View {
        ZStack{
            Color.backGround.ignoresSafeArea()
            VStack{
                Spacer()
                CoupleSuccessView()
                Spacer()
                VStack{
                    Text("사랑의 종이학들을 선물할까요?")
                        .foregroundColor(.primaryLabel)
                        .padding(.bottom,30)
                    makeretryBtn()
                        .padding(.horizontal,24)
                        .padding(.bottom,12)
                    makesendNowBtn()
                        .padding(.horizontal,24)
                }
            }}}
}
extension SuccessCouplingView {
    func makeretryBtn() -> some View {
        Button(action: {isOpenModal = false}) {
            Text("다음에 할게요")
                .foregroundColor(.lightPink)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .background(Color.gray3)
        .cornerRadius(8)
    }
    func makesendNowBtn() -> some View {
        Button(action: {isOpenModal = false}) {
            Text("네! 지금 선물할래요")
                .foregroundColor(.gray1)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .background(Color.lightPink)
        .cornerRadius(8)
    }
}
struct SuccessCouplingView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCouplingView(isOpenModal: .constant(true))
    }
}
