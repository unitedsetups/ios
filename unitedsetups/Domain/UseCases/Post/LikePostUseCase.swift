//
//  LikePostUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

protocol LikePostUseCase {
    func execute(id: String, liked: Bool) async throws -> Result<Post, Error>
}

struct LikePostImpl: LikePostUseCase {
    let repo: PostRepository
    func execute(id: String, liked: Bool) async throws -> Result<Post, any Error> {
        do {
            if (liked) {
                let post = try await repo.likePost(id: id)
                return .success(post)
            } else {
                let post = try await repo.dislikePost(id: id)
                return .success(post)
            }
        } catch {
            return .failure(error)
        }
    }
}
