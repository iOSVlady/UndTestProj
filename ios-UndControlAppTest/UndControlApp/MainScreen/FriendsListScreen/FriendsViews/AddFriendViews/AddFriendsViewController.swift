//
//  AddFriendsViewController.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//

import UIKit
import SnapKit
import Combine

class AddFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    private let tableView = UITableView()
    private let viewModel = AddFriendsViewModel()
    private let footerView = UIView()
    private var shouldLoadMore = false
    private var cancellables = Set<AnyCancellable>()
    private var isLoadingMoreData = false
    var friendsManager: FriendsManager?

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.isHidden = true
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.contentInset.bottom = 100 // Add bottom space
        loadMoreData()
    }

    private func loadMoreData() {
        guard !isLoadingMoreData else { return }

        isLoadingMoreData = true
        loader.isHidden = false
        loader.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let oldDataCount = self.viewModel.numberOfRows()
            
            self.viewModel.loadRandomUsers { newUsersCount in
                let newDataCount = oldDataCount + newUsersCount
                let indexPathsToReload = self.calculateIndexPathsToReload(from: oldDataCount, newDataCount: newDataCount)
                self.tableView.insertRows(at: indexPathsToReload, with: .automatic)
                
                self.loader.isHidden = true
                self.loader.stopAnimating()
                self.isLoadingMoreData = false
            }
        }
    }
    
    private func calculateIndexPathsToReload(from oldDataCount: Int, newDataCount: Int) -> [IndexPath] {
        let startIndex = oldDataCount
        let endIndex = newDataCount - 1
        return (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            self.loadMoreData()
            
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
        tableView.setEditing(true, animated: false)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        footerView.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        tableView.tableFooterView = footerView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        footerView.frame = CGRect(x: 0, y: 0,
                                  width: tableView.frame.width,
                                  height: 50)
        loader.center = CGPoint(x: footerView.bounds.midX, y: footerView.bounds.midY)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        cell.option = true
        cell.setupButton()
        let friend = viewModel.userAt(indexPath.row)
        let firstName = friend.name?.first ?? ""
        let lastName = friend.name?.last ?? ""
        cell.nameLabel.text = "\(firstName) \(lastName)"
        let imageUrlString = friend.picture?.thumbnail ?? ""
        cell.configure(with: imageUrlString)

        // Handle add action
        cell.addAction = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.addFriendAt(indexPath.row)
            let newFriend = self.viewModel.userAt(indexPath.row)
            self.friendsManager?.addFriend(newFriend)
            
            UIView.transition(with: cell.button!,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                // Update the option and redraw the button
                cell.option = false
                cell.setupButton()
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                UIView.transition(with: cell.button!,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    // Update the option and redraw the button
                    cell.option = true
                    cell.setupButton()
                }, completion: nil)
            }
        }

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped cell at row: \(indexPath.row)")

        // Deselect the tapped cell, so it doesn't remain highlighted
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
