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
            Text("직녀 X 견우")
                .padding(.bottom, 26)
                .foregroundColor(.primaryLabel)
            Text("연인 연결이 되었어요!")
                .foregroundColor(.primaryLabel)
        }
        .padding(.vertical,40)
        .frame(maxWidth: .infinity)
        .background(Color.gray3)
        .cornerRadius(18)
        .padding(.horizontal,53)
    }
}
