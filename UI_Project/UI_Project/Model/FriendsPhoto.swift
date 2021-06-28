//
//  FriendsPhoto.swift
//  UI_Project
//
//  Created by Shisetsu on 24.06.2021.
//

import Foundation

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
struct Albums: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let postID: Int?
    var sizes: [Photos]
    let text: String
    let likes: Likes
    let reposts: Reposts

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
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Photos: Codable {
//    let height: Int
    let url: String
//    let type: TypeEnum
//    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
