//
//  RootView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

// MARK: 로그인 여부를 확인하고, 메인뷰로 진입하기 위한 루트뷰입니다.
struct RootView: View {
    
    @State private var showSignInView: Bool = true

    var body: some View {
        ZStack {
            if !showSignInView {
                //닉네임 등록했는지 확인
                //문서 접근해서 닉네임 필드가 비어있다면? 닉네임 입력뷰로
//                NavigationStack {
                    MainView(showSignInView: $showSignInView)
//                    NickNameView()
//                }
            } else {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            //이미있는 경우
            self.showSignInView = authUser == nil ? true : false
        }
//        .fullScreenCover(isPresented: $showSignInView) {
//            NavigationStack {
//                AuthenticationView( showSignInView: $showSignInView)
//            }#imageLiteral(resourceName: "simulator_screenshot_F654B328-1F29-4755-84FB-87D09BDB82AE.png")
//        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
