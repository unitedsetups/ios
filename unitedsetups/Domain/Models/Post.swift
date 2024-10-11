//
//  Post.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct Post {
    let id: UUID
    let text: String
    let createdDateTime: Date
    let updatedDateTime: Date
    let upvotes: Int32
    let clicks: Int32
    let deviceId: UUID?
    let postMediaUrls: [PostMediaUrl]
    let postedBy: PostedBy
}

struct PostMediaUrl {
    let id: UUID
    let path: String
    let thumbnailPath: String
}

struct PostedBy {
    let id: UUID
    let name: String
    let username: String
    let profileImageThumbnailUrl: String
}
