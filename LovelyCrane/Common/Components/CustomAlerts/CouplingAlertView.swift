//
//  PresentAlert.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/29.
//

import SwiftUI

struct CouplingAlertView: View {
    @Binding var myName: String
    @Binding var partnerName: String
    @Binding var showAlert: Bool
    
    var body: some View {
        if showAlert {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray3)
                    .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(358))
                VStack(spacing: 0) {
                    Image(Assets.heartBottle)
                        .resizable()
                        .frame(width: UIScreen.getWidth(37), height: UIScreen.getHeight(75))
                    Group {
                        Text(myName) +
                        Text(" X ").foregroundColor(.secondaryLabel) +
                        Text(partnerName)
                    }
                    .foregroundColor(.primaryLabel)
                    .font(.system(size: partnerName.count > 5 || myName.count > 5 ? 18 : 24, weight: .regular))
                    .padding(.top, 17)
                    Text("연인 연결이 되었어요!")
                        .foregroundColor(.secondaryLabel)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.top, 26)
                    Button(action: {
                        showAlert = false
                    }){
                        Text("확인")
                            .foregroundColor(.gray3)
                            .padding(.vertical, 16.5)
                            .padding(.horizontal, 34)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.lightPink)
                            )
                        
                    }
                    .padding(.top, 50)
                }
            }
        }
    }
}

//struct CouplingAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        CouplingAlertView()
//    }
//}
