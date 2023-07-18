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
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Color.backGround)
                    .ignoresSafeArea()
                VStack {
                    Text("to. \(partnerName)")
                        .padding()
                        .foregroundColor(.fontGray)
                    Text("\(letterCount)")
                        .foregroundColor(.white)
                    ZStack {
                        GeometryReader { proxy in
                            SpriteView(scene: makeScean())
                        }
                        .cornerRadius(20)
                        .padding()
                        Image(Assets.bottle)
                            .resizable()
                            .aspectRatio(CGSize(width: 1, height: 1.653), contentMode: .fit)
                    }
                    .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.54)
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: CGSize.deviceWidth * 0.8)
                        .offset(y: CGSize.deviceHeight * 0.1)
                        .padding(.top)
                        .ignoresSafeArea()
                }
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("hi")
                        } label: {
                            Image(Assets.inbox)
                        }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("hi")
                        } label: {
                            Image(Assets.send)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("hi")
                        } label: {
                            Image(Assets.setting)
                        }
                    }
                }
            }
        }
    }
    
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
