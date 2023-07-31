//
//  WriteHistoryViewDev.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct WriteHistoryView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Color(.backGround).ignoresSafeArea()
            
            VStack(alignment:.leading) {
                makeHeaderImageText()
                
                ScrollView {
                    makeNotSentLettersCells()
                    makeSentLettersCells()
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

extension WriteHistoryView {
    
    var letterCount: Int {
        LetterListsManager.shared.isByMeLetters.count
    }
    var sentLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.sentLettersGroupedByDate
    }
    
    var notSentLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.notSentLettersGroupedByDate
    }
    
    private func makeHeaderImageText() -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 16) {
                Text("나의 쪽지")
                    .font(.bodyfont())
                    .foregroundColor(.gray)
                
                HStack(alignment: .firstTextBaseline) {
                    Text("\(letterCount)")
                        .font(.title1font())
                        .foregroundColor(.lightPink)
                    Text("마리")
                        .font(.title3font())
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Image(Assets.writeViewCranes)
                .resizable()
                .frame(width: UIScreen.getWidth(68), height: UIScreen.getHeight(68))
        }
        .padding(.horizontal, 15)
        .padding(.leading, 5)
    }
    
    private func makeNotSentLettersCells() -> some View {
        ForEach(Array(notSentLetters.keys.sorted(by: >)), id: \.self) { date in
            LazyVStack(alignment: .leading) {
                if let notSentLettersGroup = notSentLetters[date] {
                    ForEach(notSentLettersGroup, id: \.self) { letter in
                        WriteHistoryCell(letter: letter)
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    private func makeSentLettersCells() -> some View {
        ForEach(Array(sentLetters.keys.sorted(by: >)), id: \.self) { date in
            LazyVStack(alignment: .leading) {
                if let sentLettersGroup = sentLetters[date] {
                    HStack {
                        Image(Assets.historyCrane)
                            .resizable()
                            .frame(width: UIScreen.getWidth(12.75), height: UIScreen.getHeight(11.46))

                        Text("\(sentLettersGroup.count)마리의 종이학을 발송했어요 :)")
                            .font(.caption1font())
                            .foregroundColor(.white)
                        
                        Text("-" + Date.formatDate(date))
                            .font(.caption2font())
                            .foregroundColor(Color.tertiaryLabel)
                    }
                    .padding(.leading, 20)
                    
                    ForEach(sentLettersGroup, id: \.self) { letter in
                        WriteHistoryCell(letter: letter)
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct WriteHistoryViewDev_Previews: PreviewProvider {
    static var previews: some View {
        WriteHistoryView()
    }
}
