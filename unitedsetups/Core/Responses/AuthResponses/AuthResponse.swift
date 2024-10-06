//
//  AuthResponse.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct AuthResponse: Decodable {
    let id: String
    let email: String
    let token: String
}

enum AuthMapper {
    static func mapAuthResponseToDomain(input response: AuthResponse) -> Auth {
        return Auth(id: UUID.init(uuidString: response.id)!, email: response.email, token: response.token)
    }
}
