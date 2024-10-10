//
//  PostResponse.swift
//  unitedsetups
//
//  Created by Paras KCD on 10/10/24.
//

import Foundation

struct PostResponse : Decodable {
    let id: String
    let text: String
    let createdDateTime: String
    let updatedDateTime: String
    let upvotes: Double
    let clicks: Double
    let deviceId: String?
    let postMediaUrls: [PostMediaUrlResponse]
    let postedById: String
    let postedBy: PostedByResponse
}

struct PostMediaUrlResponse : Decodable {
    let id: String
    let path: String
    let thumbnailPath: String
}

struct PostedByResponse : Decodable {
    let name: String
    let username: String
    let profileImageThumbnailUrl: String
}

enum PostMapper {
    static func mapPostedByResponseToDomain(input response: PostedByResponse, userId: String) -> PostedBy {
        return PostedBy(
            id: UUID.init(uuidString: userId)!,
            name: response.name,
            username: response.username,
            profileImageThumbnailUrl: response.profileImageThumbnailUrl
        )
    }
    
    static func mapPostMediaUrlResponsetoDomain(input response: PostMediaUrlResponse) -> PostMediaUrl {
        return PostMediaUrl(
            id: UUID.init(uuidString: response.id)!,
            path: response.path,
            thumbnailPath: response.thumbnailPath
        )
    }
    
    static func mapPostResponseToDomain(input response: PostResponse) -> Post {
        var dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        
        return Post(
            id: UUID.init(uuidString: response.id)!,
            text: response.text,
            createdDateTime: dateFormatter.date(from: response.createdDateTime) ?? Date(),
            updatedDateTime: dateFormatter.date(from: response.updatedDateTime) ?? Date(),
            upvotes: response.upvotes,
            clicks: response.clicks,
            deviceId: response.deviceId != nil ? UUID.init(uuidString: response.deviceId!) : nil,
            postMediaUrls: response.postMediaUrls.map({ PostMediaUrlResponse in
                return PostMapper.mapPostMediaUrlResponsetoDomain(input: PostMediaUrlResponse)
            }),
            postedBy: PostMapper.mapPostedByResponseToDomain(input: response.postedBy, userId: response.postedById)
        )
    }
}
