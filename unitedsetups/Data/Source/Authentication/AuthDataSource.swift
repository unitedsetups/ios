//
//  AuthDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct AuthDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let httpManager: HttpManager = Injection.shared.provideHttpManager()
    
    private init() {}
    
    static let shared: AuthDataSource = AuthDataSource()
}

extension AuthDataSource : AuthDataSourceProtocol {
    func login(loginRequest: LoginRequest) async throws -> AuthResponse {
        guard let jsonData = try? JSONEncoder().encode(loginRequest) else { throw URLErrors.FailedToEncodeRequest }
        
        let (data, _) = try await httpManager.POST(
            url: URL(string: Constants.loginEndpoint()),
            accessToken: tokenManager.getAccessToken(),
            revokeAccessToken: { tokenManager.revokeAccessToken() },
            body: jsonData
        )
        
        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func register(registerRequest: RegisterRequest) async throws -> AuthResponse {
        guard let jsonData = try? JSONEncoder().encode(registerRequest) else { throw URLErrors.FailedToEncodeRequest }
        
        let (data, _) = try await httpManager.POST(
            url: URL(string: Constants.registerEndpoint()),
            accessToken: tokenManager.getAccessToken(),
            revokeAccessToken: { tokenManager.revokeAccessToken() },
            body: jsonData
        )

        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
}
