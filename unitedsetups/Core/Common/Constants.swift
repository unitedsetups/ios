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
    public static let postsEndpoint: String = "\(apiUrl)/posts"
    public static let usersEndpoint: String = "\(apiUrl)/users"
    public static let postThreadsEndpoint: String = "\(apiUrl)/postthreads"
    public static let loginEndpoint: () -> String = { "\(apiUrl)/auth/login" }
    public static let registerEndpoint: () -> String = { "\(apiUrl)/auth/register" }
    public static let uploadFilesEndpoint: (UploadRequest) -> String = { uploadRequest in "\(apiUrl)/upload/\(uploadRequest.apiPath)"
    }
    public static let getAllPostsEndpoint: (GetAllPostsRequest) -> String = { getAllPostsRequest in
        var urlParams: String = "page=\(getAllPostsRequest.page)&pageSize=\(getAllPostsRequest.pageSize)"
        if (getAllPostsRequest.filter != nil) {
            urlParams += "&filter=\(getAllPostsRequest.filter!)"
        }
        if (getAllPostsRequest.userId != nil) {
            urlParams += "&postedById=\(getAllPostsRequest.userId!)"
        }
        return "\(postsEndpoint)?\(urlParams)"
    }
    public static let getPostByIdEndpoint: (String) -> String = { id in "\(postsEndpoint)/\(id)" }
    public static let getUserByIdEndpoint: (String) -> String = { id in "\(usersEndpoint)/\(id)"}
    public static let getMyProfileEndpoint: String = "\(usersEndpoint)/me"
    public static let likePost: (String) -> String = { id in "\(postsEndpoint)/\(id)/like" }
    public static let dislikePost: (String) -> String = { id in "\(postsEndpoint)/\(id)/dislike"}
    public static let likePostThread: (String) -> String = { id in "\(postThreadsEndpoint)/\(id)/like" }
    public static let dislikePostThread: (String) -> String = { id in "\(postThreadsEndpoint)/\(id)/dislike" }
}
