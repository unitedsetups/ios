//
//  PostThreadRepository.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

import Foundation

struct PostThreadRepository {
    typealias PostThreadInstance = (PostThreadDataSource) -> PostThreadRepository
    
    fileprivate let dataSource: PostThreadDataSource
    
    private init(dataSource: PostThreadDataSource) {
        self.dataSource = dataSource
    }
    
    static let sharedInstance: PostThreadInstance = { dataSource in return PostThreadRepository(dataSource: dataSource) }
}

extension PostThreadRepository : PostThreadRepositoryProtocol {
    func createPostThread(request: CreatePostThreadRequest) async throws -> PostThread {
        do {
            let data = try await dataSource.createNewPostThread(request: request)
            return PostThreadMapper.mapPostThreadResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func likePostThread(id: String) async throws -> PostThread {
        do {
            let data = try await dataSource.likePostThread(id: id)
            return PostThreadMapper.mapPostThreadResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func dislikePostThread(id: String) async throws -> PostThread {
        do {
            let data = try await dataSource.dislikePostThread(id: id)
            return PostThreadMapper.mapPostThreadResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
}
