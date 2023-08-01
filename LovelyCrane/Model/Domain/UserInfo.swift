//
//  UserInfo.swift
//  LovelyCrane
//
//  Created by 최진용 on 2023/08/01.
//

import Foundation

class UserInfo: ObservableObject {
    static let shared = UserInfo()
    private init() {}
    //보내야하는 쪽지(내가 작성한 쪽지중 안보낸거)
    @Published var notSendLetterCount = 0
    @Published var sendLetterCount = 0
    @Published var receiveLetterCount = 0
    @Published var nickName = ""
    @Published var partnerNickName = ""
    
    //파트너 연결안되어있으면, true 아니면 false
    func isConnection() -> Bool {
        return !partnerNickName.isEmpty
    }
}
