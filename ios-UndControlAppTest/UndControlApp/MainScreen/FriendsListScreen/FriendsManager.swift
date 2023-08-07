//
//  FriendsManager.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 07.08.2023.
//


import SwiftUI
import Combine

class FriendsManager: ObservableObject {
    @Published var friends: [Person] = []

    func addFriend(_ newFriend: Person) {
        friends.append(newFriend)
    }
}
