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
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }
                else {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.clear)
                        .cornerRadius(10)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
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
    
    static let testLetter1 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: true, isSent: false, isRead: false)
    static let testLetter2 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: true, isSent: false, isRead: false)
    
    
    static var previews: some View {
        VStack {
            WriteHistoryCell(letter: testLetter1)
            WriteHistoryCell(letter: testLetter2)
        }
    }
}
