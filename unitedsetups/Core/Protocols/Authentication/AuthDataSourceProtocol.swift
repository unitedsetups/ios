//
//  AuthDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

protocol AuthDataSourceProtocol {
    func login(loginRequest: LoginRequest) async throws -> AuthResponse
    func register(registerRequest: RegisterRequest) async throws -> AuthResponse
}
