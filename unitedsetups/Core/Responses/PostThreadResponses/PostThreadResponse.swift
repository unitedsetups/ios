//
//  PostThreadResponse.swift
//  unitedsetups
//
//  Created by Paras KCD on 27/10/24.
//

import Foundation

struct PostThreadResponse : Decodable {
    let id: String
    let text: String
    let createdDateTime: String?
    let updatedDateTime: String?
    let upvotes: Int32
    let clicks: Int32
    let postMediaUrls: [PostMediaUrlResponse]
    let postId: String
    let parentPostThreadId: String?
    let childrenPostThreads: [PostThreadResponse]
    let postedById: String
    let postedBy: PostedByResponse
    let liked: Bool
    let disliked: Bool
}

enum PostThreadMapper {
    static func mapPostThreadResponseToDomain(input response: PostThreadResponse) -> PostThread {
        return PostThread(
            id: UUID.init(uuidString: response.id)!,
            text: response.text,
            createdDateTime: response.createdDateTime != nil && !response.createdDateTime!.isEmpty ? Formatters.getDateFromString(response.createdDateTime!) : Date(),
            updatedDateTime: response.createdDateTime != nil && !response.createdDateTime!.isEmpty ? Formatters.getDateFromString(response.updatedDateTime!) : Date(),
            upvotes: response.upvotes,
            clicks: response.clicks,
            postMediaUrls: response.postMediaUrls.map({ PostMediaUrlResponse in
                return PostMapper.mapPostMediaUrlResponsetoDomain(input: PostMediaUrlResponse)
            }),
            postedBy: PostMapper.mapPostedByResponseToDomain(input: response.postedBy, userId: response.postedById),
            liked: response.liked,
            disliked: response.disliked,
            postId: response.postId,
            parentPostThreadId: response.parentPostThreadId,
            childrenPostThreads: response.childrenPostThreads.map({
                ChildrenPostThread in
                return PostThreadMapper.mapPostThreadResponseToDomain(input: ChildrenPostThread)
            })
        )
    }
}
