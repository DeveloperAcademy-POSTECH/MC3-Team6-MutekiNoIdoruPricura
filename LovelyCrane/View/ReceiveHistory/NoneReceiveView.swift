//
//  NoneReceiveView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/28.
//

import SwiftUI
struct NoneReceiveView: View {
    var body: some View {
        VStack{
            Spacer()
            CoupleSuccessView()
            Spacer()
            Text("종이학 선물이 도착하면\n알려드릴께요 :)")
                .padding(.bottom,34)
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryLabel)
            Button(action: {
                // TODO: - 버튼눌렀을때 다시 메인뷰로 가도록
            }){
                Text("네! 알겠어요")
                    .foregroundColor(.gray1)
                    .padding(.vertical,16)
                    .frame(maxWidth: .infinity)
                    .background(Color.lightPink)
                    .cornerRadius(8)
            }
            .padding(.bottom,52)
            .padding(.horizontal,24)

        }
        .background(Color.backGround)
    }
}

struct NoneReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        NoneReceiveView()
    }
}
