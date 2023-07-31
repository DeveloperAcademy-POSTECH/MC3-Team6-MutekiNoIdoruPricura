//
//  DetailView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm = DetailViewModel()
    @State var letter = LetterModel(id: "s", image: "", date: .now, text: "가나다라마바사", isByme: true, isSent: false, isRead: false)
    @State private var showEnlargedImageView = false
    @State private var showDeleteAlert = false
    @State private var image : UIImage?
    
    var body: some View {
        
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            ZStack() {
                VStack {
                    detailViewHeader()
                        .padding(.horizontal, 30.5)
                        .padding(.top, 19)
                    Spacer()
                }
                VStack {
                    if let thisImage = image {
                        letterImageView(image: thisImage)
                            .padding(.top, 50.5)
                    } else {
                        EmptyView()
                    }

                    ZStack(alignment: .topTrailing) {
                        letterTextView()
                            .padding(.top, 40)
                        randomColorCrane()
                            .offset(x: -UIScreen.getWidth(20.79), y: UIScreen.getWidth(29))
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
        .onAppear() {
            loadImage()
        }
        
    }
    
    private func backToHistoryButton() -> some View {
        return NavigationLink {
           // HistoryView로 되돌아갈 수 있도록.
        } label: {
            Image(systemName: "chevron.left")
                .scaledToFit()
                .foregroundColor(.secondaryLabel)
                .frame(width: UIScreen.getWidth(14), height: UIScreen.getHeight(14))
        }
    }
    
    private func detailViewHeader() -> some View {
        return HStack {
            backToHistoryButton()
            Spacer()
            if letter.isByme { // 내가 보낸 편지일 경우 상단 메뉴 버튼이 존재
                Menu {
                    Button(action: {
                    }) {
                        HStack {
                            Text("수정하기")
                            Image(systemName: "square.and.pencil")
                        }
                    }
                    Button(role: .destructive, action: {
                        showDeleteAlert.toggle()
                    }) {
                        HStack {
                            Text("삭제하기")
                            Image(systemName: "trash")
                        }
                        
                    }
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.secondaryLabel)
                        .frame(width: UIScreen.getWidth(15), height: UIScreen.getHeight(3))
                }
            }
        }
    }
    
    private func letterTextView() -> some View {
        return VStack(alignment: .leading){
            ScrollView {
                Text(letter.text)
                    .font(Font.bodyfont())
                    .lineSpacing(UIScreen.getHeight(8))
                    .foregroundColor(.primaryLabel)
            }
            Spacer()
            HStack {
                Spacer()
                Text(Date.formatDateForDetailView(letter.date))
                    .font(Font.footnotefont())
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
    
    private func letterImageView(image: UIImage) -> some View {
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
    
    private func randomColorCrane() -> some View {
        Image(Assets.crans.randomElement()!.rawValue)
            .resizable()
            .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(36))
    }
}

extension DetailView {

    private func loadImage() {
        guard let imageUrl = letter.image else { return }
        Task {
            do {
                let imageData = try await StorageManager.shared.getImage(url: imageUrl)
                self.image = UIImage(data: imageData)
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView()
        }
    }
}
