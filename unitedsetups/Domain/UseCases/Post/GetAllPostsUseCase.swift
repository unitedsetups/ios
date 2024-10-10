//
//  GetAllUseCase.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

protocol GetAllPostsUseCase {
    func execute(request: GetAllPostsRequest) async throws -> Result<[Post], Error>
}

struct GetAllPostsImpl : GetAllPostsUseCase {
    let repo : PostRepository
    
    func execute(request: GetAllPostsRequest) async throws -> Result<[Post], any Error> {
        do {
            let posts = try await repo.getAllPosts(request: request)
            return .success(posts)
        } catch {
            return .failure(error)
        }
    }
}
