//
//  UserProfileModel.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/8.
//

import Foundation

struct UserProfileResponse: Decodable {
    let response: [UserProfile]
}

struct UserProfile: Decodable {
    let name: String
    let kokoid: String
}
