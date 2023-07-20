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
    @State var isReceiveHistroyTapped = false
    @State var isSettingTapped = false
    @State var isWriteTapped = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("", destination: WriteHistoryView(), isActive: $isWriteHistroyTapped)
                NavigationLink("", destination: SettingView(), isActive: $isSettingTapped)
                NavigationLink("", destination: CouplingView(), isActive: $isReceiveHistroyTapped)
                backGround()
                VStack {
                    Spacer()
                    Text("to. \(partnerName)")
                        .padding()
                        .foregroundColor(.fontGray)
                    Text("\(letterCount)")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                    spriteView()
                    Spacer()
                    bottomWriteButton()
                }
                .navigationTitle("")
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
    }

//MARK: - Views
    func backGround() -> some View {
        Color(Color.backGround)
            .ignoresSafeArea()
    }
    
    func settingButton() -> some View {
        Button {
            isSettingTapped.toggle()
        } label: {
            Image(Assets.setting)
        }
    }
    
    func sendButton() -> some View {
        Button {
            print("hi")
        } label: {
            Image(Assets.send)
        }
    }
    func inboxButton() -> some View {
        Button {
            isReceiveHistroyTapped.toggle()
        } label: {
            Image(Assets.inbox)
        }
    }
    
    func spriteView() -> some View {
        SpriteView(scene: makeScean())
        .cornerRadius(20)
        .padding()
        .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.54)
        .onTapGesture {
            isWriteHistroyTapped.toggle()
        }
    }
    
    func bottomWriteButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: CGSize.deviceWidth * 0.8)
            .offset(y: CGSize.deviceHeight * 0.048)
            .ignoresSafeArea()
            .onTapGesture {
                isWriteTapped.toggle()
            }
            .fullScreenCover(isPresented: $isWriteTapped) {
                WriteView(isShowingCurrentPage: $isWriteTapped)
            }
    }
//MARK: - methods
    func makeScean() -> SKScene {
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
