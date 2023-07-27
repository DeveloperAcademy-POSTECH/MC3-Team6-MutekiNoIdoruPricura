//
//  User.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import Foundation
struct DBUser: Codable {
    let uuid: String
    let nickname: String?
    let partnerId: String?
    let receiveCount: Int?
    let sendCount: Int?

    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case nickname = "nickname"
        case partnerId = "partner_id"
        case receiveCount = "receive_count"
        case sendCount = "send_count"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.uuid, forKey: .uuid)
        try container.encodeIfPresent(self.nickname, forKey: .nickname)
        try container.encodeIfPresent(self.receiveCount, forKey: .receiveCount)
        try container.encodeIfPresent(self.sendCount, forKey: .sendCount)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.partnerId = try container.decodeIfPresent(String.self, forKey: .partnerId)
        self.receiveCount = try container.decodeIfPresent(Int.self, forKey: .receiveCount)
        self.sendCount = try container.decodeIfPresent(Int.self, forKey: .sendCount)
    }

    init(auth: AuthDataResult) {
        self.uuid = auth.uid
        self.nickname = ""
        self.partnerId = ""
        self.receiveCount = 0
        self.sendCount = 0
    }
}
