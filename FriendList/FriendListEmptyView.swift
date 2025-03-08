//
//  FriendListEmptyView.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/9.
//

import UIKit

class FriendListEmptyView: UIView {
    private lazy var ivPlaceholder: UIImageView = {
        let iv = UIImageView(image: .imgFriendsEmpty)
        return iv
    }()
    private lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "就從加好友開始吧：）"
        lb.textColor = .greyishBrown
        lb.font = .systemFont(ofSize: 21, weight: .medium)
        lb.textAlignment = .center
        return lb
    }()
    private lazy var lbDescription: UILabel = {
        let lb = UILabel()
        lb.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        lb.textColor = .lightGray
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 14, weight: .regular)
        lb.numberOfLines = 0
        return lb
    }()
    private lazy var btnAddFriend: UIButton = {
        let btn = UIButton()
        btn.setTitle("加好友", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(.white, for: .normal)
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.frogGreen.cgColor,
            UIColor.booger.cgColor
        ]
        btn.layer.insertSublayer(layer, at: 0)
        gradientLayer = layer
        return btn
    }()
    private lazy var lbHint: UILabel = {
        let lb = UILabel()
        var style = NSMutableParagraphStyle()
        style.alignment = .center
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 13, weight: .regular),
            .paragraphStyle: style
        ]
        var attributedString = NSMutableAttributedString(string: "幫助好友更快找到你？", attributes: attributes)
        attributes.updateValue(NSUnderlineStyle.single.rawValue, forKey: .underlineStyle)
        attributes.updateValue(UIColor.hotpink, forKey: .underlineColor)
        attributes.updateValue(UIColor.hotpink, forKey: .foregroundColor)
        var attributedString2 = NSMutableAttributedString(string: "設定 KOKO ID", attributes: attributes)
        attributedString.append(attributedString2)
        lb.attributedText = attributedString
        return lb
    }()
    private lazy var ivAddFriend: UIImageView = {
        let iv = UIImageView(image: .icAddFriendWhite)
        return iv
    }()
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = btnAddFriend.bounds
        gradientLayer?.cornerRadius = 20
        btnAddFriend.layer.cornerRadius = 20
        btnAddFriend.layer.masksToBounds = false
        btnAddFriend.layer.shadowColor = UIColor.frogGreen.cgColor
        btnAddFriend.layer.shadowOpacity = 0.3
        btnAddFriend.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnAddFriend.layer.shadowRadius = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(ivPlaceholder)
        addSubview(lbTitle)
        addSubview(lbDescription)
        btnAddFriend.addSubview(ivAddFriend)
        addSubview(btnAddFriend)
        addSubview(lbHint)
        
        ivPlaceholder.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
        })
        lbTitle.snp.makeConstraints({
            $0.top.equalTo(ivPlaceholder.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
        })
        lbDescription.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        })
        btnAddFriend.snp.makeConstraints({
            $0.top.equalTo(lbDescription.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        })
        ivAddFriend.snp.makeConstraints({
            $0.top.trailing.bottom.equalToSuperview().inset(8)
        })
        lbHint.snp.makeConstraints({
            $0.top.equalTo(btnAddFriend.snp.bottom).offset(37)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        })
    }
}
