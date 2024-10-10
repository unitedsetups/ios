//
//  UserResponse.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct UserResponse: Decodable {
    let id: String
    let username: String
    let email: String
    let name: String
    let telegramId: Double?
    let profileImageUrl: String?
    let coverImageUrl: String?
    let role: String
}

enum UserMapper {
    static func mapUserResponseToDomain(input response: UserResponse) -> User {
        var role: UserRoles = UserRoles.Member
        
        switch response.role.lowercased() {
            case "admin":
                role = UserRoles.Admin
            case "moderator":
                role = UserRoles.Moderator
            default:
                role = UserRoles.Member
        }
        
        return User(
            id: UUID.init(uuidString: response.id)!,
            username: response.username,
            email: response.email,
            name: response.name,
            telegramId: response.telegramId,
            profileImageUrl: response.profileImageUrl,
            coverImageUrl: response.coverImageUrl,
            role: role
        )
    }
}
