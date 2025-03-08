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
    private lazy var topTabBarView: TopTabBarView = {
        let view = TopTabBarView(viewModel: friendViewModel)
        return view
    }()
    private let inviteListContainerView = UIView()
    private let friendListContainerView = UIView()
    private let emptyView = FriendListEmptyView()
    private let friendViewModel = FriendViewModel()
    private lazy var inviteListVC = InviteListViewController(viewModel: friendViewModel)
    private lazy var friendListVC = FriendListViewController(viewModel: friendViewModel)
    private var inviteListHeightConstraint: Constraint?
    private var scenario: FriendScenario = .noFriends

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInviteContainerView()
        setupFriendListContainerView()
        bindViewModel()
        friendViewModel.fetchUserProfile()
        if scenario == .onlyFriends {
            friendViewModel.fetchFriends()
        } else if scenario == .withInvites {
            friendViewModel.fetchInviteAndFriends()
        }
    }

    init(scenario: FriendScenario) {
        self.scenario = scenario
        friendViewModel.scenario = scenario
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FriendViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(profileHeaderView)
        view.addSubview(topTabBarView)
        
        profileHeaderView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(30)
        })
        if scenario == .onlyFriends {
            view.addSubview(friendListContainerView)
            topTabBarView.snp.makeConstraints({
                $0.top.equalTo(profileHeaderView.snp.bottom).offset(25)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            })
            friendListContainerView.snp.makeConstraints({
                $0.top.equalTo(topTabBarView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            })
        } else if scenario == .withInvites {
            view.addSubview(inviteListContainerView)
            view.addSubview(friendListContainerView)
            inviteListContainerView.snp.makeConstraints({
                $0.top.equalTo(profileHeaderView.snp.bottom).offset(25)
                $0.leading.trailing.equalToSuperview()
                self.inviteListHeightConstraint = $0.height.equalTo(100).constraint
            })
            topTabBarView.snp.makeConstraints({
                $0.top.equalTo(inviteListContainerView.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            })
            friendListContainerView.snp.makeConstraints({
                $0.top.equalTo(topTabBarView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            })
        } else if scenario == .noFriends {
            topTabBarView.snp.makeConstraints({
                $0.top.equalTo(profileHeaderView.snp.bottom).offset(25)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            })
            view.addSubview(emptyView)
            emptyView.snp.makeConstraints({
                $0.top.equalTo(topTabBarView.snp.bottom).offset(30)
                $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 65))
            })
        }
    }
    
    func setupInviteContainerView() {
        inviteListVC.delegate = self
        addChild(inviteListVC)
        inviteListContainerView.addSubview(inviteListVC.view)
        inviteListVC.view.frame = inviteListContainerView.bounds
        inviteListVC.didMove(toParent: self)
    }
    
    func setupFriendListContainerView() {
        addChild(friendListVC)
        friendListContainerView.addSubview(friendListVC.view)
        friendListVC.view.frame = friendListContainerView.bounds
        friendListVC.didMove(toParent: self)
        
        friendListVC.pullToRefreshCallback = { [weak self] in
            guard let self = self else { return }
            if scenario == .onlyFriends {
                self.friendViewModel.fetchFriends()
            } else if scenario == .withInvites {
                self.friendViewModel.fetchInviteAndFriends()
            }
        }
    }
    
    func bindViewModel() {
        friendViewModel.onProfileDataUpdated = { [weak self] in
            if let userProfile = self?.friendViewModel.userProfile {
                self?.profileHeaderView.configure(userProfile: userProfile)
            }
        }
    }
}
extension FriendViewController: InviteListViewControllerDelegate {
    func didUpdateContentHeight(_ height: CGFloat) {
        inviteListHeightConstraint?.update(offset: height)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
