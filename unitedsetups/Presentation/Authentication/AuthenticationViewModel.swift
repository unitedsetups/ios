//
//  AuthenticationViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

@MainActor class AuthenticationViewModel: Observable, ObservableObject {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    let loginUseCase: LoginUseCase
    let registerUseCase: RegisterUseCase
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var auth: Auth? = nil
    @Published var errorMessage: String? = nil
    
    init(loginUseCase: LoginUseCase, registerUseCase: RegisterUseCase) {
        self.loginUseCase = loginUseCase
        self.registerUseCase = registerUseCase
        self.isLoggedIn = !tokenManager.getAccessToken().isEmpty
    }
    
    func login() async throws {
        isLoading = true
        let result = try await loginUseCase.execute(request: LoginRequest(email: email, password: password))
        switch result {
            case .success(let auth):
                self.auth = auth
                self.isLoggedIn = tokenManager.saveAccessToken(access_token: auth.token)
                self.isLoading = false
            case .failure(let failure):
                self.isLoading = false
                self.errorMessage = failure.localizedDescription
        }
    }
    
    func register() async throws {
        isLoading = true
        let result = try await registerUseCase.execute(request: RegisterRequest(username: username, email: email, name: name, password: password))
        switch result {
            case .success(let auth):
                self.auth = auth
                self.isLoading = false
            case .failure(let failure):
                self.isLoading = false
                self.errorMessage = failure.localizedDescription
        }
    }
}
