//
//  LikePostThreadUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

protocol LikePostThreadUseCase {
    func execute(id: String, liked: Bool) async throws -> Result<PostThread, Error>
}

struct LikePostThreadImpl : LikePostThreadUseCase {
    let repo: PostThreadRepository
    
    func execute(id: String, liked: Bool) async throws -> Result<PostThread, any Error> {
        do {
            if (liked) {
                let postThread = try await repo.likePostThread(id: id)
                return .success(postThread)
            } else {
                let postThread = try await repo.dislikePostThread(id: id)
                return .success(postThread)
            }
        } catch {
            return .failure(error)
        }
    }
}
