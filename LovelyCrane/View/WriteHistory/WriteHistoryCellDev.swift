//
//  WriteHistoryCellDev.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct WriteHistoryCellDev: View {
    
    let letter: LetterModel
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                
                Text(formatDate(letter.date))
                    .foregroundColor(.secondaryLabel)

                HStack {
                    Text(letter.text)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.trailing)
                    Spacer()
                    if let image = letter.image {
                        Image(image)
                    } else {
                        Image(systemName: "flame.fill")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(letter.isSent ? .gray3 : .gray4)
            )
        }
        .padding(.horizontal, 10)
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}

struct WriteHistoryCellDev_Previews: PreviewProvider {
    
    static let testLetter1 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: true, isSent: false, isRead: false)
    static let testLetter2 = LetterModel(id: "s", image: "", date: .now, text: "dhdhdh", isByme: true, isSent: false, isRead: false)
    
    
    static var previews: some View {
        VStack {
            WriteHistoryCellDev(letter: testLetter1)
            WriteHistoryCellDev(letter: testLetter2)
        }
    }
}

