//
//  NoWriteView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct NoWriteView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var writeLetterButtonTapped = false
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea()
            
            VStack {
                Image(Assets.noWriteCrane)
                    .resizable()
                    .frame(width: UIScreen.getWidth(206), height: UIScreen.getHeight(158))
                
                VStack(spacing: 8) {
                    Text("아직 연인에게")
                    Text("쓴 쪽지가 없어요!")
                }
                .foregroundColor(.white)
                
                Button {
                    dismiss()
                    writeLetterButtonTapped.toggle()
                } label: {
                    Text("쪽지 작성하기")
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
        .fullScreenCover(isPresented: $writeLetterButtonTapped) {
            WriteView(isShowingCurrentPage: $writeLetterButtonTapped, color: "pink")
        }
    }
}

struct NoWriteView_Previews: PreviewProvider {
    static var previews: some View {
        NoWriteView()
    }
}
