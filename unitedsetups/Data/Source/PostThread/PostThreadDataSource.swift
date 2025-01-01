//
//  PostThreadDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

import Foundation

struct PostThreadDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let httpManager: HttpManager = Injection.shared.provideHttpManager()
    
    private init() {}
    
    static let shared: PostThreadDataSource = PostThreadDataSource()
}

extension PostThreadDataSource: PostThreadDataSourceProtocol {
    func createNewPostThread(request: CreatePostThreadRequest) async throws -> PostThreadResponse {
        guard let jsonData = try? JSONEncoder().encode(request) else {
            throw URLErrors.FailedToEncodeRequest
        }
        
        let (data, _) = try await httpManager.POST(url: URL(string: Constants.postThreadsEndpoint), accessToken: getAccessToken(), revokeAccessToken: { revokeAccessToken() }, body: jsonData)
        
        do {
            return try JSONDecoder().decode(PostThreadResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func likePostThread(id: String) async throws -> PostThreadResponse {
        let (data, _) = try await httpManager.PUT(
            url: URL(string: Constants.likePostThread(id)),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() },
            body: nil
        )
        
        do {
            return try JSONDecoder().decode(PostThreadResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    func dislikePostThread(id: String) async throws -> PostThreadResponse {
        let (data, _) = try await httpManager.PUT(
            url: URL(string: Constants.dislikePostThread(id)),
            accessToken: getAccessToken(),
            revokeAccessToken: { revokeAccessToken() },
            body: nil
        )
        
        do {
            return try JSONDecoder().decode(PostThreadResponse.self, from: data)
        } catch {
            throw URLErrors.ParsingError
        }
    }
    
    private func revokeAccessToken() {
        tokenManager.revokeAccessToken()
    }
    
    private func getAccessToken() -> String {
        return tokenManager.getAccessToken()
    }
}
