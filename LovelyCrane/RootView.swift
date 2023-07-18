//
//  RootView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

// MARK: 로그인 여부를 확인하고, 메인뷰로 진입하기 위한 루트뷰입니다.
struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        
        ZStack {
            if !showSignInView {
                NavigationStack {
//                    Text("메인 뷰")
                    SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
