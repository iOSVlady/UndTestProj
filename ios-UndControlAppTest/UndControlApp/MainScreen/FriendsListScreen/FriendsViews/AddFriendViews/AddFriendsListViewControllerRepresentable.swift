//
//  AddFriendsListViewControllerRepresentable.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 07.08.2023.
//

import SwiftUI
import UIKit

struct AddFriendsViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var friendsManager: FriendsManager
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> AddFriendsViewController {
        let viewController = AddFriendsViewController()
        viewController.friendsManager = friendsManager
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: AddFriendsViewController, context: Context) {
        // Update the view controller if needed
    }
    
    class Coordinator: NSObject {
        var parent: AddFriendsViewControllerRepresentable

        init(_ parent: AddFriendsViewControllerRepresentable) {
            self.parent = parent
        }
    }
}
