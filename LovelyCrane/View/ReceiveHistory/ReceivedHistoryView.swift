//
//  ReceivedHistoryView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/28.
//

import SwiftUI

struct ReceivedHistoryView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.backGround).ignoresSafeArea()
            
            VStack(alignment:.leading) {

                makeHeaderImageText()
                
                ScrollView {
                    makeReceivedLettersCells()
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

extension ReceivedHistoryView {
    
    var receivedLettersCount: Int {
        LetterListsManager.shared.receivedLetters.count
    }
    
    var receivedLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.receivedLettersGroupedByDate
    }
    
    private func makeHeaderImageText() -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 16) {
                Text("받은 쪽지")
                    .font(.bodyfont())
                    .foregroundColor(.gray)
                
                HStack(alignment: .firstTextBaseline) {
                    Text("\(receivedLettersCount)")
                        .font(.title1font())
                        .foregroundColor(.lightPink)
                    Text("마리")
                        .font(.title3font())
                        .foregroundColor(.white)
                }
            }
            Spacer()
            
            Image(Assets.receivedHistoryViewImage)
                .frame(width: UIScreen.getWidth(47), height: UIScreen.getHeight(65))
        }
        .padding(.horizontal, 15)
        .padding(.leading, 5)
    }
    
    private func makeReceivedLettersCells() -> some View {
        ForEach(Array(receivedLetters.keys.sorted(by: >)), id: \.self) { date in
            LazyVStack(alignment: .leading) {
                if let receivedLettersGroup = receivedLetters[date] {
                    HStack {
                        Image(Assets.receivedHistoryBottle)
                            .resizable()
                            .frame(width: UIScreen.getWidth(9.94), height: UIScreen.getHeight(14.21))
                        
                        Text("\(receivedLettersGroup.count)마리의 종이학을 선물받았어요 :)")
                            .font(.caption1font())
                            .foregroundColor(.white)
                        
                        Text("-" + Date.formatDate(date))
                            .font(.caption2font())
                            .foregroundColor(Color.tertiaryLabel)
                    }
                    .padding(.leading, 20)
                    
                    ForEach(receivedLettersGroup, id: \.self) { letter in
                        NavigationLink(destination: {
                            DetailView(letter: letter)
                        }, label: {
                            ReceivedHistoryCell(letter: letter)
                        })
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct ReceivedHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedHistoryView()
    }
}
