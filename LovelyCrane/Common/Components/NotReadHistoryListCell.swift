//
//  HistoryListCell.swift
//  LovelyCrane
//
//  Created by 최진용 on 2023/07/19.
//

import SwiftUI

struct NotReadHistoryListCell: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.notReadCell)
                .frame(maxHeight: 130)
            VStack(alignment: .leading) {
                Text("7월 15일 수요일")
                    .padding(.leading, 10)
                    .padding(.top)
                HStack {
                    Text("ㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓfefefef")
                        .lineLimit(2)
                        .padding(.trailing)
                    Image(Assets.dummyImage)
                        .resizable()
                        .cornerRadius(8)
                        .frame(maxWidth: 55, maxHeight: 55)
                        .scaledToFill()
                }.padding(.bottom)
                    .padding(.horizontal, 10)
            }
            .foregroundColor(.white)
        }
    }
}


struct ListCell_Preview: PreviewProvider {
    static var previews: some View {
        NotReadHistoryListCell()
    }
}
