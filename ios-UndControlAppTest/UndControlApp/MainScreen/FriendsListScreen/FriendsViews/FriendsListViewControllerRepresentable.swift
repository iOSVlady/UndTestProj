//
//  FriendsListViewControllerRepresentable.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 07.08.2023.
//

import SwiftUI
import UIKit

struct FriendsListViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var friendsManager: FriendsManager
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> FriendsListViewController {
        let viewController = FriendsListViewController()
        viewController.friendsManager = friendsManager
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: FriendsListViewController, context: Context) {}
    
    class Coordinator: NSObject {
        var parent: FriendsListViewControllerRepresentable

        init(_ parent: FriendsListViewControllerRepresentable) {
            self.parent = parent
        }
    }
}
