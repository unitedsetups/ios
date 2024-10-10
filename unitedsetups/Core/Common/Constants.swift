//
//  Constants.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct Constants {
    private static let apiUrl: String = "https://unitedsetups.paraskcd.com/api"
    static let loginEndpoint: () -> String = { "\(apiUrl)/auth/login" }
    static let registerEndpoint: () -> String = { "\(apiUrl)/auth/register" }
    static let getAllPostsEndpoint: (GetAllPostsRequest) -> String = {
        getAllPostsRequest in
        
        var urlParams: String = "page=\(getAllPostsRequest.page)&pageSize=\(getAllPostsRequest.pageSize)"
        
        if (getAllPostsRequest.filter != nil) {
            urlParams += "&filter=\(getAllPostsRequest.filter!)"
        }
        
        return "\(apiUrl)/auth/posts?\(urlParams)"
    }
}
