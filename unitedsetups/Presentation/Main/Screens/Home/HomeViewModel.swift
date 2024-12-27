//
//  HomeViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import Foundation
import SwiftUICore

@MainActor class HomeViewModel: Observable, ObservableObject {
    let getAllPostsUseCase: GetAllPostsUseCase
    let likePostUseCase: LikePostUseCase
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    
    private var page = 0
    
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var loggedInUserId: String? = nil
    @Published var postIdLoading: String? = nil
    
    init(getAllPostsUseCase: GetAllPostsUseCase, likePostUseCase: LikePostUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
        self.likePostUseCase = likePostUseCase
        self.loggedInUserId = tokenManager.getUserId()
    }
    
    func fetchPosts() async throws {
        self.isLoading = true
        self.posts = []
        let result = try await getAllPostsUseCase.execute(request: GetAllPostsRequest(filter: nil, page: page, pageSize: Constants.pageSize, userId: nil))
        switch result {
        case .success(let posts):
            self.posts = posts
            self.isLoading = false
        case .failure(let failure):
            self.isLoading = false
            self.errorMessage = failure.localizedDescription
        }
    }
    
    func likePost(id: String, liked: Bool) async throws {
        self.postIdLoading = id
        let result = try await likePostUseCase.execute(id: id, liked: liked)
        switch result {
        case .success(let post):
            self.postIdLoading = nil
            guard let index = self.posts.firstIndex(where: { pt in pt.id == post.id }) else {
                self.postIdLoading = nil
                return
            }
            self.posts.remove(at: index)
            self.posts.insert(post, at: index)
        case .failure(let failure):
            self.postIdLoading = nil
            self.errorMessage = failure.localizedDescription
        }
    }
}
