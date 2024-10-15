//
//  UserRepository.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct UserRepository {
    typealias UserInstance = (UserDataSource) -> UserRepository
    
    fileprivate let dataSource: UserDataSource
    
    private init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }
    
    static let sharedInstance: UserInstance = { dataSource in
        return UserRepository(dataSource: dataSource)
    }
}

extension UserRepository: UserRepositoryProtocol {
    func getUserById(id: String) async throws -> User {
        do {
            let data = try await dataSource.getUserById(id: id)
            return UserMapper.mapUserResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
    
    func getMyProfile() async throws -> User {
        do {
            let data = try await dataSource.getMyProfile()
            return UserMapper.mapUserResponseToDomain(input: data)
        } catch {
            throw error
        }
    }
}
