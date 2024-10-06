//
//  AuthDataRepositoryProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(request: LoginRequest) async throws -> Auth
    func register(request: RegisterRequest) async throws -> Auth
}
