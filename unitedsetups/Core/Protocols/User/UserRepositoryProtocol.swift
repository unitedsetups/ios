//
//  UserRepositoryProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

protocol UserRepositoryProtocol {
    func getUserById(id: String) async throws -> User
    func getMyProfile() async throws -> User
}
