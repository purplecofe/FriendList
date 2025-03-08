//
//  InviteListViewController.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import UIKit

protocol InviteListViewControllerDelegate: AnyObject {
    func didUpdateContentHeight(_ height: CGFloat)
}

class InviteListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: overlapLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(InviteListCollectionViewCell.self, forCellWithReuseIdentifier: "InviteListCollectionViewCell")
        return collectionView
    }()
    private lazy var overlapLayout: OverlapLayout = {
        let layout = OverlapLayout()
        layout.cardSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
        return layout
    }()
    private lazy var expandedFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 70)
        return layout
    }()
    private var isExpanded = false
    private let viewModel: FriendViewModel
    weak var delegate: InviteListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension InviteListViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}
extension InviteListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.inviteSentFriends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InviteListCollectionViewCell", for: indexPath) as? InviteListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let friend = viewModel.inviteSentFriends[indexPath.row]
        cell.configure(friend: friend)
        return cell
    }
}
extension InviteListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let offset: CGFloat = 10
        if isExpanded {
            isExpanded = false
            collectionView.setCollectionViewLayout(overlapLayout, animated: true)
        } else {
            isExpanded = true
            collectionView.setCollectionViewLayout(expandedFlowLayout, animated: true)
        }
        collectionView.layoutIfNeeded()
        delegate?.didUpdateContentHeight(collectionView.contentSize.height + offset)
    }
}
