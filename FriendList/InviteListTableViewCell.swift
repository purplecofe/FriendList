//
//  InviteListTableViewCell.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import UIKit

class InviteListTableViewCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        return view
    }()
    private lazy var ivUserAvatar: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
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
            $0.trailing.equalTo(btnDeny.snp.leading).offset(15)
            $0.top.bottom.equalToSuperview().inset(20)
        })
    }
}
