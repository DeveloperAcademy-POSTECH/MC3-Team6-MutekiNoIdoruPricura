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
    1. 데이터 싱글톤으로 할거면 만들어두기
    2. 이미지에서 학 배수 맞는지 물어보기(지금도 해상도 너무 높음)
    3. 모달뷰 만들어서 해야하나요? 질문하고 (만들기)
    4.
 */


struct MainView: View {
    let coreMotionManager = MotionManager.shared
    @State var partnerName = "직녀"
    @State var letterCount = 912
    @State var isWriteHistroyTapped = false
    @State var isWriteTapped = false
    @State var isSettingTapped = false
    @EnvironmentObject var viewRouter : ViewRouter
    @State var presentStrings: [String] = ["선", "물", "하", "기"]
    
    //todo: 여기부터는 목업데이터 입니다. 네트워크를 통해서 받아온 정보값을 추가해야해요
    //싱글톤 객체 써도 되는데 그럼 environmentObject로 계속보내주는게 맞음.
    // 전체 레터 카운트가 0 일때는 쪽지쓰기 안내
    // 전체 레터 카운트는 존재하는데 보낼 쪾지가 0이면 모두선물했어요 기록보기
    // 그게 아니라면 스프라이트 뷰
    @State var letterNumber = 0
    @State var needToSentLetter = 1
    //만약 연결안되어있으면
    @State var isConnection = false
    @State var receiveLetterCount = 0
    
    
    
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingButton()
                }
            }
        }

    }

    //MARK: - Views
    private func settingButton() -> some View {
        NavigationLink {
            SettingView2()
        } label: {
            Image(Assets.setting)
        }
    }
    private func presentedBottle() -> some View {
        ZStack {
            VStack {
                Text("from. \(partnerName)")
                    .foregroundColor(.secondaryLabel)
                    .padding(.top)
                Text("\(letterCount)")
                    .foregroundColor(.primaryLabel)
                    .font(.system(size: 50))
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
                                Text("\($0)").font(.system(size: 14))
                                    .foregroundColor(isSendButtonActivate() ? .defaultWhite : .gray5)
                            }
                        }
                    }
                Spacer()
                Image(Assets.doubleChevronRight)
                    .resizable()
                    .foregroundColor(Color.gray4)
                    .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
                    .padding(.trailing)
            }
            VStack {
                Text("to. \(partnerName)")
                    .foregroundColor(.secondaryLabel)
                    .padding(.top)
                Text("\(letterCount)")
                    .foregroundColor(.primaryLabel)
                    .font(.system(size: 50))
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
                print(LetterLists.shared.letterListArray)
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
            if letterNumber == 0, needToSentLetter > 0 {
                SpriteView(scene: makeScean())
                    .cornerRadius(20)
                    .padding()
                    .frame(width: UIScreen.getWidth(246), height: UIScreen.getHeight(360))
                    .onTapGesture {
                        isWriteHistroyTapped.toggle()
                    }
                }
        }
        .overlay {
            if letterNumber == 0, needToSentLetter == 0 {
                Text("아래의 + 버튼을 눌러서\n연인을 향한 첫번째\n종이학 쪽지를 써보세요 :)")
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        isWriteTapped.toggle()
                    }
            }
            else if letterNumber > 0, needToSentLetter == 0 {
                VStack {
                    Text("종이학을 모두 선물했어요!")
                    Text("기록 보기").foregroundColor(.deepPink)
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
            if isConnection, receiveLetterCount > 0 {
                SpriteView(scene: makeScean())
                    .cornerRadius(20)
                    .padding()
                    .frame(width: UIScreen.getWidth(246), height: UIScreen.getHeight(360))
                    .onTapGesture {
                        isWriteHistroyTapped.toggle()
                    }
                }
        }
        .overlay {
            //MARK: - 디테일뷰가 아니라 커플링뷰로 연결해둬야함
            if !isConnection {
                VStack {
                    Text("연인 연결 후\n쪽지를 받을수 있어요!")
                        .multilineTextAlignment(.center)
                    NavigationLink {
                        DetailView()
                    } label: {
                        Text("연인 연결하기")
                            .foregroundColor(Color.deepPink)
                            .padding(.top)
                    }
                }
            }
            else if isConnection, receiveLetterCount == 0 {
                Text("아직 연인에게\n선물받은 편지가 없어요!")
                    .multilineTextAlignment(.center)
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
                    .offset(y: CGSize.deviceHeight * 0.03)
                    .foregroundColor(Color.gray4)
            }
            .fullScreenCover(isPresented: $isWriteTapped) {
                WriteView(isShowingCurrentPage: $isWriteTapped, color: randomCrane.1)
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
    
    private func isSendButtonActivate() -> Bool {
        if isConnection, needToSentLetter > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    
}


struct View_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
