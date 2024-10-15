//
//  GetMyProfileUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

protocol GetMyProfileUseCase {
    func execute() async throws -> Result<User, Error>
}

struct GetMyProfileImpl: GetMyProfileUseCase {
    let repo: UserRepository
    func execute() async throws -> Result<User, any Error> {
        do {
            let user = try await repo.getMyProfile()
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
}
