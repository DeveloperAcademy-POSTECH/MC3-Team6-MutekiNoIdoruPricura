//
//  ReceivedHistoryView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/28.
//

import SwiftUI

struct ReceivedHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    var receivedLettersCount: Int {
        LetterListsManager.shared.receivedLetters.count
    }
    
    var receivedLetters: [Date : [LetterModel]] {
        LetterListsManager.shared.receivedLettersGroupedByDate
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.backGround).ignoresSafeArea()
            
            VStack(alignment:.leading) {

                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("받은 쪽지")
                            .foregroundColor(.gray)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(receivedLettersCount)")
                                .font(.largeTitle)
                                .foregroundColor(.lightPink)
                            Text("마리")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    
                    Image(Assets.receivedHistoryViewImage)
                }
                .padding(.horizontal, 15)
                .padding(.leading, 5)
                
                ScrollView {
                    
                    ForEach(Array(receivedLetters.keys.sorted(by: >)), id: \.self) { date in
                        LazyVStack(alignment: .leading) {
                            if let receivedLettersGroup = receivedLetters[date] {
                                HStack {
                                    Image(Assets.receivedHistoryBottle)
                                    
                                    Text("\(receivedLettersGroup.count)마리의 종이학을 선물받았어요 :)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    
                                    Text("-" + Date.formatDate(date))
                                        .font(.caption)
                                        .foregroundColor(Color.tertiaryLabel)
                                }
                                .padding(.leading, 20)
                                
                                ForEach(receivedLettersGroup, id: \.self) { letter in
                                    ReceivedHistoryCell(letter: letter)
                                }
                            }
                        }
                        .padding(.bottom)
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

struct ReceivedHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ReceivedHistoryView()
    }
}
