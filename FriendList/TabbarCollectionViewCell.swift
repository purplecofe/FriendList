//
//  TabbarCollectionViewCell.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/8.
//

import UIKit

class TabbarCollectionViewCell: UICollectionViewCell {
    private lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .greyishBrown
        lb.font = .systemFont(ofSize: 13, weight: .medium)
        lb.textAlignment = .center
        return lb
    }()
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .softPink
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()
    private lazy var lbBadge: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 12, weight: .medium)
        lb.textAlignment = .center
        return lb
    }()
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .hotpink
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(lbTitle)
        badgeView.addSubview(lbBadge)
        contentView.addSubview(badgeView)
        contentView.addSubview(indicatorView)
        
        lbTitle.snp.makeConstraints({
            $0.top.leading.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0))
        })
        badgeView.snp.makeConstraints({
            $0.centerY.equalTo(lbTitle.snp.top)
            $0.leading.equalTo(lbTitle.snp.trailing)
            $0.size.greaterThanOrEqualTo(20)
        })
        lbBadge.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
        })
        indicatorView.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(6)
            $0.centerX.equalTo(lbTitle.snp.centerX)
            $0.height.equalTo(6)
            $0.width.equalTo(20)
        })
        layoutIfNeeded()
        badgeView.layer.cornerRadius = badgeView.frame.width / 2
    }
    
    func configure(title: String, friends: [Friend], indexPath: IndexPath) {
        let badge = friends.filter({ $0.status == .inviting }).count
        lbTitle.text = title
        indicatorView.isHidden = indexPath.row == 1
        lbBadge.text = indexPath.row == 0 ? "\(badge)" : "99+"
        if indexPath.row == 0 {        
            badgeView.isHidden = friends.isEmpty
        }
    }
}
