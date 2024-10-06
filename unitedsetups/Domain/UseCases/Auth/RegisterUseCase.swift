//
//  RegisterUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

protocol RegisterUseCase {
    func execute(request: RegisterRequest) async throws -> Result<Auth, Error>
}

struct RegisterUseImpl : RegisterUseCase {
    let repo: AuthRepository
    
    func execute(request: RegisterRequest) async throws -> Result<Auth, any Error> {
        do {
            let auth = try await repo.register(request: request)
            return .success(auth)
        } catch {
            return .failure(error)
        }
    }
}
