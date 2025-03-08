//
//  TopTabBarView.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/8.
//

import Foundation

import UIKit

protocol TopTabBarViewDelegate: AnyObject {
    func topTabBarView(_ tabBarView: TopTabBarView, didSelectIndex index: Int)
}

class TopTabBarView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .init(width: 50, height: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TabbarCollectionViewCell.self, forCellWithReuseIdentifier: "TabbarCollectionViewCell")
        collectionView.dataSource = self
        return collectionView
    }()
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightPink
        return view
    }()
    private let titles = ["好友", "聊天"]
    private let viewModel: FriendViewModel

    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        viewModel.onDataUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        addSubview(underLineView)
        
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
        })
        underLineView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        })
    }
}
extension TopTabBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabbarCollectionViewCell", for: indexPath) as? TabbarCollectionViewCell else {
            return UICollectionViewCell()
        }
        let friends = viewModel.acceptedFriends
        cell.configure(title: titles[indexPath.item], friends: friends, indexPath: indexPath)
        return cell
    }
}
