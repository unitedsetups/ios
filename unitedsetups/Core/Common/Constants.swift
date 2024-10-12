//
//  Constants.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

struct Constants {
    public static let pageSize: Int = 25
    public static let baseUrl: String = "https://unitedsetups.paraskcd.com"
    public static let apiUrl: String = "\(baseUrl)/api"
    public static let loginEndpoint: () -> String = { "\(apiUrl)/auth/login" }
    public static let registerEndpoint: () -> String = { "\(apiUrl)/auth/register" }
    public static let uploadFilesEndpoint: (UploadRequest) -> String = { uploadRequest in "\(apiUrl)/upload/\(uploadRequest.apiPath)" }
    public static let postsEndpoint: () -> String = { "\(apiUrl)/posts" }
    public static let getAllPostsEndpoint: (GetAllPostsRequest) -> String = {
        getAllPostsRequest in
        
        var urlParams: String = "page=\(getAllPostsRequest.page)&pageSize=\(getAllPostsRequest.pageSize)"
        
        if (getAllPostsRequest.filter != nil) {
            urlParams += "&filter=\(getAllPostsRequest.filter!)"
        }
        
        return "\(postsEndpoint())?\(urlParams)"
    }
}
