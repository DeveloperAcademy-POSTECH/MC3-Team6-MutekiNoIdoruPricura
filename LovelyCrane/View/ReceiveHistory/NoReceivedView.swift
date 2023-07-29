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
            
            VStack {
                Image(Assets.noReceivedViewImage)
                
                VStack(spacing: 8) {
                    Text("아직 연인에게")
                    Text("선물받은 쪽지가 없어요!")
                }
                .foregroundColor(.white)
                
                Button {
                    dismiss()
                    
                } label: {
                    Text("메인으로 가기")
                        .foregroundColor(.lightPink)
                }
                .padding(.top, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
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
