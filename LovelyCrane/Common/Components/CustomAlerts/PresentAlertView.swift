//
//  CouplingAlertView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/30.
//

import SwiftUI

struct PresentAlertView: View {
    @Binding var title: String
    @Binding var message: String
    @Binding var buttonTitle: String
    @Binding var buttonAction: ()->Void
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
                        Text(title)
                            .foregroundColor(.primaryLabel)
                            .font(.system(size: 24, weight: .regular))
                            .padding(.top, 35)
                        Text(message)
                            .foregroundColor(.secondaryLabel)
                            .font(.system(size: 16, weight: .regular))
                            .multilineTextAlignment(.center)
                            .padding(.top, 22)
                        Button(action: buttonAction){
                            Text(buttonTitle)
                                .foregroundColor(.gray3)
                                .padding(.vertical, 16.5)
                                .padding(.horizontal, 34)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.lightPink)
                                )
                            
                        }
                        .padding(.top, 28)
                    }
                }
                Button(action: {
                    showAlert.toggle()
                }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.tertiaryLabel)
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
        
            }
        }
    }
}

//struct PresentAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        PresentAlertView()
//    }
//}
