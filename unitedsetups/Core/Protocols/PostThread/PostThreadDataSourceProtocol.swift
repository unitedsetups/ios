//
//  PostThreadDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

protocol PostThreadDataSourceProtocol {
    func createNewPostThread(request: CreatePostThreadRequest) async throws -> PostThreadResponse
    func likePostThread(id: String) async throws -> PostThreadResponse
    func dislikePostThread(id: String) async throws -> PostThreadResponse
}
