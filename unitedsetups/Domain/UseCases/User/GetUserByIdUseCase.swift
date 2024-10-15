//
//  GetUserByIdUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

protocol GetUserByIdUseCase {
    func execute(id: String) async throws -> Result<User, Error>
}

struct GetUserByIdImpl: GetUserByIdUseCase {
    let repo: UserRepository
    func execute(id: String) async throws -> Result<User, any Error> {
        do {
            let user = try await repo.getUserById(id: id)
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
}
