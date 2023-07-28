//
//  Gray3Button.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/28.
//

import SwiftUI
struct ToastAlert: View {
    var label: String
    @State var istouched = false
    var body: some View {
        Text(label)
            .foregroundColor(.primaryLabel)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.black)
            .multilineTextAlignment(.center)
            .cornerRadius(8)
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            .padding(.horizontal,30)
//            .padding(.vertical,16)
    }
}
