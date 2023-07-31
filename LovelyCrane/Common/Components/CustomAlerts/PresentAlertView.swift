//
//  CouplingAlertView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/30.
//

import SwiftUI

struct PresentAlertView: View {
    @State var title: PresentAlertTitle = .presentCrane
    @State var message: PresentAlertMessage = .presentCrane
    @State var buttonTitle: String = "열어보기"
    @State var buttonAction: ()->Void = {}
    @Binding var showAlert: Bool
    
    var body: some View {
        if showAlert {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.gray3)
                        .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(358))
                    VStack(spacing: 0) {
                        Image(Assets.shakingBottle)
                            .resizable()
                            .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(108))
                        Text(title.rawValue)
                            .foregroundColor(.primaryLabel)
                            .font(.system(size: 24, weight: .regular))
                            .padding(.top, UIScreen.getHeight(35))
                        Text(message.rawValue)
                            .foregroundColor(.secondaryLabel)
                            .font(.system(size: 16, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.top, UIScreen.getHeight(22))
                        Button(action: buttonAction) {
                            Text(buttonTitle)
                                .foregroundColor(.gray3)
                                .padding(.vertical, UIScreen.getHeight(16.5))
                                .padding(.horizontal, UIScreen.getWidth(34))
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.lightPink)
                                )
                        }
                        .padding(.top, UIScreen.getHeight(28))
                    }
                }
                Button(action: {
                    showAlert.toggle()
                }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.tertiaryLabel)
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                }
                .padding(.top, UIScreen.getHeight(20))
                .padding(.trailing, UIScreen.getWidth(20))
            }
        }
    }
}

enum PresentAlertTitle: String {
    case craneArrived = "종이학이 도착했어요"
    case presentCrane = "종이학 선물하기"
    case fullBottle = "유리병이 꽉 찼어요"
}

enum PresentAlertMessage: String {
    case craneArrived = "사랑스러운 연인에게\n종이학 쪽지가 도착했나봐요"
    case presentCrane = "선물 후, 유리병은 비워지지만\n쪽지 내용은 남아있어요 :)"
    case fullBottle = "학 천마리가 가득 찼어요\n연인에게 선물해주세요 :)"
}

//struct PresentAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentAlertView()
//    }
//}
