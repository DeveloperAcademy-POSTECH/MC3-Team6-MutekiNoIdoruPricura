//
//  CouplingAlertView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/30.
//

import SwiftUI



enum Present: String {
    case craneArrived, presentCrane, fullBottle
    
    var title: String {
        switch self {
        case .craneArrived: return "종이학이 도착했어요"
        case .presentCrane: return "종이학 선물하기"
        case .fullBottle: return "유리병이 꽉 찼어요"
        }
    }
    var message: String {
        switch self {
        case .craneArrived: return "사랑스러운 연인에게\n종이학 쪽지가 도착했나봐요"
        case .presentCrane: return "선물 후, 유리병은 비워지지만\n쪽지 내용은 남아있어요 :)"
        case .fullBottle: return "학 천마리가 가득 찼어요\n연인에게 선물해주세요 :)"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .craneArrived: return "열어보기"
        case .presentCrane: return "네, 선물할게요!"
        case .fullBottle: return "네, 알겠어요!"
        }
    }
}



struct PresentAlertView: View {
    
    let alertType: Present
    let buttonAction: ()->Void = {}
    @Binding var showAlert: Bool
    @State var showTouchCraneAlert = false
    
    var body: some View {
        if showAlert {
            ZStack {
                AlertBackGroundView()
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.gray3)
                        .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(358))
                        .overlay {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.tertiaryLabel)
                                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical, UIScreen.getHeight(15))
                            .padding(.horizontal, UIScreen.getWidth(15))
                        }
                    VStack(spacing: 0) {
                        Image(Assets.shakingBottle)
                            .resizable()
                            .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(108))
                        Text(alertType.title)
                            .foregroundColor(.primaryLabel)
                            .font(Font.title3font())
                            .padding(.top, UIScreen.getHeight(35))
                        Text(alertType.message)
                            .foregroundColor(.secondaryLabel)
                            .font(Font.footnotefont())
                            .multilineTextAlignment(.center)
                            .lineSpacing(UIScreen.getHeight(5))
                            .padding(.top, UIScreen.getHeight(22))
                        Button {
                            switch alertType {
                                //todo : present와 arrive의 케이스가 변경되어있음
                            case .craneArrived:
                                self.showTouchCraneAlert.toggle()
                            case .presentCrane:
                                NotificationCenter.default.post(name: Notification.Name("successPresent"), object: nil)
                                self.showAlert.toggle()
                            case .fullBottle:
                                self.showAlert.toggle()
                            }
                        } label: {
                            Text(alertType.buttonTitle)
                                .foregroundColor(.gray3)
                                .font(Font.bodyfont())
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
                if showTouchCraneAlert {
                    TouchCraneAlertView(showAlert: $showAlert)
                        .transition(.opacity.animation(.easeIn))
                }
            }
        }
    }
}



