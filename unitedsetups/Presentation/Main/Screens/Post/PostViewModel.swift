//
//  PostViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 2/11/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor class PostViewModel: ObservableObject, Observable {
    let getPostByIdUseCase: GetPostByIdUseCase = Injection.shared.provideGetPostByIdUseCase()
    let likePostUseCase: LikePostUseCase = Injection.shared.provideLikePostUseCase()
    let deletePostUseCase: DeletePostUseCase = Injection.shared.provideDeletePostUseCase()
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let uploadDataSource: UploadDataSource = Injection.shared.provideUploadDataSource()
    let createPostThreadUseCase: CreatePostThreadUseCase = Injection.shared.provideCreatePostThreadUseCase()
    let likePostThreadUseCase: LikePostThreadUseCase = Injection.shared.provideLikePostThreadUseCase()
    
    @Published var post: Post? = nil
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    @Published var loggedInUserId: String? = nil
    @Published var postThreadIdLoading: String? = nil
    @Published var images: [UIImage] = []
    @Published var selectedPhotos: [PhotosPickerItem] = []
    @Published var postThreadText: String = ""
    @Published var parentPostThread: PostThread? = nil
    
    init() {
        self.loggedInUserId = tokenManager.getUserId()
    }
    
    func fetchPostById(postId: String) async throws {
        self.isLoading = true
        self.post = nil
        let result = try await getPostByIdUseCase.execute(id: postId)
        switch result {
        case .success(let post):
            self.post = post
            self.isLoading = false
        case .failure(let failure):
            self.isLoading = false
            self.errorMessage = failure.localizedDescription
        }
    }
    
    func selectPostThreadParent(selected: PostThread) {
        self.parentPostThread = selected
    }
    
    func uploadImages()  async throws -> Result<UploadResponse, Error> {
        do {
            let result = try await uploadDataSource.uploadFiles(uploadRequest: UploadRequest(apiPath: "post-media", images: images))
            if (result != nil) {
                return .success(result!)
            } else {
                return .failure(ViewModelErrors.NullException)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func likePost(liked: Bool) async throws {
        guard let post = self.post else {
            return
        }
        let result = try await likePostUseCase.execute(id: post.id.uuidString, liked: liked)
        switch result {
        case .success(let postResult):
            self.post!.liked = postResult.liked
            self.post!.disliked = postResult.disliked
            self.post!.upvotes = postResult.upvotes
            self.isLoading = false
        case .failure(let failure):
            self.isLoading = false
            self.errorMessage = failure.localizedDescription
        }
    }
    
    func deletePost() async throws {
        guard let post = self.post else {
            return
        }
        let result = try await deletePostUseCase.execute(id: post.id.uuidString)
        switch result {
        case .success(let deleted):
            if (deleted) {
                
            }
        case .failure(let failure):
            self.errorMessage = failure.localizedDescription
        }
    }
    
    func likePostThread(postThreadId: String, liked: Bool) async throws {
        guard let post = self.post else {
            return
        }
        let result = try await likePostThreadUseCase.execute(id: postThreadId, liked: liked)
        switch result {
        case .success(let postThreadResult):
            if (postThreadResult.parentPostThreadId != nil) {
                try await fetchPostById(postId: postThreadResult.postId)
            } else {
                guard let index = post.postThreads.firstIndex(where: { postThreads in
                    postThreads.id == postThreadResult.id
                }) else {
                    return
                }
                self.post!.postThreads.remove(at: index)
                self.post!.postThreads.insert(postThreadResult, at: index)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func createNewPostThread() async throws {
        do {
            guard let post = self.post else {
                return
            }
            if images.count > 0 {
                let uploadImagesResult = try await uploadImages()
                switch uploadImagesResult {
                case .failure(let error):
                    throw error
                case .success(let result):
                    var postMediaUrls: [PostMediaUrlRequest] = []
                    for (index, _) in result.paths.enumerated() {
                        postMediaUrls.append(PostMediaUrlRequest(path: result.paths[index], thumbnailPath: result.thumbnails[index]))
                    }
                    let postThreadResponse = try await createPostThreadUseCase.execute(request: CreatePostThreadRequest(postId: post.id.uuidString, parentPostThreadId: self.parentPostThread?.id.uuidString, text: postThreadText, postMediaUrls: postMediaUrls))
                    self.isLoading = false
                    switch postThreadResponse {
                    case .success(let postThreadResult):
                        if parentPostThread != nil {
                            try await fetchPostById(postId: post.id.uuidString)
                        } else {
                            self.post!.postThreads.insert(postThreadResult, at: 0)
                        }
                        self.images = []
                        self.postThreadText = ""
                        self.parentPostThread = nil
                    case .failure(let error):
                        throw error
                    }
                }
            } else {
                let postThreadResponse = try await createPostThreadUseCase.execute(request: CreatePostThreadRequest(postId: post.id.uuidString, parentPostThreadId: self.parentPostThread?.id.uuidString, text: postThreadText, postMediaUrls: []))
                self.isLoading = false
                switch postThreadResponse {
                case .success(let postThreadResult):
                    if parentPostThread != nil {
                        try await fetchPostById(postId: post.id.uuidString)
                    } else {
                        self.post!.postThreads.insert(postThreadResult, at: 0)
                    }
                    self.postThreadText = ""
                    self.parentPostThread = nil
                case .failure(let error):
                    throw error
                }
            }
        } catch {
            self.images = []
            self.postThreadText = ""
            self.parentPostThread = nil
            self.isLoading = false
            print(error)
        }
    }
}
