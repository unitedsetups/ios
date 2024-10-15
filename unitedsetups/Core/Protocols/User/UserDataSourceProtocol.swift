//
//  UserDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

protocol UserDataSourceProtocol {
    func getUserById(id: String) async throws -> UserResponse
    func getMyProfile() async throws -> UserResponse
}
