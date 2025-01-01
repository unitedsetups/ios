//
//  DeletePostUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 1/1/25.
//

protocol DeletePostUseCase {
    func execute(id: String) async throws -> Result<Bool, Error>
}

struct DeletePostImpl: DeletePostUseCase {
    let repo: PostRepository
    func execute(id: String) async throws -> Result<Bool, any Error> {
        do {
            try await repo.deletePost(id: id)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}

