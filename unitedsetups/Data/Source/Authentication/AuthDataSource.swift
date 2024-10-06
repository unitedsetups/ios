//
//  AuthDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct AuthDataSource {
    private init() {}
    
    static let shared: AuthDataSource = AuthDataSource()
}

extension AuthDataSource : AuthDataSourceProtocol {
    func login(loginRequest: LoginRequest) async throws -> AuthResponse {
        guard let url = URL(string: Constants.loginEndpoint()) else { throw URLErrors.InvalidUrl }
        guard let jsonData = try? JSONEncoder().encode(loginRequest) else { throw URLErrors.FailedToEncodeRequest }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode < 400 else { throw URLErrors.InvalidResponse }
        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func register(registerRequest: RegisterRequest) async throws -> AuthResponse {
        guard let url = URL(string: Constants.loginEndpoint()) else { throw URLErrors.InvalidUrl }
        guard let jsonData = try? JSONEncoder().encode(registerRequest) else { throw URLErrors.FailedToEncodeRequest }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode < 400 else { throw URLErrors.InvalidResponse }
        do {
            return try JSONDecoder().decode(AuthResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
}
