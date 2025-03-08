//
//  InviteListCollectionViewCell.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import UIKit

class InviteListCollectionViewCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    private lazy var ivUserAvatar: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.backgroundColor = .red
        return iv
    }()
    private lazy var lbUserName: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        return lb
    }()
    private lazy var lbDescription: UILabel = {
        let lb = UILabel()
        lb.text = "邀請你成為好友：）"
        lb.textColor = .lightGrey
        lb.font = .systemFont(ofSize: 13, weight: .regular)
        return lb
    }()
    private lazy var btnAccept: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnFriendsAgree, for: .normal)
        return btn
    }()
    private lazy var btnDeny: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnFriendsDelet, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.addSubview(ivUserAvatar)
        containerView.addSubview(lbUserName)
        containerView.addSubview(lbDescription)
        containerView.addSubview(btnAccept)
        containerView.addSubview(btnDeny)
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
        })
        ivUserAvatar.snp.makeConstraints({
            $0.top.leading.bottom.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0))
            $0.size.equalTo(40)
        })
        lbUserName.snp.makeConstraints({
            $0.top.equalTo(ivUserAvatar.snp.top)
            $0.leading.equalTo(ivUserAvatar.snp.trailing).offset(15)
        })
        lbDescription.snp.makeConstraints({
            $0.top.equalTo(lbUserName.snp.bottom).offset(2)
            $0.leading.equalTo(lbUserName.snp.leading)
        })
        btnDeny.snp.makeConstraints({
            $0.top.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 15))
            $0.size.equalTo(30)
        })
        btnAccept.snp.makeConstraints({
            $0.trailing.equalTo(btnDeny.snp.leading).offset(-15)
            $0.top.bottom.equalToSuperview().inset(20)
        })
    }
    
    func configure(friend: Friend) {
        lbUserName.text = friend.name
    }
}
