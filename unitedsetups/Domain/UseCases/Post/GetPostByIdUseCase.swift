//
//  GetPostByIdUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

protocol GetPostByIdUseCase {
    func execute(id: String) async throws -> Result<Post, Error>
}

struct GetPostByIdImpl: GetPostByIdUseCase {
    let repo: PostRepository
    func execute(id: String) async throws -> Result<Post, any Error> {
        do {
            let post = try await repo.getPostById(id: id)
            return .success(post)
        } catch {
            return .failure(error)
        }
    }
}
