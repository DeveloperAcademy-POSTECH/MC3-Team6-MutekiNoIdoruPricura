//
//  MainView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI
import SpriteKit
import CoreMotion


struct MainView: View {
    let coreMotionManager = MotionManager.shared
    @State var partnerName = "직녀"
    @State var letterCount = 912
    @State var isWriteHistroyTapped = false
    @State var isWriteTapped = false
    @State var isSettingTapped = false
    
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack {
            NavigationLink("", destination: WriteHistoryView(), isActive: $isWriteHistroyTapped)
            BackGroundView()
            TabView {
                mainBottle()
                    .tag(0)
                presentedBottle()
                    .tag(1)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            .menuIndicator(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    inboxButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    sendButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingButton()
                }
            }
        }

    }

    //MARK: - Views
    private func settingButton() -> some View {
        NavigationLink {
            SettingView()
        } label: {
            Image(Assets.setting)
        }
    }
    private func presentedBottle() -> some View {
        VStack {
            Text("to. \(partnerName)")
                .foregroundColor(.fontGray)
                .padding(.top)
            Text("\(letterCount)")
                .foregroundColor(.white)
                .font(.system(size: 50))
            spriteView()
            Spacer()
        }
    }
    
    private func mainBottle() -> some View {
        VStack {
            Text("to. \(partnerName)")
                .foregroundColor(.fontGray)
                .padding(.top)
            Text("\(letterCount)")
                .foregroundColor(.white)
                .font(.system(size: 50))
            spriteView()
            Spacer()
            bottomWriteButton()
        }
    }
    
    private func sendButton() -> some View {
        Button {
            Task{
                try await UserManager.shared.getAllLetterData()
                print(LetterLists.shared.letterListArray)
            }
        } label: {
            Image(Assets.send)
        }
    }
    private func inboxButton() -> some View {
        NavigationLink {
            ReciveHistoryView()
        } label: {
            Image(Assets.inbox)
        }
        
    }
    
    private func spriteView() -> some View {
        ZStack(alignment: .bottom) {
            Image(Assets.bottle)
                .resizable()
            SpriteView(scene: makeScean())
                .cornerRadius(20)
                .padding()
                .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.5)
                .mask(Image(Assets.bottleIn).resizable().frame(height: CGSize.deviceHeight * 0.51))
                .onTapGesture {
                    isWriteHistroyTapped.toggle()
                }
        }
        .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.54)
    }
    
    //Todo: 랜덤하게 fill 컬러 추가해주고, 해당 컬러에 맞는 크레인 명을 color로 보내주어야 함
    private func bottomWriteButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.red)
            .frame(width: CGSize.deviceWidth * 0.8)
            .offset(y: CGSize.deviceHeight * 0.08)
            .ignoresSafeArea()
            .onTapGesture {
                isWriteTapped.toggle()
            }
            .fullScreenCover(isPresented: $isWriteTapped) {
                WriteView(isShowingCurrentPage: $isWriteTapped, color: "pink")
            }
            .overlay {
                Text("+ 새로운 쪽지 작성하기")
                    .offset(y: CGSize.deviceHeight * 0.03)
            }
    }
    //MARK: - methods
    private func makeScean() -> SKScene {
        let scene = SpriteScene()
        scene.motionManager = coreMotionManager
        scene.size = CGSize(width: CGSize.deviceWidth * 0.7, height: CGSize.deviceHeight * 0.7)
        scene.scaleMode = .resizeFill
        return scene
    }
    
    
    
}



struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
