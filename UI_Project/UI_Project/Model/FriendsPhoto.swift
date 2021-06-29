//
//  FriendsPhoto.swift
//  UI_Project
//
//  Created by Shisetsu on 24.06.2021.
//

import Foundation
import RealmSwift

// MARK: - FriendsPhoto
struct FriendsPhoto: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    var items: [Albums]
}

// MARK: - Item
class Albums: Object, Codable {
    @objc dynamic var albumID, date, id, ownerID: Int
    let hasTags: Bool
    let postID: Int?
    @objc dynamic var sizes: [Photos]
    let text: String
    @objc dynamic var likes: Likes
    @objc dynamic var reposts: Reposts

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case postID = "post_id"
        case sizes, text, likes, reposts
    }
}

// MARK: - Likes
class Likes: Object, Codable {
    @objc dynamic var userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
class Reposts: Object, Codable {
    @objc dynamic var count: Int
}

// MARK: - Size
class Photos: Object, Codable {
    @objc dynamic var url: String
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

