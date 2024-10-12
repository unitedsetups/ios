//
//  PostDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct PostDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    
    private init() {}
    
    static let shared: PostDataSource = PostDataSource()
}

extension PostDataSource : PostDataSourceProtocol {
    func createNewPost(createPostRequest: CreatePostRequest) async throws -> PostResponse {
        guard let url = URL(string: Constants.postsEndpoint()) else { throw URLErrors.InvalidUrl }
        guard let jsonData = try? JSONEncoder().encode(createPostRequest) else {
            throw URLErrors.FailedToEncodeRequest
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(tokenManager.getAccessToken())", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode < 402 else {
            throw URLErrors.InvalidResponse
        }
        
        if response.statusCode == 401 {
            _ = tokenManager.saveAccessToken(access_token: "")
            throw URLErrors.Unauthorized
        }
        
        if response.statusCode >= 400 {
            throw URLErrors.InvalidResponse
        }
        
        do {
            return try JSONDecoder().decode(PostResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func getAllPosts(getAllPostsRequest: GetAllPostsRequest) async throws -> [PostResponse] {
        guard let url = URL(string: Constants.getAllPostsEndpoint(getAllPostsRequest)) else {
            throw URLErrors.InvalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(tokenManager.getAccessToken())", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode < 402 else {
            throw URLErrors.InvalidResponse
        }
        
        if (response.statusCode == 401) {
            _ = tokenManager.saveAccessToken(access_token: "")
            throw URLErrors.Unauthorized
        }
        
        if (response.statusCode >= 400) {
            throw URLErrors.InvalidResponse
        }
        
        do {
            return try JSONDecoder().decode([PostResponse].self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
}
