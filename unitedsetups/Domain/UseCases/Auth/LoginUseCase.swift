//
//  LoginUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

protocol LoginUseCase {
    func execute(request: LoginRequest) async throws -> Result<Auth, Error>
}

struct LoginUseImpl : LoginUseCase {
    let repo: AuthRepository
    
    func execute(request: LoginRequest) async throws -> Result<Auth, any Error> {
        do {
            let auth = try await repo.login(request: request)
            return .success(auth)
        } catch {
            return .failure(error)
        }
    }
}
