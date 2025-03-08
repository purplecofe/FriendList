//
//  InviteListModel.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import Foundation

struct FriendResponse: Decodable {
    let response: [Friend]
}

enum FriendStatus: Int, Decodable {
    case inviteSent
    case completed
    case inviting
}

enum FriendScenario {
    case noFriends
    case onlyFriends
    case withInvites
}

struct Friend: Decodable {
    let name: String
    let status: FriendStatus
    let isTop: Bool
    let fid: String
    let updateDate: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case isTop
        case fid
        case updateDate
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let rawStatus = try container.decode(Int.self, forKey: .status)
        status = FriendStatus(rawValue: rawStatus) ?? .inviteSent
        let rawIsTop = try container.decode(String.self, forKey: .isTop)
        isTop = rawIsTop == "1"
        self.fid = try container.decode(String.self, forKey: .fid)
        let rawDate = try container.decode(String.self, forKey: .updateDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date1 = dateFormatter.date(from: rawDate) {
            updateDate = date1
        } else {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            if let date2 = dateFormatter.date(from: rawDate) {
                updateDate = date2
            } else {
                throw DecodingError.dataCorruptedError(forKey: .updateDate,
                                                       in: container, debugDescription: "decode date error")
            }
        }
    }
}
