//
//  UserPostViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

import SwiftUI

@MainActor class UserViewModel : ObservableObject {
    let getUserByIdUseCase: GetUserByIdUseCase
    let getMyProfileUseCase: GetMyProfileUseCase
    let getAllPostsUseCase: GetAllPostsUseCase
    let likePostUseCase: LikePostUseCase
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    
    @State private var page: Int = 0
    @Published var isLoading: Bool = true
    @Published var user: User? = nil
    @Published var posts: [Post] = []
    @Published var errorMessage: String? = nil
    @Published var loggedInUserId: String? = nil
    @Published var postIdLoading: String? = nil
    
    init(
        getUserByIdUseCase: GetUserByIdUseCase,
        getMyProfileUseCase: GetMyProfileUseCase,
        getAllPostsUseCase: GetAllPostsUseCase,
        likePostUseCase: LikePostUseCase
    ) {
        self.getAllPostsUseCase = getAllPostsUseCase
        self.getMyProfileUseCase = getMyProfileUseCase
        self.getUserByIdUseCase = getUserByIdUseCase
        self.likePostUseCase = likePostUseCase
        self.loggedInUserId = tokenManager.getUserId()
    }
    
    func getUserById(userId: String) async throws -> User {
        let result = try await getUserByIdUseCase.execute(id: userId)
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
    
    func getMyProfile() async throws -> User {
        let result = try await getMyProfileUseCase.execute()
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
    
    func fetchPostsByUserId(userId: String?) async throws {
        self.isLoading = true
        do {
            var id: UUID? = nil
            if (userId != nil) {
                self.user = try await getUserById(userId: userId!)
            } else {
                self.user = try await getMyProfile()
            }
            id = self.user?.id
            let result = try await getAllPostsUseCase.execute(request: GetAllPostsRequest(filter: nil, page: page, pageSize: Constants.pageSize, userId: id?.uuidString))
            switch result {
            case .success(let posts):
                self.posts = posts
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
    }
    
    func likePost(id: String, liked: Bool) async throws {
        self.postIdLoading = id
        let result = try await likePostUseCase.execute(id: id, liked: liked)
        switch result {
        case .success(let post):
            guard let index = self.posts.firstIndex(where: { pt in pt.id == post.id }) else {
                self.postIdLoading = nil
                return
            }
            self.posts[index] = post
            self.postIdLoading = nil
        case .failure(let failure):
            self.postIdLoading = nil
            self.errorMessage = failure.localizedDescription
        }
    }
}
