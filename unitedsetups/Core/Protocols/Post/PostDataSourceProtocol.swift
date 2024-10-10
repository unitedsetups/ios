//
//  PostDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

protocol PostDataSourceProtocol {
    func getAllPosts(getAllPostsRequest: GetAllPostsRequest) async throws -> [PostResponse]
}
