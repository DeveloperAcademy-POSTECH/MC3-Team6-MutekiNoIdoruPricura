//
//  FadeAlert.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/29.
//

import SwiftUI

enum FadeAlert: String {
    case nickNameSaved, presentCrane, savePaper
    var message: String {
        switch self {
        case .presentCrane: return "종이학을 선물했어요"
        case .nickNameSaved: return "닉네임이 저장되었어요"
        case .savePaper: return "쪽지가 저장되었어요."
        }
    }
}


struct FadeAlertView: View {
    
    @Binding var showAlert: Bool
    let alertType: FadeAlert
    
    var body: some View {
        if showAlert {
            ZStack{
                Color.overLay.ignoresSafeArea()

                VStack {
                    VStack {
                        Image(Assets.bigStrokeCrane)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.getWidth(73.35), height: UIScreen.getHeight(63.98))
                        Text(alertType.message)
                            .foregroundColor(.primaryLabel)
                            .font(Font.headlinefont())
                            .padding(.top, UIScreen.getHeight(23))
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray3)
                            .frame(width: UIScreen.getWidth(262), height: UIScreen.getHeight(200))
                    )
                }
            }
            .ignoresSafeArea()
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.showAlert = false
                    }
                }
            }
        }
    }
}
