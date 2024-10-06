//
//  User.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct User {
    let id: UUID
    let username: String
    let email: String
    let name: String
    let telegramId: Double?
    let profileImageUrl: String?
    let coverImageUrl: String?
    let role: UserRoles
}

enum UserRoles {
    case Admin
    case Moderator
    case Member
}
