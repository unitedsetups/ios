//
//  PostDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

protocol PostDataSourceProtocol {
    func getAllPosts(getAllPostsRequest: GetAllPostsRequest) async throws -> [PostResponse]
    func createNewPost(createPostRequest: CreatePostRequest) async throws -> PostResponse
    func getPostById(id: String) async throws -> PostResponse
    func likePost(id: String) async throws -> PostResponse
    func dislikePost(id: String) async throws -> PostResponse
}
