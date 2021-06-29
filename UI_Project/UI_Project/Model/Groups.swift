//
//  Groups.swift
//  UI_Project
//
//  Created by Shisetsu on 27.06.2021.
//

import Foundation
import RealmSwift

// MARK: - Groups
struct Groups: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [GroupsList]
}

// MARK: - Item
class GroupsList: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var photo200: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo200 = "photo_200"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

