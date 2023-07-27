//
//  CouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct CouplingView: View {
    private let mycode = UserManager.shared.currentUserUID
    var body: some View {
        ZStack{
            Color.backGround
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image(Assets.couplingpaper)
                Text("연인에게 종이학 편지를 받으려면 아래 코드로 연결해주세요")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 80)
                    .padding(.bottom,40)
                codeSharingView()
                    .padding(.horizontal,54)
                    .padding(.bottom,10)
                Spacer()
                inputPartnerCodeButton()
                    .padding(.horizontal,30)

            }

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                closeButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Text("연인 연결하기")
            }
        }
    }
    func closeButton() -> some View {
        Button(action: {
        }){
            Image(systemName: "xmark")
        }
    }
    func codeSharingView() -> some View {
        VStack(spacing: 30){
            Text("나의 코드")
                .foregroundColor(.secondaryLabel)
            Text(mycode)
                .foregroundColor(.primaryLabel)
            Button {
                UIPasteboard.general.string = mycode
            } label: {
                Text("복사하기")
                    .foregroundColor(.lightPink)
            }
            // TODO: item에 나의 코드 넣어주기!
            ShareLink(item: mycode, preview: SharePreview(
                    Text("사랑의 종이학")
            )) {
                Text("링크로 알려주기")
                    .foregroundColor(.gray1 )
                    .padding(.horizontal,34)
                    .padding(.vertical, 13)
                    .background(Color.lightPink)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical,40)
        .frame(maxWidth: .infinity)
        .background(Color.gray3)
        .cornerRadius(18)
    }
    func inputPartnerCodeButton() -> some View {
        NavigationLink(destination: InputCodeView()) {
            Text("상대방 코드 입력하기")
                .foregroundColor(.lightPink)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .background(Color.gray3)
        .cornerRadius(8)
    }

}
struct CouplingView_Previews: PreviewProvider {
    static var previews: some View {
        CouplingView()
    }
}
