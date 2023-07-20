//
//  CouplingView.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/20.
//

import SwiftUI
struct CouplingView: View {
    var body: some View {
        ZStack{
            Color(Color.backGround)
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
//            Text(UserManager.shared.getmyUUId())
            Text("efjqwofiqewjfoqqo")
            Button {
                UIPasteboard.general.string = UserManager.shared.getmyUUId()
            } label: {
                Text("복사하기")
                    .foregroundColor(.pink)
            }
            ShareLink(item: "내코드1234143", preview: SharePreview(
                    Text("사랑의 종이학")

            )) {
                Text("링크로 알려주기")
                    .foregroundColor(.white)
                    .padding(.horizontal,34)
                    .padding(.vertical, 13)
                    .background(Color.pink)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical,40)
        .frame(maxWidth: .infinity)
        .background(Color.gray)
        .cornerRadius(18)
    }
    func inputPartnerCodeButton() -> some View {
        Button {
            print("touch")
        } label: {
            Text("상대방 코드 입력하기")
                .foregroundColor(.pink)
                .padding(.vertical,16)
                .frame(maxWidth: .infinity)
        }
        .background(Color.gray)
        .cornerRadius(8)
    }

}
struct CouplingView_Previews: PreviewProvider {
    static var previews: some View {
        CouplingView()
    }
}
