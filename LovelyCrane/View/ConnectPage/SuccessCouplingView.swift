//
//  SuccessCouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/26.
//

import SwiftUI
struct SuccessCouplingView: View {
    var body: some View {

        ZStack{
            Color.backGround.ignoresSafeArea()
            VStack{
                Spacer()
                ZStack{
                    VStack{
                        Image(Assets.connectbottle)
                            .resizable()
                            .frame(width: UIScreen.getWidth(60),height: UIScreen.getHeight(90))
                        Text("직녀 X 견우")
                            .padding(.bottom, 26)
                        Text("연인 연결이 되었어요!")
                            .foregroundColor(.primaryLabel)
                    }
                    .padding(.vertical,40)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray3)
                    .cornerRadius(18)
                    .padding(.horizontal,53)
                }
                Spacer()
                VStack(){
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
        NavigationLink(destination: InputCodeView()) {
            Text("다음에 할게요")
                .foregroundColor(.lightPink)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .background(Color.gray3)
        .cornerRadius(8)
    }
    func makesendNowBtn() -> some View {
        NavigationLink(destination: InputCodeView()) {
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
        SuccessCouplingView()
    }
}
