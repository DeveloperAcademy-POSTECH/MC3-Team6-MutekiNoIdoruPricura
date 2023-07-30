//
//  ReceivedHistoryCell.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/28.
//

import SwiftUI

struct ReceivedHistoryCell: View {
    
    let letter: LetterModel
    @State private var image: UIImage?
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(Date.formatDate(letter.date))
                        .foregroundColor(.secondaryLabel)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(letter.text)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.trailing, 5)
                        .font(.caption)
                        .padding(.bottom)
                }
                .padding(.leading, 5)
                
                Spacer()
                
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .frame(width: UIScreen.getWidth(70), height: UIScreen.getHeight(70))
                        .cornerRadius(10)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .frame(height: 92)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray3)
            )
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 92)
                .foregroundColor(Color.lightPink)
                .opacity(letter.isRead ? 0 : 1)
                .mask(
                    HStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 6)
                            .foregroundColor(Color.lightPink)
                        Spacer()
                    }
                )
        }
        .padding(.horizontal, 10)
        .onAppear {
            loadImage()
        }
    }
}

extension ReceivedHistoryCell {
    
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

struct ReceivedHistoryCell_Previews: PreviewProvider {
    
    static let testLetter1 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: false, isSent: false, isRead: false)
    static let testLetter2 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: false, isSent: false, isRead: true)
    
    
    static var previews: some View {
        VStack {
            ReceivedHistoryCell(letter: testLetter1)
            ReceivedHistoryCell(letter: testLetter2)
        }
    }
}
