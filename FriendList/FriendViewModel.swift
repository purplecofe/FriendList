//
//  FriendViewModel.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/7.
//

import Foundation

class FriendViewModel {
    private var friends: [Friend] = []
    private var userProfiles: [UserProfile] = []
    
    var inviteSentFriends: [Friend] {
        friends.filter({ $0.status == .inviteSent })
    }
    private var _acceptedFriends: [Friend] = []
    var acceptedFriends: [Friend] {
        _acceptedFriends
    }
    var userProfile: UserProfile? {
        userProfiles.first
    }
    var scenario: FriendScenario = .noFriends
    
    var onDataUpdated: (() -> Void)?
    var onProfileDataUpdated: (() -> Void)?
    
    func fetchInviteAndFriends() {
        Task {
            do {
                guard let url = URL(string: "https://dimanyen.github.io/friend3.json") else {
                    return
                }
                let response = try await NetworkManager.shared.request(url: url, type: FriendResponse.self)
                self.friends = response.response
                _acceptedFriends = friends.filter({ $0.status == .completed || $0.status == .inviting })
                await MainActor.run {
                    self.onDataUpdated?()
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    func fetchFriends() {
        Task {
            do {
                guard let url = URL(string: "https://dimanyen.github.io/friend1.json"),
                      let url2 = URL(string: "https://dimanyen.github.io/friend2.json") else {
                    return
                }
                async let response1 = try NetworkManager.shared.request(url: url, type: FriendResponse.self)
                async let response2 = try NetworkManager.shared.request(url: url2, type: FriendResponse.self)
                let friend1 = try await response1
                let friend2 = try await response2
                let mergedFriends = mergeFriends(friend1.response, friend2.response)
                self.friends = mergedFriends
                _acceptedFriends = friends.filter({ $0.status == .completed || $0.status == .inviting })
                await MainActor.run {
                    self.onDataUpdated?()
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    func fetchUserProfile() {
        Task {
            do {
                guard let url = URL(string: "https://dimanyen.github.io/man.json") else {
                    return
                }
                let response = try await NetworkManager.shared.request(url: url, type: UserProfileResponse.self)
                self.userProfiles = response.response
                
                await MainActor.run {
                    self.onProfileDataUpdated?()
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    private func mergeFriends(_ list1: [Friend], _ list2: [Friend]) -> [Friend] {
        var dict: [String: Friend] = [:]
        
        for friend in list1 {
            dict[friend.fid] = friend
        }
        
        for friend in list2 {
            if let existing = dict[friend.fid] {
                if friend.updateDate > existing.updateDate {
                    dict[friend.fid] = friend
                }
            } else {
                dict[friend.fid] = friend
            }
        }
        
        return Array(dict.values)
    }
    
    func filterFriends(by keyword: String) {
         if keyword.isEmpty {
             _acceptedFriends = friends.filter { $0.status == .completed || $0.status == .inviting }
         } else {
             _acceptedFriends = friends.filter {
                 ($0.status == .completed || $0.status == .inviting)
                 && $0.name.contains(keyword)
             }
         }
         onDataUpdated?()
     }
}
