//
//  DetailView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm = DetailViewModel()
    
    @State private var showEnlargedImageView = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            ZStack() {
                VStack {
                    detailViewHeader()
                        .padding(.trailing, 30.5)
                        .padding(.top, 19)
                    Spacer()
                }
                VStack { // 이미지 + 하단 회색뷰 일체
                    if let image = vm.image {
                        letterImageView(image: image)
                            .padding(.top, 50.5)
                    } else {
                        EmptyView()
                    }

                    ZStack(alignment: .topTrailing) { // 하단 회색뷰 일체
                        letterTextView()
                            .padding(.top, 40)
                        randomColorCrane()
                            .offset(x: -20.79, y: 29)
                    }
                }
   
            }
            .padding(.bottom, 35)
        }
        .fullScreenCover(isPresented: $showEnlargedImageView) {
            EnlargedImageView(image: $vm.image)
        }
        .alert("쪽지를 삭제할까요?", isPresented: $showDeleteAlert) {
            Button("취소", role: .cancel) {
                
          }
            Button("삭제하기", role: .destructive) {
              
          }
        }
        
    }
    
    func detailViewHeader() -> some View {
        return HStack {
            Spacer()
            Menu {
                Button(action: {
                 }) {
                     HStack {
                         Text("수정하기")
                         Image(systemName: "square.and.pencil")
                     }
                 }
                Button(action: {
                    showDeleteAlert.toggle()
                 }) {
                     HStack {
                         Text("삭제하기")
                         Image(systemName: "trash")
                     }
                     .foregroundColor(.red)
                     
                 }
                
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.secondaryLabel)
                .frame(width: 15, height: 3)
            }
        }
    }
    
    func letterTextView() -> some View {
        return VStack(alignment: .leading){
            ScrollView {
                Text(vm.letterText)
                    .foregroundColor(.primaryLabel)
            }
            Spacer()
            HStack {
                Spacer()
                Text(vm.dateAndTime)
                    .foregroundColor(.secondaryLabel)
            }
            .padding(.top, 24)
        }
        .frame(width: 310, height: 294)
        .padding(.horizontal, 24)
        .padding(.top, 36)
        .padding(.bottom, 28)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray4)
        )
    }
    
    func letterImageView(image: UIImage) -> some View {
        return Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .onTapGesture {
                showEnlargedImageView = true
            }
    }
    
    func randomColorCrane() -> some View {
        Image("blue")
            .resizable()
            .frame(width: 40, height: 36)
    }
}




struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView()
        }
    }
}
