//
//  DI.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct Injection {
    static let shared = Injection()
    
    func provideTokenManager() -> TokenManager {
        return TokenManager.shared
    }
    
    func provideHttpManager() -> HttpManager {
        return HttpManager.shared
    }
    
    func provideUploadDataSource() -> UploadDataSource {
        return UploadDataSource.shared
    }
    
    func provideLoginUseCase() -> LoginUseCase {
        return LoginUseImpl(repo: AuthRepository.sharedInstance(AuthDataSource.shared))
    }
    
    func provideRegisterUseCase() -> RegisterUseCase {
        return RegisterUseImpl(repo: AuthRepository.sharedInstance(AuthDataSource.shared))
    }
    
    func provideGetAllPostsUseCase() -> GetAllPostsUseCase {
        return GetAllPostsImpl(repo: PostRepository.sharedInstance(PostDataSource.shared))
    }
    
    func provideCreateNewPostUseCase() -> CreateNewPostUseCase {
        return CreateNewPostImpl(repo: PostRepository.sharedInstance(PostDataSource.shared))
    }
    
    func provideGetPostByIdUseCase() -> GetPostByIdUseCase {
        return GetPostByIdImpl(repo: PostRepository.sharedInstance(PostDataSource.shared))
    }
    
    func provideGetUserByIdUseCase() -> GetUserByIdUseCase {
        return GetUserByIdImpl(repo: UserRepository.sharedInstance(UserDataSource.shared))
    }
    
    func provideGetMyProfileUseCase() -> GetMyProfileUseCase {
        return GetMyProfileImpl(repo: UserRepository.sharedInstance(UserDataSource.shared))
    }
    
    func provideLikePostUseCase() -> LikePostUseCase {
        return LikePostImpl(repo: PostRepository.sharedInstance(PostDataSource.shared))
    }
    
    func provideCreatePostThreadUseCase() -> CreatePostThreadUseCase {
        return CreatePostThreadImpl(repo: PostThreadRepository.sharedInstance(PostThreadDataSource.shared))
    }
    
    func provideLikePostThreadUseCase() -> LikePostThreadUseCase {
        return LikePostThreadImpl(repo: PostThreadRepository.sharedInstance(PostThreadDataSource.shared))
    }
    
    func provideDeletePostUseCase() -> DeletePostUseCase {
        return DeletePostImpl(repo: PostRepository.sharedInstance(PostDataSource.shared))
    }
}
