//
//  ReceiveConnectView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/28.
//

import SwiftUI
struct ReceiveConnectView: View {
    var body: some View {
        VStack {
            Text("From.")
            Image(Assets.receiveConnect)
                .frame(width: UIScreen.getWidth(72),height: UIScreen.getHeight(30))
                .padding(.bottom,24)
            Text("연인 연결이 도착했어요!\n연결 후에 종이학을 받아보세요 :)")
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryLabel)
            Spacer()
  
        }
    }
}
