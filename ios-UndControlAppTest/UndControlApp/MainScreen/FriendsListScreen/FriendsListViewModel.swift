//
//  FriendsListViewModel.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//

import UIKit
import Combine
import RealmSwift

class FriendsListViewModel {
    private var friends: [Person] = []
       
    func loadFriends(completionHandler: @escaping () -> Void) {
        do {
            let realm = try Realm()
            let friends = realm.objects(Person.self)
            self.friends = Array(friends)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completionHandler()
            }
        } catch {
            print("Error fetching friends from the database: \(error)")
            completionHandler()
        }
    }

    func numberOfRows() -> Int {
        return friends.count
    }

    func friendAt(_ index: Int) -> Person {
        return friends[index]
    }

    func deleteFriendAt(_ index: Int) {
        let friend = friends[index]

        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(friend)
            }
            friends.remove(at: index)
        } catch {
            print("Error deleting friend from the database: \(error)")
        }
    }
}


class AddFriendsViewModel {
    private var randomUsers: [Person] = []

    func loadRandomUsers(completionHandler: @escaping (Int) -> Void) {
        PersonAPI.shared.fetchPersons { result in
            switch result {
            case .success(let persons):
                DispatchQueue.main.async {
                    let oldCount = self.randomUsers.count
                    self.randomUsers.append(contentsOf: persons)
                    let newCount = self.randomUsers.count
                    completionHandler(newCount - oldCount)
                }
            case .failure(let error):
                print("Error fetching persons: \(error)")
            }
        }
    }

    func numberOfRows() -> Int {
        return randomUsers.count
    }

    func userAt(_ index: Int) -> Person {
        return randomUsers[index]
    }

    func addFriendAt(_ index: Int) {
        let user = randomUsers[index]

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            debugPrint("Unable to save Person:", error.localizedDescription)
        }
    }
}
