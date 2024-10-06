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
    
    func provideLoginUseCase() -> LoginUseImpl {
        return LoginUseImpl(repo: AuthRepository.sharedInstance(AuthDataSource.shared))
    }
    
    func provideRegisterUseCase() -> RegisterUseImpl {
        return RegisterUseImpl(repo: AuthRepository.sharedInstance(AuthDataSource.shared))
    }
}
