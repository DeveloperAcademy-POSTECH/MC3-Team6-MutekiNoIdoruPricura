//
//  EnlargedImageView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/25.
//

import SwiftUI

// WriteView 또는 DetailView에서 이미지를 Tap 했을때 등장하는 이미지가 확대된 fullScreenView 입니다.

struct EnlargedImageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack(alignment: .leading){
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
            
            VStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark")
                        .foregroundColor(.fontGrayColor)
                        .frame(width: 20, height: 20)
                }
                .padding(.top, 16)
                .padding(.leading, 28)
                
                Spacer()
            }
        }
    }
    
}

