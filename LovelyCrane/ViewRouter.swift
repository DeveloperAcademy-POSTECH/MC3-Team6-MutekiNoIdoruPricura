//
//  ViewRouter.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/20.
//

import Foundation

final class ViewRouter: ObservableObject {
    @Published var currentPage: CurrentPage = .launchsScreenView
}

enum CurrentPage {
    case launchsScreenView
    case authenticationView
    case mainView
    case nicknameView
}
