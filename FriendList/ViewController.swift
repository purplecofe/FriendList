//
//  ViewController.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/5.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let noFriendsButton = createButton(title: "無好友", action: #selector(onNoFriendsTapped))
        let onlyFriendsButton = createButton(title: "只有好友", action: #selector(onOnlyFriendsTapped))
        let withInvitesButton = createButton(title: "好友 + 邀請", action: #selector(onWithInvitesTapped))
        
        let stack = UIStackView(arrangedSubviews: [noFriendsButton, onlyFriendsButton, withInvitesButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        view.addSubview(stack)
        stack.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }

    private func createButton(title: String, action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    @objc private func onNoFriendsTapped() {
        navigateToFriendVC(scenario: .noFriends)
    }
    
    @objc private func onOnlyFriendsTapped() {
        navigateToFriendVC(scenario: .onlyFriends)
    }
    
    @objc private func onWithInvitesTapped() {
        navigateToFriendVC(scenario: .withInvites)
    }
    
    private func navigateToFriendVC(scenario: FriendScenario) {
        let friendVC = FriendViewController(scenario: scenario)
        navigationController?.pushViewController(friendVC, animated: true)
    }
}

