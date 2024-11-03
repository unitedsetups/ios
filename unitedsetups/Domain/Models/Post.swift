//
//  Post.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct Post : Equatable, Identifiable, Hashable {
    let id: UUID
    let text: String
    let createdDateTime: Date
    let updatedDateTime: Date
    var upvotes: Int32
    var clicks: Int32
    let deviceId: UUID?
    let postMediaUrls: [PostMediaUrl]
    var postThreads: [PostThread]
    let postedBy: PostedBy
    var liked: Bool
    var disliked: Bool
}

struct PostMediaUrl : Equatable, Hashable, Identifiable {
    let id: UUID
    let path: String
    let thumbnailPath: String
}

struct PostedBy : Equatable, Identifiable, Hashable {
    let id: UUID
    let name: String
    let username: String
    let profileImageThumbnailUrl: String?
}
