//
//  Groups.swift
//  UI_Project
//
//  Created by Shisetsu on 27.06.2021.
//

import Foundation

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
struct GroupsList: Codable, Equatable {
    let id: Int
    var name, screenName: String
    let type: GroupType
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case type
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}

