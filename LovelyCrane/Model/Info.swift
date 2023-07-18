//
//  User.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import Foundation
struct Info: Codable {
    let mycode: String
    let nickname: String
    let partnerId: String
    let uuid: String
    var setMyCode: [String:Any] {
        return ["my_code": self.mycode]
    }
    var setNickName: [String:Any] {
        return ["nickname": self.mycode]
    }
    var setPartnerId: [String:Any] {
        return ["partner_id":self.partnerId]
    }
    var setuuid: [String:Any] {
        return ["uuid":self.uuid]
    }
}
