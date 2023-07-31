//
//  TouchCraneAlertView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/30.
//

import SwiftUI

struct TouchCraneAlertView: View {
    
    private let craneUnfoldImages = Assets.touchCranes
    @State private var showFinalAlert = false
    @State private var craneIndex = 0
    let buttonAction : ()->Void = {}
    @Binding var showAlert: Bool
    
    var body: some View {
        if showAlert {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray3)
                    .frame(width: UIScreen.getWidth(280), height: UIScreen.getHeight(358))
                VStack(spacing: 0) {
                    switch showFinalAlert {
                    case true :
                        alertFinalTitle()
                        alertFinalImage()
                        alertFinalButton()
                    default :
                        alertUnfoldTitle()
                        alertUnfoldImage()
                        alertUnfoldButton()
                    }
                }
            }
        }
    }
    
    func alertUnfoldTitle() -> some View {
       return Text("종이학을 터치해서\n펼쳐보세요")
            .foregroundColor(.primaryLabel)
            .font(Font.title3font())
            .multilineTextAlignment(.center)
            .lineSpacing(UIScreen.getHeight(10))
    }
    
    func alertFinalTitle() -> some View {
        return VStack(spacing: 0) {
            Text("종이학이 펴졌어요!")
                .foregroundColor(.primaryLabel)
                .font(Font.title3font())
            Text("이제 쪽지를 읽을 수 있어요 :)")
                .foregroundColor(.secondaryLabel)
                .font(Font.footnotefont())
                .padding(.top, UIScreen.getHeight(24))
        }
    }
    func alertUnfoldImage() -> some View {
       return Image(craneUnfoldImages[craneIndex].rawValue)
            .frame(width: UIScreen.getWidth(162), height: UIScreen.getHeight(162))
            .onTapGesture {
                if craneIndex < 2 {
                    craneIndex += 1
                } else {
                    showFinalAlert.toggle()
                }
            }
            .padding(.top, UIScreen.getHeight(24))
    }
    func alertFinalImage() -> some View {
       return Image(craneUnfoldImages[3].rawValue)
            .frame(width: UIScreen.getWidth(162), height: UIScreen.getHeight(162))
    }
    func alertUnfoldButton() -> some View {
        return Button(action: {
            showFinalAlert.toggle()
        }){
            Text("바로 연결")
                .foregroundColor(.secondaryLabel)
                .font(Font.footnotefont())
                .underline()
        }
        .padding(.top, UIScreen.getHeight(17))
    }
    func alertFinalButton() -> some View {
       return Button(action: {
           buttonAction()
       }){
           Text("열어보기")
               .foregroundColor(.gray3)
               .font(Font.bodyfont())
               .padding(.vertical, UIScreen.getHeight(16.5))
               .padding(.horizontal, UIScreen.getWidth(34))
               .background(
                   RoundedRectangle(cornerRadius: 8)
                       .fill(Color.lightPink)
               )
       }
       .padding(.top, UIScreen.getHeight(3))
    }
}

struct TouchCraneAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TouchCraneAlertView(showAlert: Binding.constant(true))
    }
}
