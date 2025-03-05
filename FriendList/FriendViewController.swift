//
//  FriendViewController.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/5.
//

import UIKit
import SnapKit

class FriendViewController: UIViewController {
    private let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

private extension FriendViewController {
    func setupUI() {
        view.addSubview(profileHeaderView)
        profileHeaderView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
        })
    }
}
