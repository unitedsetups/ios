//
//  CreateNewPostUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

protocol CreateNewPostUseCase {
    func execute(request: CreatePostRequest) async throws -> Result<Post, Error>
}

struct CreateNewPostImpl : CreateNewPostUseCase {
    let repo: PostRepository
    
    func execute(request: CreatePostRequest) async throws -> Result<Post, any Error> {
        do {
            let post = try await repo.createNewPost(request: request)
            return .success(post)
        } catch {
            return .failure(error)
        }
    }
}
