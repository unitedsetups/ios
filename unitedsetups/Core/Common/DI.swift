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
}
