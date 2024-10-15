//
//  PostDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct PostDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let httpManager: HttpManager = Injection.shared.provideHttpManager()
    
    private init() {}
    
    static let shared: PostDataSource = PostDataSource()
}

extension PostDataSource : PostDataSourceProtocol {
    func createNewPost(createPostRequest: CreatePostRequest) async throws -> PostResponse {
        guard let jsonData = try? JSONEncoder().encode(createPostRequest) else {
            throw URLErrors.FailedToEncodeRequest
        }
        
        let (data, _) = try await httpManager.POST(
            url: URL(string: Constants.postsEndpoint),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() },
            body: jsonData
        )
        
        do {
            return try JSONDecoder().decode(PostResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func getAllPosts(getAllPostsRequest: GetAllPostsRequest) async throws -> [PostResponse] {
        let (data, _) = try await httpManager.GET(
            url: URL(string: Constants.getAllPostsEndpoint(getAllPostsRequest)),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() }
        )
        
        do {
            return try JSONDecoder().decode([PostResponse].self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func getPostById(id: String) async throws -> PostResponse {
        let (data, _) = try await httpManager.GET(
            url: URL(string: Constants.getPostByIdEndpoint(id)),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() }
        )
        
        do {
            return try JSONDecoder().decode(PostResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    private func revokeAccessToken() {
        _ = tokenManager.saveAccessToken(access_token: "")
    }
    
    private func getAccessToken() -> String {
        return tokenManager.getAccessToken()
    }
}
