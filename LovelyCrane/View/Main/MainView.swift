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
    // MARK: 수신 발신 시나리오 테스트 시 카운트를 변경
    // 카운트 리프레시는 수신 및 발신 작업 연결 단계에서 수행해 주세요.
    @State var letterCount = 1
    @State var receivedCount = 1
    
    @State var writeHistroyTapped = false
    @State var noWriteHistoryTapped = false
    
    @State var noReceivedTapped = false
    @State var receivedHistoryTapped = false
    
    @State var toWriteTapped = false
    @State var settingTapped = false
    
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ZStack {
            NavigationLink("", destination: NoWriteView(), isActive: $noWriteHistoryTapped)
            NavigationLink("", destination: WriteHistoryView(), isActive: $writeHistroyTapped)
            
            NavigationLink("", destination: NoReceivedView(), isActive: $noReceivedTapped)
            NavigationLink("", destination: ReceivedHistoryView(), isActive: $receivedHistoryTapped)

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
                    Image(systemName: "gift")
                        .onTapGesture {
                            if receivedCount == 0 {
                                noReceivedTapped.toggle()
                            } else {
                                receivedHistoryTapped.toggle()
                            }
                        }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    sendButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingButton()
                }
            }
//            .fullScreenCover(isPresented: $firsttap) {
//                CouplingView(isOpen: $firsttap)
//            }
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
                .foregroundColor(.secondaryLabel)
                .padding(.top)
            Text("\(letterCount)")
                .foregroundColor(.primaryLabel)
                .font(.system(size: 50))
            spriteView()
            Spacer()
        }
    }
    
    private func mainBottle() -> some View {
        VStack {
            Text("to. \(partnerName)")
                .foregroundColor(.secondaryLabel)
                .padding(.top)
            Text("\(letterCount)")
                .foregroundColor(.primaryLabel)
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
                
                if letterCount == 0 {
//                if LetterListsManager.shared.isByMeLetters.count == 0 {
                    noWriteHistoryTapped.toggle()
                } else {
                    writeHistroyTapped.toggle()
                }
            }
        } label: {
            Image(Assets.send)
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
                    Task{
                        try await UserManager.shared.getAllLetterData()
                        // MARK: 편지 발송 이후 letterCount를 0으로 바꿔줘야 합니다.+ 저장
                        if letterCount == 0 {
//                        if LetterListsManager.shared.isByMeLetters.count == 0 {
                            noWriteHistoryTapped.toggle()
                        } else {
                            writeHistroyTapped.toggle()
                        }
                    }
                }
        }
        .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.54)
    }
    
    //Todo: 랜덤하게 fill 컬러 추가해주고, 해당 컬러에 맞는 크레인 명을 color로 보내주어야 함
    private func bottomWriteButton() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.deepPink)
            .frame(width: CGSize.deviceWidth * 0.8)
            .offset(y: CGSize.deviceHeight * 0.08)
            .ignoresSafeArea()
            .onTapGesture {
                toWriteTapped.toggle()
            }
            .fullScreenCover(isPresented: $toWriteTapped) {
                WriteView(isShowingCurrentPage: $toWriteTapped, color: "pink")
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

extension MainView {
    func fetchData() async {
        let sentLetters = LetterListsManager.shared.sentLettersGroupedByDate
        let notSentLetters = LetterListsManager.shared.notSentLettersGroupedByDate
    }
}
