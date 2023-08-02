//
//  LaunchScreenView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            ProgressView()
                .tint(.white)
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
