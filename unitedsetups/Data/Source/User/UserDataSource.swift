//
//  UserDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct UserDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let httpManager: HttpManager = Injection.shared.provideHttpManager()
    
    private init() {}
    
    static let shared: UserDataSource = UserDataSource()
}

extension UserDataSource : UserDataSourceProtocol {
    func getUserById(id: String) async throws -> UserResponse {
        let (data, _) = try await httpManager.GET(
            url: URL(string: Constants.getUserByIdEndpoint(id)),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() }
        )
        
        do {
            return try JSONDecoder().decode(UserResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func getMyProfile() async throws -> UserResponse {
        let (data, _) = try await httpManager.GET(
            url: URL(string: Constants.getMyProfileEndpoint),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() }
        )
        
        do {
            return try JSONDecoder().decode(UserResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    private func revokeAccessToken() {
        tokenManager.revokeAccessToken()
    }
    
    private func getAccessToken() -> String {
        return tokenManager.getAccessToken()
    }
}
