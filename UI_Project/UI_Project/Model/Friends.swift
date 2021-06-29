//
//  Friends.swift
//  UI_Project
//
//  Created by Shisetsu on 24.06.2021.
//

import Foundation
import RealmSwift

// MARK: - Friends
struct Friends: Codable {
    let response: ResponseUser
}
// MARK: - Response
struct ResponseUser: Codable {
    let count: Int
    let items: [User]
}
// MARK: - Item
class User: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var sex = 0
    @objc dynamic var firstName = ""
    @objc dynamic var bdate: String? = nil
    @objc dynamic var city: City?
    @objc dynamic var lastName = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var online = 0
    @objc dynamic var status = ""

    enum CodingKeys: String, CodingKey {
        case id
        case sex
        case firstName = "first_name"
        case bdate, city
        case lastName = "last_name"
        case photo100 = "photo_200_orig"
        case online
        case status
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
// MARK: - City
class City: Object, Codable {
    @objc dynamic var title = ""
}
