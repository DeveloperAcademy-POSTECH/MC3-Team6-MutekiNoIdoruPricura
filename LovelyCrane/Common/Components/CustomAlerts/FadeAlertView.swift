//
//  FadeAlert.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/29.
//

import SwiftUI

struct FadeAlertView: View {
    
    @Binding var showAlert: Bool
    @Binding var alertMessage: String

    
    var body: some View {
        VStack {
            if showAlert {
                VStack(spacing: 0) {
                    Image(Assets.bigStrokeCrane)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.getWidth(73.35), height: UIScreen.getHeight(63.98))
                    Text(alertMessage)
                        .foregroundColor(.primaryLabel)
                        .padding(.top, 23)
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray3)
                        .frame(width: UIScreen.getWidth(262), height: UIScreen.getHeight(200))
                )
            }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.showAlert = false
            }
        }
    }
    
}

//struct FadeAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        FadeAlertView()
//    }
//}
