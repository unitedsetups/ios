//
//  AuthDataRepository.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct AuthRepository {
    typealias AuthInstance = (AuthDataSource) -> AuthRepository
    
    fileprivate let dataSource: AuthDataSource
    
    private init(dataSource: AuthDataSource)
    {
        self.dataSource = dataSource
    }
    
    static let sharedInstance: AuthInstance = { dataSource in
        return AuthRepository(dataSource: dataSource)
    }
}

extension AuthRepository : AuthRepositoryProtocol {
    func login(request: LoginRequest) async throws -> Auth {
        do {
            let data = try await dataSource.login(loginRequest: request)
            return AuthMapper.mapAuthResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func register(request: RegisterRequest) async throws -> Auth {
        do {
            let data = try await dataSource.register(registerRequest: request)
            return AuthMapper.mapAuthResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
}
