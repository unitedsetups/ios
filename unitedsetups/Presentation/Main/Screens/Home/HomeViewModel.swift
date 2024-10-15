//
//  HomeViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import Foundation
import SwiftUICore

@MainActor class HomeViewModel: ObservableObject {
    let getAllPostsUseCase: GetAllPostsUseCase
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    
    @State private var page = 0
    
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var loggedInUserId: String? = nil
    
    init(getAllPostsUseCase: GetAllPostsUseCase) {
        self.getAllPostsUseCase = getAllPostsUseCase
        self.loggedInUserId = tokenManager.getUserId()
    }
    
    func fetchPosts() async throws {
        isLoading = true
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
}
