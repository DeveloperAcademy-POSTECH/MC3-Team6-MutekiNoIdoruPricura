//
//  WriteView.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI

struct WriteView: View {
    
    let backgroundColor = Color(#colorLiteral(red: 0.1930334568, green: 0.1931923628, blue: 0.1980533898, alpha: 1))
    let fontGrayColor = Color(#colorLiteral(red: 0.6358334422, green: 0.6358334422, blue: 0.6358334422, alpha: 1))
    let placeHolder = "상대방에게 전할 마음을 적어보세요 :)"
    let letterLimit = 300 // 혹시 글자수 제한 바뀔 수 있어서 변수로 빼둠.
    
    @EnvironmentObject var vm: WriteViewModel
    
    @State var letterText = ""
    @State var nowDate = getNowDate()
    @State var selectedImage : Image? = nil
    
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                writeViewHeader()
                
                Text(nowDate)
                    .font(.system(size: 13.33, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.top, 35)
                
                ZStack(alignment: .topLeading) {
                    Text(placeHolder)
                        .font(.system(size: 18.33, weight: .regular))
                        .foregroundColor(fontGrayColor)
                        .opacity( letterText.isEmpty ? 1 : 0)
                    VStack {
                        letterLimitTextField(letterLimit: letterLimit)
                        Spacer()
                        VStack(alignment: .leading) { // Pickerbutton + ImageView
                            
                            if let image = vm.image {
                                pickedImage(image: image)
                            } else { // 이미지가 pick 되지 않은 상태일 경우. 뷰가 뜨지 않는 구조.
                                EmptyView()
                            }
                            
                            HStack {
                                // 현재까지 입력된 텍스트 자수 / 300을 표시.
                                HStack(alignment: .bottom, spacing: 23.92) {
                                    Button(action: {
                                        vm.source = .camera
                                        vm.showPhotoPicker()
                                    }){
                                       Image("galleryButton")
                                    
                                    }
                                    Button(action: {
                                        vm.source = .library
                                        vm.showPhotoPicker()
                                    }){
                                       Image("cameraButton")
                                    }
                                }
                                
                                
                                Spacer()
                                
                                letterLimitLabel(letterLimit: letterLimit)
                            }
                        }
                    }
                }
                .padding(.top, 23.93)
                
                Spacer()
            }
            .padding(.top, 26)
            .padding(.horizontal, 27)
        }
    }
    
    func writeViewHeader() -> some View {
        return HStack {
            Button(action: {
                // full screen cover dismiss
            }){
                Image(systemName: "xmark")
                    .foregroundColor(fontGrayColor)
                    .font(.system(size: 25, weight: .regular))
            }
            
            Text("쪽지쓰기")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.white)
                .padding(.leading, 5.03)
            
            Spacer()
            
            Button(action: {
                // 쪽지 저장
            }){
                Text("저장")
                    .font(.system(size: 16.67, weight: .regular))
                    .foregroundColor(fontGrayColor)
            }
        }
    }
    
    func pickedImage(image: UIImage) -> some View {
        self.selectedImage = Image(uiImage: image)
        return Image(uiImage: image) // uiImage를 Image 뷰에 할당.
            .resizable()
            .scaledToFill()
            .frame(width: 90, height: 90)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
    
    func letterLimitLabel(letterLimit: Int) -> some View {
        return Text("\($letterText.wrappedValue.count)")
            .font(.system(size: 18.33, weight: .semibold))
            .foregroundColor(.white)
        + Text("/\(letterLimit)")
            .font(.system(size: 18.33, weight: .regular))
            .foregroundColor(.white)
    }
    
    /// 글자 제한이 있는 TextField를 추가
    /// - Parameters:
    ///   - letterLimit: 글자 수 제한의 글자수.
    /// - Returns: VStack을 return. (TextField View)
    func letterLimitTextField(letterLimit: Int) -> some View {
            TextField("", text: $letterText, axis: .vertical)
                    .lineLimit((Int(letterLimit/20) >= 5) ? Int(letterLimit/20) : 5, reservesSpace: true)
                    .font(.system(size: 18.33, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .onReceive($letterText.wrappedValue.publisher.collect()) {
                        $letterText.wrappedValue = String($0.prefix(letterLimit))
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
        WriteView()
            .environmentObject(WriteViewModel())
    }
}
