//
//  UserDatabaseServiceProtocol.swift
//  UI_Project
//
//  Created by Shisetsu on 06.07.2021.
//

import Foundation

protocol UsersDatabaseServiceProtocol {
    func add(user: [UserModel])
    func read() -> [UserModel]
    func delete(user: UserModel)
}
