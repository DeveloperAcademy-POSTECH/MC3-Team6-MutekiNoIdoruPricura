//
//  NoReceivedView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/28.
//

import SwiftUI

struct NoReceivedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(Assets.noReceivedViewImage)
                    .resizable()
                    .frame(width: UIScreen.getWidth(206), height: UIScreen.getHeight(158))
                
                VStack(spacing: 8) {
                    Text("아직 연인에게")
                    Text("선물받은 쪽지가 없어요!")
                }
                .font(.headlinefont())
                .foregroundColor(.white)
                
                Button {
                    dismiss()
                    
                } label: {
                    Text("메인으로 가기")
                        .font(.headlinefont())
                        .foregroundColor(.lightPink)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .padding(.trailing, 15)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

struct NoReceivedView_Previews: PreviewProvider {
    static var previews: some View {
        NoReceivedView()
    }
}
