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
}
