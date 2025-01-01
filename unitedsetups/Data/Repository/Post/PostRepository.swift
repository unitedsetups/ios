//
//  PostRepository.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct PostRepository {
    typealias PostInstance = (PostDataSource) -> PostRepository
    
    fileprivate let dataSource: PostDataSource
    
    private init(dataSource: PostDataSource) {
        self.dataSource = dataSource
    }
    
    static let sharedInstance: PostInstance = { dataSource in
        return PostRepository(dataSource: dataSource)
    }
}

extension PostRepository : PostRepositoryProtocol {
    func createNewPost(request: CreatePostRequest) async throws -> Post {
        do {
            let data = try await dataSource.createNewPost(createPostRequest: request)
            return PostMapper.mapPostResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func getAllPosts(request: GetAllPostsRequest) async throws -> [Post] {
        do {
            let data = try await dataSource.getAllPosts(getAllPostsRequest: request)
            return data.map { postResponse in
                PostMapper.mapPostResponseToDomain(input: postResponse)
            }
        } catch {
            throw error;
        }
    }
    
    func getPostById(id: String) async throws -> Post {
        do {
            let data = try await dataSource.getPostById(id: id)
            return PostMapper.mapPostResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func deletePost(id: String) async throws -> Void {
        do {
            try await dataSource.deletePost(id: id)
        } catch {
            throw error
        }
    }
    
    func likePost(id: String) async throws -> Post {
        do {
            let data = try await dataSource.likePost(id: id)
            return PostMapper.mapPostResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func dislikePost(id: String) async throws -> Post {
        do {
            let data = try await dataSource.dislikePost(id: id)
            return PostMapper.mapPostResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
}
