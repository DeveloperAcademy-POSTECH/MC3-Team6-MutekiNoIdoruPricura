//
//  WriteView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI

struct WriteView: View {
    
    private let placeHolder = "상대방에게 전달할 마음을 적어보세요 :)"
    private let letterLimit = 300 // 혹시 글자수 제한 바뀔 수 있어서 변수로 빼둠.
    
    @StateObject var vm = WriteViewModel()
    
    @FocusState private var isFocused: Bool
    
    let nowDate = getNowDate()

    @State private var isOverLetterLimit = false
    @Binding var isShowingCurrentPage: Bool
    @State private var showPhotoPickerActionSheet = false
    @State private var showEnlargedImageView = false
    @State private var showDismissAlert = false
    var color: String
    
    @ObservedObject var keyboard = KeyboardObserver()

    
    var body: some View {
        GeometryReader { _ in // 키보드 등장시 화면이 avoid 하는 문제 방지.
            ZStack {
                Color.backGround
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) { // 가장 큰 VStack
                    // 상단 헤더 (x버튼 + 쪽지쓰기 타이틀 + 저장 버튼)
                    showWriteViewHeader()
                        .padding(.bottom, UIScreen.getHeight(16))
                    ScrollView {
                        VStack(alignment: .leading, spacing: 28) { // ScrollView에 들어갈 Vstack (날짜 + 텍스트필드)
                            Text(nowDate)
                                .font(Font.caption1font())
                                .foregroundColor(Color.primaryLabel)
                            ZStack(alignment: .topLeading) { // 플레이스홀더 + 텍스트필드
                                Text(placeHolder)
                                    .font(Font.bodyfont())
                                    .foregroundColor(Color.secondaryLabel)
                                    .opacity(vm.letterText.isEmpty ? 1 : 0)
                                letterLimitTextField(letterLimit: letterLimit)
                                    .onReceive(vm.letterText.publisher.collect()) { collectionText in
                                    let trimmedText = String(collectionText.prefix(letterLimit))
                                    if vm.letterText != trimmedText {
                                        isOverLetterLimit = vm.letterText.count > letterLimit ? true : false
                                        vm.letterText = trimmedText
                                    }
                                    //isOverLetterLimit = vm.letterText.count > letterLimit
                                }
                            }
                        }
                    }
                        .padding(.top, 30)
                        .frame(maxHeight: isFocused && vm.letterText.count > 0 ? UIScreen.getHeight(270) : 1000)
                    
                    Spacer()
                    
                    HStack(alignment: .bottom) {
                        if let image = vm.image { // 이미지가 첨부되었을 경우
                            ZStack(alignment: .topTrailing) {
                                pickedImage(image: image)
                                imageDisselectButton()
                            }
                        } else { // 이미지가 pick 되지 않은 상태일 경우. 디폴트 이미지
                            defaultImage()
                        }
                        
                        Spacer()
                        letterLimitLabel(letterLimit: letterLimit)
                        
                    }
                    .offset(y:isFocused ? -UIScreen.getHeight(keyboard.height-30) : 0)
                    .animation(.easeOut(duration: 0.3), value: keyboard.height)
                }
                .padding(.top, UIScreen.getHeight(20))
                .padding(.horizontal, UIScreen.getWidth(28))
                .padding(.bottom, UIScreen.getHeight(24))
            }

            .onAppear{
                //keyboard Observer
                self.keyboard.addObserver()
                UIScrollView.appearance().bounces = false
            }
            .onDisappear{
                self.keyboard.removeObserver()
            }
            //Keyboard 관련
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                isFocused = false
            }
            //photoPickerSheet
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
            }
            //actionSheet
            .confirmationDialog("", isPresented: $showPhotoPickerActionSheet, titleVisibility: .hidden) {
                Button("갤러리") {
                    vm.source = .library
                    vm.showPhotoPicker()
                }
                Button("카메라") {
                    vm.source = .camera
                    vm.showPhotoPicker()
                }
                Button("취소", role: .cancel) {}
            }
            //fullScreenView (= EnlargedImageView)
            .fullScreenCover(isPresented: $showEnlargedImageView) {
                EnlargedImageView(image: $vm.image)
            }
            .alert("쪽지 작성을 그만둘까요?", isPresented: $showDismissAlert) {
                Button("확인", role: .cancel) {
                    isShowingCurrentPage.toggle()
              }
                Button("취소", role: .destructive) {
                  
              }
            }
        }
    }
    
    func showWriteViewHeader() -> some View {
        return HStack {
            Button(action: {
                // full screen cover dismiss
                showDismissAlert.toggle()
            }){
                Image(systemName: "xmark")
                    .foregroundColor(Color.tertiaryLabel)
                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
            }
            Spacer()
            Text("쪽지쓰기")
                .font(Font.headlinefont())
                .foregroundColor(Color.primaryLabel)
                .padding(.leading, UIScreen.getWidth(5.03))
            Spacer()
            Button(action: {
                // 쪽지 저장
                Task{
                    if(await vm.saveImageStoarge()){
                    isShowingCurrentPage.toggle()
                    NotificationCenter.default.post(name: NSNotification.Name("write"), object: color)
                }}

                print("button")
            }){
                Text("저장")
                    .font(Font.headlinefont())
                    .foregroundColor(Color.secondaryLabel)
            }
        }
    }
    
    func pickedImage(image: UIImage) -> some View {
        return Image(uiImage: image) // uiImage를 Image 뷰에 할당.
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.getWidth(82), height: UIScreen.getHeight(82))
            .clipShape(
                RoundedRectangle(cornerRadius: 4.5)
            )
            .onTapGesture {
                // 확대된 이미지 풀스크린 뷰
                showEnlargedImageView = true
            }
    }
    
    func imageDisselectButton() -> some View {
        return Button(action: {
            // Image disselect
            vm.image = nil
        }){
            Image(systemName: "xmark")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.gray3)
                .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                .background(
                    Circle()
                        .fill(Color.fill.opacity(0.8))
                )
        }
        .offset(y: -UIScreen.getHeight(10))
        .offset(x: -UIScreen.getHeight(10))
    }
    
    func letterLimitLabel(letterLimit: Int) -> some View {
        return Text("\($vm.letterText.wrappedValue.count)")
            .font(Font.footnotefont())
            .foregroundColor(isOverLetterLimit ? ($vm.letterText.wrappedValue.count < 300 ? Color.primaryLabel : Color.defaultRed) : Color.primaryLabel)
        + Text("/\(letterLimit)")
            .font(Font.footnotefont())
            .foregroundColor(Color.tertiaryLabel)
    }
    
    /// 글자 제한이 있는 TextField를 추가
    /// - Parameters:
    ///   - letterLimit: 글자 수 제한의 글자수.
    /// - Returns: TextField View
    func letterLimitTextField(letterLimit: Int) -> some View {
        TextField("", text: $vm.letterText, axis: .vertical)
                    .lineLimit(Int(letterLimit/20), reservesSpace: true)
                    .font(Font.bodyfont())
                    .foregroundColor(Color.primaryLabel)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(12)
                    .focused($isFocused)
    }
    
    func defaultImage() -> some View {
        Image(Assets.galleryIcon)
            .frame(width: UIScreen.getWidth(82), height: UIScreen.getHeight(82))
            .background(
                    RoundedRectangle(cornerRadius: 4.5)
                        .fill(Color.gray4)
            )
            .onTapGesture {
                    showPhotoPickerActionSheet = true
            }
    }
    
}

extension WriteView {
    
    // placeHolder 색상을 커스텀하게 바꾸기 위한 extension
    func placeholder<Content: View>(
         when shouldShow: Bool,
         alignment: Alignment = .leading,
         @ViewBuilder placeholder: () -> Content) -> some View {

         ZStack(alignment: alignment) {
             placeholder().opacity(shouldShow ? 1 : 0)
             self
         }
     }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(isShowingCurrentPage: .constant(true), color: "pink")
            .environmentObject(WriteViewModel())
    }
}
