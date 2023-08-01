//
//  FadeAlert.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/29.
//

import SwiftUI

struct FadeAlertView: View {
    
    @Binding var showAlert: Bool
    let alertMessage: FadeAlertMessage = .nickNameSaved

    var body: some View {
        ZStack{
            AlertBackGroundView()
            VStack {
                if showAlert {
                    VStack {
                        Image(Assets.bigStrokeCrane)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.getWidth(73.35), height: UIScreen.getHeight(63.98))
                        Text(alertMessage.rawValue)
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

enum FadeAlertMessage: String {
    case nickNameSaved = "닉네임이 저장되었어요"
    case presentCrane = "종이학을 선물했어요"
    case savePaper = "쪽지가 저장되었어요."
}

struct FadeAlertView_Previews: PreviewProvider {
    
    static var previews: some View {
        FadeAlertView(showAlert: .constant(true))
    }
}
