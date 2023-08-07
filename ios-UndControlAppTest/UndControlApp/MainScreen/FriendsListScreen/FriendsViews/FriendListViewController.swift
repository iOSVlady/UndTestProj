//
//  FriendListViewController.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//

import UIKit
import SnapKit
import Combine
import SDWebImage

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let viewModel = FriendsListViewModel()
    private var cancellables = Set<AnyCancellable>()

    var friendsManager: FriendsManager? {
        didSet {
            observeFriends()
        }
    }
    
    private func observeFriends() {
        friendsManager?.$friends
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.viewModel.loadFriends {
                        self?.tableView.reloadData()
                    }
                }
            }
            .store(in: &cancellables)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.loadFriends() {
            self.tableView.reloadData()
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
        tableView.setEditing(true, animated: false)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfRows()
     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        let friend = viewModel.friendAt(indexPath.row)
        let firstName = friend.name?.first ?? ""
        let lastName = friend.name?.last ?? ""
        cell.nameLabel.text = "\(firstName) \(lastName)"
        let imageUrlString = friend.picture?.thumbnail ?? ""
        cell.configure(with: imageUrlString)
        
        // Handle delete action
        cell.addAction = { [weak self] in
            self?.viewModel.deleteFriendAt(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                tableView.reloadData()
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
