//
//  WriteView.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/13.
//

import SwiftUI


struct WriteView: View {
    @Binding var isShowingCurrentPage: Bool
    var color: String
    
    var body: some View {
        Button("back") {
            isShowingCurrentPage.toggle()
            NotificationCenter.default.post(name: NSNotification.Name("write"), object: color)
        }
    }
}
