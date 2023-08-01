//
//  CouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct CouplingView: View {
    private let mycode = UserManager.shared.currentUserUID
    @State private var clickPasteBtn = false
    @State var isOpen = true
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    HStack{
                        closeButton()
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                            .padding(.leading,UIScreen.getWidth(26))
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        Spacer()
                        Text("연인연결하기")
                            .foregroundColor(.primaryLabel)
                            .font(Font.headlinefont())
                        Spacer()
                    }
                }
                .padding(.top,UIScreen.getHeight(20))
                ZStack{
                    VStack {
                        Spacer()
                        Image(Assets.couplingpaper)
                        Text("연인에게 종이학 편지를 받으려면 아래 코드로 연결해주세요")
                            .foregroundColor(.primaryLabel)
                            .font(Font.bodyfont())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, UIScreen.getWidth(80))
                            .padding(.bottom, UIScreen.getHeight(40))
                        codeSharingView()
                            .padding(.horizontal,UIScreen.getWidth(54))
                            .padding(.bottom,UIScreen.getHeight(10))
                        Spacer()
                        inputPartnerCodeButton()
                            .padding(.horizontal,UIScreen.getWidth(30))
                            .padding(.bottom,UIScreen.getHeight(10))
                            .overlay(
                                Group {
                                    if clickPasteBtn {
                                        ToastAlert(label: "코드가 복사 되었어요")
                                    }
                                }
                            )
                    }
                }
            }.background(Color.backGround)
        }
    }
    func closeButton() -> some View {
        Button(action: {
            isOpen = false
        }){
            Image(systemName: "xmark")
                .resizable()
                .foregroundColor(.tertiaryLabel)
                .frame(width: UIScreen.getWidth(20),height: UIScreen.getHeight(20))
        }
    }

    func codeSharingView() -> some View {
        VStack(spacing: 30){
            Text("나의 코드")
                .foregroundColor(.secondaryLabel)
                .font(Font.bodyfont())
            Text(mycode)
                .foregroundColor(.primaryLabel)
                .font(Font.title3font())
                .frame(width: UIScreen.getWidth(115),height: UIScreen.getHeight(15))
            Button {
                UIPasteboard.general.string = mycode
                withAnimation(.easeInOut(duration: 0.2)) {
                    clickPasteBtn.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    withAnimation(.easeInOut){
                        clickPasteBtn = false
                    }
                }
            } label: {
                Text("복사하기")
                    .foregroundColor(.lightPink)
                    .font(Font.bodyfont())
            }
            .padding(UIScreen.getHeight(10))
            ShareLink(item: mycode, preview: SharePreview(
                    Text("사랑의 종이학")
            )) {
                Text("링크로 알려주기")
                    .foregroundColor(.gray1 )
                    .padding(.horizontal,UIScreen.getWidth(34))
                    .padding(.vertical, UIScreen.getHeight(13))
                    .background(Color.lightPink)
                    .cornerRadius(8)
                    .font(Font.bodyfont())
            }
        }
        .padding(.vertical,40)
        .frame(maxWidth: .infinity)
        .background(Color.gray3)
        .cornerRadius(18)
    }
    func inputPartnerCodeButton() -> some View {
        NavigationLink(destination: InputCodeView(isopenfullscreen: $isOpen)) {
            Text("상대방 코드 입력하기")
                .foregroundColor(.lightPink)
                .padding(.vertical,UIScreen.getHeight(18))
                .frame(maxWidth: .infinity)
                .font(Font.bodyfont())
        }
        .background(Color.gray3)
        .cornerRadius(8)
    }

}
//struct CouplingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CouplingView(isOpen: .constant(true))
//    }
//}
