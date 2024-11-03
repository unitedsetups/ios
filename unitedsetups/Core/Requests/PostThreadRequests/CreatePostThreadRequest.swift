//
//  CreatePostThreadRequest.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

struct CreatePostThreadRequest: Encodable {
    let postId: String
    let parentPostThreadId: String?
    let text: String
    let postMediaUrls: [PostMediaUrlRequest]
}
