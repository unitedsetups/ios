//
//  GetAllPostsRequest.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

struct GetAllPostsRequest: Encodable {
    let filter: String?
    let page: Int
    let pageSize: Int
}
