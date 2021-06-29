//
//  Friends.swift
//  UI_Project
//
//  Created by Shisetsu on 24.06.2021.
//

import Foundation

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
struct User: Codable {
    let id: Int
    let sex: Int?
    let firstName: String
    let bdate: String?
    let city: City?
    let lastName: String
    let photo100: String
    let online: Int
    let status: String?

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
}
// MARK: - City
struct City: Codable {
    let title: String
}
