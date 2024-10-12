//
//  CreatePostRequest.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

struct CreatePostRequest: Encodable {
    let text: String
    let postMediaUrls: [PostMediaUrlRequest]
}

struct PostMediaUrlRequest: Encodable {
    let path: String
    let thumbnailPath: String
}
