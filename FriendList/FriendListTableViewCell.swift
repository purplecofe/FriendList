//
//  FriendListTableViewCell.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/8.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    private lazy var ivIsTop: UIImageView = {
        let iv = UIImageView(image: .icFriendsStar)
        return iv
    }()
    private lazy var ivAvatar: UIImageView = {
        let iv = UIImageView(image: .imgFriendsList)
        iv.layer.cornerRadius = 20
        return iv
    }()
    private lazy var lbName: UILabel = {
        let lb = UILabel()
        lb.textColor = .greyishBrown
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        return lb
    }()
    private lazy var btnTransfer: UIButton = {
        let btn = UIButton()
        btn.setTitle("轉帳", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.setTitleColor(.hotpink, for: .normal)
        btn.layer.borderColor = UIColor.hotpink.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        return btn
    }()
    private lazy var btnInviting: UIButton = {
        let btn = UIButton()
        btn.setTitle("邀請中", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.setTitleColor(.lightGrey, for: .normal)
        btn.layer.borderColor = UIColor.lightGrey.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 2
        return btn
    }()
    private lazy var btnMore: UIButton = {
        let btn = UIButton()
        btn.setImage(.icFriendsMore, for: .normal)
        return btn
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [btnTransfer])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .transferMoney
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach({
            $0.removeFromSuperview()
        })
        stackView.addArrangedSubview(btnTransfer)
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(ivIsTop)
        contentView.addSubview(ivAvatar)
        contentView.addSubview(lbName)
        contentView.addSubview(stackView)
        contentView.addSubview(underLineView)
        
        ivIsTop.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
        ivAvatar.snp.makeConstraints({
            $0.leading.equalTo(ivIsTop.snp.trailing).offset(6)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        })
        lbName.snp.makeConstraints({
            $0.leading.equalTo(ivAvatar.snp.trailing).offset(15)
            $0.centerY.equalTo(ivAvatar)
            $0.width.equalTo(100)
        })
        stackView.snp.makeConstraints({
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
        underLineView.snp.makeConstraints({
            $0.leading.equalTo(lbName)
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        })
        btnTransfer.snp.makeConstraints({
            $0.width.greaterThanOrEqualTo(47)
        })
    }
    
    func configure(friend: Friend) {
        ivIsTop.isHidden = !friend.isTop
        lbName.text = friend.name
        switch friend.status {
        case .inviteSent:
            break
        case .inviting:
            stackView.addArrangedSubview(btnInviting)
        case .completed:
            stackView.addArrangedSubview(btnMore)
        }
    }
}

