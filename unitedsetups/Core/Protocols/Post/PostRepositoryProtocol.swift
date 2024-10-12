//
//  PostRepositoryProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

protocol PostRepositoryProtocol {
    func getAllPosts(request: GetAllPostsRequest) async throws -> [Post]
    func createNewPost(request: CreatePostRequest) async throws -> Post
}
