//
//  SuccessCouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/26.
//

import SwiftUI
import Combine

struct SuccessCouplingView: View {
    
    @Binding var isOpenModal: Bool
    var body: some View {
        ZStack{
            Color.backGround.ignoresSafeArea()
            VStack{
                Spacer()
                CoupleSuccessView()
                Spacer()
                VStack{
                    makeQuestionText()
                    makeretryBtn()
                        .padding(.horizontal,UIScreen.getWidth(24))
                        .padding(.bottom,UIScreen.getHeight(12))
                    makesendNowBtn()
                        .padding(.horizontal,UIScreen.getWidth(24))
                        .padding(.bottom,UIScreen.getHeight(10))
                }
            }
        }
    }
}
extension SuccessCouplingView {
    func makeQuestionText() -> some View {
        Text("사랑의 종이학들을 선물할까요?")
            .foregroundColor(.primaryLabel)
            .font(Font.bodyfont())
            .padding(.bottom,UIScreen.getHeight(30))
    }
    func makeretryBtn() -> some View {
        Button(action: {
            isOpenModal = false
        }) {
            Text("다음에 할게요")
                .foregroundColor(.lightPink)
                .padding(.vertical,UIScreen.getHeight(18))
                .font(Font.bodyfont())
                .frame(maxWidth: .infinity)
        }
        .background(Color.gray3)
        .cornerRadius(8)
    }
    func makesendNowBtn() -> some View {
        Button {
            isOpenModal = false
            NotificationCenter.default.post(name: Notification.Name("present"), object: nil)
        } label: {
            Text("네! 지금 선물할래요")
                .foregroundColor(.gray1)
                .padding(.vertical,UIScreen.getHeight(18))
                .font(Font.bodyfont())
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
