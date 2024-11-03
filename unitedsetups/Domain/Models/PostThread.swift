//
//  PostThread.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

import Foundation

struct PostThread : Equatable, Hashable, Identifiable {
    let id: UUID
    let text: String
    let createdDateTime: Date
    let updatedDateTime: Date
    let upvotes: Int32
    let clicks: Int32
    let postMediaUrls: [PostMediaUrl]
    let postedBy: PostedBy
    let liked: Bool
    let disliked: Bool
    let postId: String
    let parentPostThreadId: String?
    let childrenPostThreads: [PostThread]
}
