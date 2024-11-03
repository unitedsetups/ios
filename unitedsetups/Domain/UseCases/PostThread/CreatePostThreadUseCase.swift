//
//  CreatePostThreadUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

protocol CreatePostThreadUseCase {
    func execute(request: CreatePostThreadRequest) async throws -> Result<PostThread, Error>
}

struct CreatePostThreadImpl : CreatePostThreadUseCase {
    let repo: PostThreadRepository
    
    func execute(request: CreatePostThreadRequest) async throws -> Result<PostThread, any Error> {
        do {
            let postThread = try await repo.createPostThread(request: request)
            return .success(postThread)
        } catch {
            return .failure(error)
        }
    }
}
