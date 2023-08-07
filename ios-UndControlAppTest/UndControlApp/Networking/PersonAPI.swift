//
//  PersonAPI.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 07.08.2023.
//

import Foundation

class PersonAPI {
    static let shared = PersonAPI()

    private init() {}

    func fetchPersons(completion: @escaping (Result<[Person], Error>) -> Void) {
        let urlString = "https://randomuser.me/api/?results=20"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let personResponse = try decoder.decode(PersonResponse.self, from: data)
                        completion(.success(personResponse.results))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "Unknown URLSession error", code: -1, userInfo: nil)))
                    }
                }
            }
        }
        
        task.resume()
    }
}
