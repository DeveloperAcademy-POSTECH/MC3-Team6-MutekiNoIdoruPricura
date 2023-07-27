//
//  WriteHistoryViewDev.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import SwiftUI

struct WriteHistoryViewDev: View {
    @Environment(\.dismiss) var dismiss
    
    var letterCount: Int {
        LetterListsManager.shared.isByMeLetters.count
    }
    var sentLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.sentLettersGroupedByDate
    }
    
    var notSentLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.notSentLettersGroupedByDate
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.backGround).ignoresSafeArea()
            
            //MARK: 최상단 VStack
            VStack(alignment:.leading) {
                //MARK: 헤더
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("나의 쪽지")
                            .foregroundColor(.gray)
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(letterCount)")
                                .font(.largeTitle)
                                .foregroundColor(.lightPink)
                            Text("마리")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    Image("WriteViewCranes")
                }
                .padding(.horizontal, 15)
                .padding(.leading, 5)
                
                ScrollView {
                    
                    ForEach(Array(notSentLetters.keys.sorted(by: >)), id: \.self) { date in
                        
                        VStack(alignment: .leading) {
                            if let notSentLettersGroup = notSentLetters[date] {
                                HStack {
                                   Image("historyCrane")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 12)
                                    Text("\(notSentLettersGroup.count)마리의 종이학을 발송했어요 :) -\(formatDate(date))")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, 20)

                                
                                ForEach(notSentLettersGroup, id: \.self) { letter in
                                    WriteHistoryCellDev(letter: letter)
                                }
                                
                            } else {
                                Text("바인딩 실패패패패패퍂")
                            }
                        }
                    }
                }
            }

            .padding(5)
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

struct WriteHistoryViewDev_Previews: PreviewProvider {
    static var previews: some View {
        WriteHistoryViewDev()
    }
}

extension WriteHistoryViewDev {
    private func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter.string(from: date)
    }
}
