//
//  PostThreadRepositoryProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

protocol PostThreadRepositoryProtocol {
    func createPostThread(request: CreatePostThreadRequest) async throws -> PostThread
    func likePostThread(id: String) async throws -> PostThread
    func dislikePostThread(id: String) async throws -> PostThread
}
