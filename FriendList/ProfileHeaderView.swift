//
//  ProfileHeaderView.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import UIKit

class ProfileHeaderView: UIView {
    private lazy var lbUserName: UILabel = {
        let lb = UILabel()
        lb.textColor = .greyishBrown
        lb.font = .systemFont(ofSize: 17, weight: .medium)
        return lb
    }()
    private lazy var lbKoKoID: UILabel = {
        let lb = UILabel()
        return lb
    }()
    private lazy var ivUserAvatar: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgFriendsList
        iv.layer.cornerRadius = 26
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(lbUserName)
        addSubview(lbKoKoID)
        addSubview(ivUserAvatar)
        
        lbUserName.snp.makeConstraints({
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview()
        })
        lbKoKoID.snp.makeConstraints({
            $0.top.equalTo(lbUserName.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        ivUserAvatar.snp.makeConstraints({
            $0.size.equalTo(52)
            $0.top.bottom.trailing.equalToSuperview()
        })
    }
    
    func configure(userProfile: UserProfile) {
        lbUserName.text = userProfile.name
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(resource: .greyishBrown),
                                                         .font: UIFont.systemFont(ofSize: 13, weight: .regular)]
        let attributedString = NSMutableAttributedString(string: "KOKO ID：\(userProfile.kokoid)", attributes: attributes)
        let attachment = NSTextAttachment(image: .icInfoBackDeepGray)
        attachment.bounds = CGRect(x: 0, y: -3, width: 16, height: 16)
        attributedString.append(NSAttributedString(attachment: attachment))
        lbKoKoID.attributedText = attributedString
    }
}
