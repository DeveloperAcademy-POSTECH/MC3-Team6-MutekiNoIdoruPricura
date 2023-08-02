//
//  MainView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI
import SpriteKit
import CoreMotion

/* todo -
    1. 천개
 */


struct MainView: View {
    let coreMotionManager = MotionManager.shared
    @StateObject var userInfo = UserInfo.shared
    @State private var isWriteHistroyTapped = false
    @State private var isReceiveHistroyTapped = false
    @State private var isWriteTapped = false
    @State private var isSettingTapped = false
    @State private var isCoupleingTapped = false
    @State private var showPresentAlert = false
    @State private var isPresented = false
    @State private var isConnectFirst = false
    @State private var isReceiveLetters = false
    @State private var presentStrings: [String] = ["선", "물", "하", "기"]
    @State private var selection = 0
    @EnvironmentObject var viewRouter : ViewRouter
    
    
    let presentCenter = NotificationCenter.default.publisher(for: Notification.Name("present"))
    let updateCenter = NotificationCenter.default.publisher(for: Notification.Name("update"))
    let successPresentCenter = NotificationCenter.default.publisher(for: Notification.Name("successPresent"))
    let openCenter = NotificationCenter.default.publisher(for: Notification.Name("open"))
    let partnerConnectCenter = NotificationCenter.default.publisher(for: Notification.Name("connectPartner"))
    let receiveLetterCenter = NotificationCenter.default.publisher(for: Notification.Name("receiveLetter"))
    
    var body: some View {
        ZStack {
            NavigationLink("", destination: WriteHistoryView(), isActive: $isWriteHistroyTapped)
            NavigationLink("", destination: ReceivedHistoryView(), isActive: $isReceiveHistroyTapped)
            BackGroundView()
            TabView(selection: $selection) {
                mainBottle()
                    .tag(0)
                presentedBottle()
                    .tag(1)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            .menuIndicator(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingButton()
                }
            }
            .onReceive(openCenter) { _ in
                withAnimation(.easeIn(duration: 1)) {
                    self.selection = 1
                }
            }
            .onReceive(presentCenter) { _ in
                self.showPresentAlert.toggle()
            }
            .onReceive(updateCenter) { _ in
                Task{
                    try await UserManager.shared.getmyUserData()
                }
            }
            .onReceive(successPresentCenter) { _ in
                isPresented.toggle()
            }
            .onReceive(partnerConnectCenter) { _ in
                isConnectFirst.toggle()
            }
            .onReceive(receiveLetterCenter) { _ in
                isReceiveLetters.toggle()
            }
            if isReceiveLetters {
                PresentAlertView(alertType: .craneArrived, showAlert: $isReceiveLetters)
                    .transition(.opacity.animation(.easeIn))
            }
            if isConnectFirst {
                CouplingAlertView(showAlert: $isConnectFirst)
                    .transition(.opacity.animation(.easeIn))
            }
            if showPresentAlert {
                PresentAlertView(alertType: .presentCrane, showAlert: $showPresentAlert)
                    .transition(.opacity.animation(.easeIn))
            }
            if isPresented {
                FadeAlertView(showAlert: $isPresented, alertType: .presentCrane)
                    .transition(.opacity.animation(.easeIn))
            }
        }
        .onAppear {
            UserManager.shared.listenConnectPartner()
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
        ZStack {
            VStack {
                Text("받은 쪽지")
                    .font(Font.headlinefont())
                    .foregroundColor(.secondaryLabel)
                    .padding(.top)
                Text("\(userInfo.receiveLetterCount)")
                    .foregroundColor(.primaryLabel)
                    .font(Font.title1font())
                receiveSpriteView(bottle: Assets.redBottle)
                Spacer()
            }
            HStack {
                Image(Assets.doubleChevronLeft)
                    .resizable()
                    .foregroundColor(Color.gray4)
                    .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
                    .padding(.leading)
                Spacer()
            }
        }
    }
    
    private func mainBottle() -> some View {
        ZStack {
            HStack {
                NavigationLink {
                    PresentAlertView(alertType: .presentCrane, showAlert: $showPresentAlert)
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray4)
                        .frame(width: UIScreen.getWidth(44), height: UIScreen.getHeight(134))
                        .overlay {
                            VStack {
                                Image(Assets.send)
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                    .foregroundColor(isSendButtonActivate() ? .deepPink : .gray5)
                                ForEach(presentStrings, id: \.self) {
                                    Text("\($0)")
                                        .font(Font.bodyfont())
                                        .foregroundColor(isSendButtonActivate() ? .defaultWhite : .gray5)
                                }
                            }
                            .offset(x: UIScreen.getWidth(2))
                            .onTapGesture {
                                if !userInfo.isConnection() {
                                    isCoupleingTapped.toggle()
                                }
                                else {
                                    showPresentAlert.toggle()
                                }
                            }
                            .fullScreenCover(isPresented: $isCoupleingTapped) {
                                CouplingView(isOpen: $isCoupleingTapped)
                            }
                        }
                        .offset(x: UIScreen.getWidth(-7))
                }
                .disabled(!isSendButtonActivate())

                Spacer()
                Image(Assets.doubleChevronRight)
                    .resizable()
                    .foregroundColor(Color.gray4)
                    .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
                    .padding(.trailing)
            }
            VStack {
                Text("보낼 쪽지")
                    .font(Font.headlinefont())
                    .foregroundColor(.secondaryLabel)
                    .padding(.top)
                Text("\(userInfo.notSendLetterCount)")
                    .foregroundColor(.primaryLabel)
                    .font(Font.title1font())
                spriteView(bottle: Assets.bottle)
                Spacer()
                bottomWriteButton()
            }
        }
    }
    
    private func sendButton() -> some View {
        Button {
            Task{
                try await UserManager.shared.getAllLetterData()
//                print(LetterLists.shared.letterListArray)
            }
        } label: {
            Image(Assets.send)
        }
    }
    
    private func spriteView(bottle: String) -> some View {
        ZStack(alignment: .bottom) {
            Image(bottle)
                .resizable()
                .frame(width: UIScreen.getWidth(242), height: UIScreen.getHeight(400))
            if userInfo.notSendLetterCount > 0 {
                SpriteView(scene: makeScean(letterCount: userInfo.notSendLetterCount))
                    .cornerRadius(20)
                    .padding()
                    .frame(width: UIScreen.getWidth(246), height: UIScreen.getHeight(360))
                    .onTapGesture {
                        Task {
                            try await UserManager.shared.getAllLetterData()
                            isWriteHistroyTapped.toggle()
                        }
                    }
                }
        }
        .overlay {
            if userInfo.sendLetterCount == 0, userInfo.notSendLetterCount == 0 {
                NavigationLink {
                    NoWriteView()
                } label: {
                    Text("아래의 + 버튼을 눌러서\n연인을 향한 첫번째\n종이학 쪽지를 써보세요 :)")
                        .font(Font.bodyfont())
                        .lineSpacing(UIScreen.getHeight(5))
                        .foregroundColor(Color.defaultWhite)
                        .multilineTextAlignment(.center)
                }

            }
            else if userInfo.sendLetterCount > 0, userInfo.notSendLetterCount == 0 {
                VStack {
                    Text("종이학을 모두 선물했어요!")
                        .font(Font.bodyfont())
                        .foregroundColor(Color.defaultWhite)
                        .padding(.bottom)
                    Button {
                        Task {
                            try await UserManager.shared.getAllLetterData()
                            isWriteHistroyTapped.toggle()
                        }
                    } label: {
                        Text("기록 보기")
                            .foregroundColor(.deepPink)
                            .font(Font.headlinefont())
                    }

                }
            }
        }
        .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.57)
    }
    
    private func receiveSpriteView(bottle: String) -> some View {
        ZStack(alignment: .bottom) {
            Image(bottle)
                .resizable()
                .frame(width: UIScreen.getWidth(242), height: UIScreen.getHeight(400))
            if userInfo.isConnection(), userInfo.receiveLetterCount > 0 {
                SpriteView(scene: makeScean(letterCount: userInfo.receiveLetterCount))
                    .cornerRadius(20)
                    .padding()
                    .frame(width: UIScreen.getWidth(246), height: UIScreen.getHeight(360))
                    .onTapGesture {
                        Task {
                            try await UserManager.shared.getAllLetterData()
                            isReceiveHistroyTapped.toggle()
                        }

                    }
                }
        }
        .overlay {
            //MARK: - 디테일뷰가 아니라 커플링뷰로 연결해둬야함
            if !userInfo.isConnection() {
                VStack {
                    Text("연인 연결 후\n쪽지를 받을수 있어요!")
                        .lineSpacing(UIScreen.getHeight(5))
                        .foregroundColor(Color.defaultWhite)
                        .multilineTextAlignment(.center)
                        .font(Font.bodyfont())
                    Text("연인 연결하기")
                        .foregroundColor(Color.deepPink)
                        .font(Font.headlinefont())
                        .padding(.top)
                        .onTapGesture {
                            isCoupleingTapped.toggle()
                        }
                        .fullScreenCover(isPresented: $isCoupleingTapped) {
                            CouplingView(isOpen: $isCoupleingTapped)
                        }
                }
            }
            else if userInfo.isConnection(), userInfo.receiveLetterCount == 0 {
                NavigationLink {
                    NoReceivedView()
                } label: {
                    Text("아직 연인에게\n선물받은 편지가 없어요!")
                        .lineSpacing(UIScreen.getHeight(5))
                        .font(Font.bodyfont())
                        .foregroundColor(Color.defaultWhite)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(width: CGSize.deviceWidth * 0.8, height: CGSize.deviceHeight * 0.57)
    }
    
    private func bottomWriteButton() -> some View {
        let randomCrane = Assets.crans.randomElement()!.colors
        return RoundedRectangle(cornerRadius: 20)
            .fill(randomCrane.0)
            .frame(width: CGSize.deviceWidth * 0.9)
            .offset(y: CGSize.deviceHeight * 0.05)
            .ignoresSafeArea()
            .onTapGesture {
                isWriteTapped.toggle()
            }
            .overlay {
                Text("+ 새로운 쪽지 작성하기")
                    .font(Font.headlinefont())
                    .offset(y: CGSize.deviceHeight * 0.02)
                    .foregroundColor(Color.gray4)
            }
            .fullScreenCover(isPresented: $isWriteTapped) {
                WriteView(isShowingCurrentPage: $isWriteTapped, color: randomCrane.1)
            }
    }
    //MARK: - methods
    private func makeScean(letterCount: Int) -> SKScene {
        let size = CGSize(width: CGSize.deviceWidth * 0.7, height: CGSize.deviceHeight * 0.7)
        let scene = SpriteScene(size: size, letterCount: letterCount)
        scene.motionManager = coreMotionManager
        scene.scaleMode = .resizeFill
        return scene
    }
    
    private func isSendButtonActivate() -> Bool {
        if userInfo.notSendLetterCount > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    private func showAlert() {
        self.showPresentAlert.toggle()
    }
}



struct View_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
