//
//  WriteHistoryView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI


struct WriteHistoryView: View {
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        LazyVStack {
                            NotReadHistoryListCell()
                        }
                        header()
                        LazyVStack {
                            ReadHistoryListCell()
                        }
                        Spacer()
                    }
                }
                .padding()
                .background {
                    BackGroundView()
                }
            }.navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        toolBarTitle()
                    }
                }
        }
    }
    
    private func header() -> some View {
        HStack {
            Image(Assets.sendBottle)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("97마리의 종이학을 발송했어요")
                .foregroundColor(.white)
            //텍스트랑 동일한 사이즈로 설정해줘야함.
        }.frame(width: .infinity, height: 18)
            .padding(.vertical)
    }
    
    private func toolBarTitle() -> some View {
        HStack {
            Text("9127개")
                .font(.system(size: 26))
                .foregroundColor(.white)
            Image(Assets.conceptCrane)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 26)
        }
    }
    
}



struct WriteView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
