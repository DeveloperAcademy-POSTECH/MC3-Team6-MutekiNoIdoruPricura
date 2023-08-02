//
//  CoupleSuccessView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/28.
//

import SwiftUI
struct CoupleSuccessView: View {
    var body: some View {
        VStack{
            Image(Assets.connectbottle)
                .resizable()
                .frame(width: UIScreen.getWidth(60),height: UIScreen.getHeight(90))
            Group {
                Text(UserInfo.shared.nickName) +
                Text(" X ").foregroundColor(.secondaryLabel) +
                Text(UserInfo.shared.partnerNickName)
            }
            .foregroundColor(.primaryLabel)
            .font(UserInfo.shared.partnerNickName.count > 5 || UserInfo.shared.nickName.count > 5 ? Font.bodyfont() : Font.title3font())
            .padding(.top, UIScreen.getHeight(33))
            .padding(.bottom, UIScreen.getHeight(10))
            Text("연인 연결이 되었어요!")
                .foregroundColor(.primaryLabel)
                .font(Font.bodyfont())
        }
        .padding(.vertical,40)
        .frame(maxWidth: .infinity)
        .background(Color.gray3)
        .cornerRadius(18)
        .padding(.horizontal,53)
    }
}
