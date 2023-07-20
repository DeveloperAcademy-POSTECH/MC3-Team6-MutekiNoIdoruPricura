//
//  ViewRouter.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/20.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: CurrentPage = .AuthenticationView
}


enum CurrentPage {
    case AuthenticationView
    case MainView
    case NicknameView
}
