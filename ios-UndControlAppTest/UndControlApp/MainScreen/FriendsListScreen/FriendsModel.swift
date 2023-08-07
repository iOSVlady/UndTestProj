//
//  FriendsListModel.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//

import Foundation
import RealmSwift

struct PersonResponse: Codable {
    let results: [Person]
    let info: Info
}

struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

class Person: Object, Codable {
    @objc dynamic var gender: String = ""
    @objc dynamic var name: Name?
    @objc dynamic var location: Location?
    @objc dynamic var email: String = ""
    @objc dynamic var login: Login?
    @objc dynamic var dob: Dob?
    @objc dynamic var registered: Registered?
    @objc dynamic var phone: String = ""
    @objc dynamic var cell: String = ""
    @objc dynamic var id: Id?
    @objc dynamic var picture: Picture?
    @objc dynamic var nat: String = ""

    override static func primaryKey() -> String? {
        return "email"
    }
}

class Name: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var first: String = ""
    @objc dynamic var last: String = ""
}

class Street: Object, Codable {
    @objc dynamic var number: Int = 0
    @objc dynamic var name: String = ""
}

class Coordinates: Object, Codable {
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""
}

class Timezone: Object, Codable {
    @objc dynamic var offset: String = ""
    @objc dynamic var timeDescription: String? = ""
}

class Login: Object, Codable {
    @objc dynamic var uuid: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var salt: String = ""
    @objc dynamic var md5: String = ""
    @objc dynamic var sha1: String = ""
    @objc dynamic var sha256: String = ""
}

class Dob: Object, Codable {
    @objc dynamic var date: String = ""
    @objc dynamic var age: Int = 0
}

class Registered: Object, Codable {
    @objc dynamic var date: String = ""
    @objc dynamic var age: Int = 0
}

class Id: Object, Codable {
    @objc dynamic var name: String = ""
    @objc dynamic var value: String?
}

class Picture: Object, Codable {
    @objc dynamic var large: String = ""
    @objc dynamic var medium: String = ""
    @objc dynamic var thumbnail: String = ""
}

class Location: Object, Codable {
    @objc dynamic var street: Street?
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var coordinates: Coordinates?
    @objc dynamic var timezone: Timezone?
    let postcode = RealmOptional<Int>()

}

enum Postcode: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
            return
        }
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
            return
        }
        throw DecodingError.typeMismatch(
            Postcode.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode")
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .int(intValue):
            try container.encode(intValue)
        case let .string(stringValue):
            try container.encode(stringValue)
        }
    }
}
