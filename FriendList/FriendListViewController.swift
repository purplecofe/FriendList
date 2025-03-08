//
//  FriendListViewController.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/8.
//

import UIKit

class FriendListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FriendListTableViewCell.self, forCellReuseIdentifier: "FriendListTableViewCell")
        tableView.dataSource = self
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.refreshControl = pullToRefreshControl
        return tableView
    }()
    private lazy var pullToRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var btnAdd: UIButton = {
        let btn = UIButton()
        btn.setImage(.icBtnAddFriends, for: .normal)
        return btn
    }()
    private let viewModel: FriendViewModel
    var pullToRefreshCallback: (() -> Void)?
    
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
private extension FriendListViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(btnAdd)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints({
            $0.top.leading.equalToSuperview().priority(.high)
        })
        btnAdd.snp.makeConstraints({
            $0.leading.equalTo(searchBar.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(searchBar)
        })
        tableView.snp.makeConstraints({
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.pullToRefreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    @objc func refresh() {
        pullToRefreshCallback?()
    }
}
extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.acceptedFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTableViewCell", for: indexPath) as? FriendListTableViewCell else {
            return UITableViewCell()
        }
        let friend = viewModel.acceptedFriends[indexPath.row]
        cell.configure(friend: friend)
        return cell
    }
}
extension FriendListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterFriends(by: searchText)
    }
}
