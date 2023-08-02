//
//  WriteHistoryCellDev2.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/28.
//

import SwiftUI

struct WriteHistoryCell: View {
    
    let letter: LetterModel
    @State private var image: UIImage?
    
    var body: some View {
        
        ZStack {
            HStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    Text(Date.formatDate(letter.date))
                        .foregroundColor(.secondaryLabel)
                        .font(.caption1font())
                    
                    Spacer()
                    
                    Text(letter.text)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.trailing, 5)
                        .font(.footnotefont())
                        .padding(.bottom)
                }
                .padding(.leading, 5)
                Spacer()
                
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: UIScreen.getWidth(70), height: UIScreen.getHeight(70))
                        .cornerRadius(10)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.getHeight(92))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(letter.isSent ? .gray3 : .gray4)
            )
        }
        .padding(.horizontal, 10)
        .onAppear {
            loadImage()
        }
    }
}

extension WriteHistoryCell {

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

struct WriteHistoryCell_Previews: PreviewProvider {
    
    static let testLetter1 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: true, isSent: false, isRead: false, sentDate: nil)
    static let testLetter2 = LetterModel(id: "s", image: "", date: .now, text: "adsfadsfasdfadsgsdgdsgadsgasdgadsgadsgasdgadsgasdgadsgsadgadsg", isByme: true, isSent: false, isRead: false, sentDate: nil)
    
    
    static var previews: some View {
        VStack {
            WriteHistoryCell(letter: testLetter1)
            WriteHistoryCell(letter: testLetter2)
        }
    }
}
