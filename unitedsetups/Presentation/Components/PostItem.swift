//
//  PostItem.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostItem: View {
    @State var post: Post
    @State var isLoggedInUser: Bool
    var body: some View {
        VStack {
            PostHeader(postedByName: post.postedBy.name, postedByUsername: post.postedBy.username, asyncProfilePictureUrl: post.postedBy.profileImageThumbnailUrl == nil ? nil : URL(string: "\(Constants.baseUrl)/\(post.postedBy.profileImageThumbnailUrl!)"), isLoggedInUser: isLoggedInUser, text: post.text, userId: post.postedBy.id.uuidString)
            PostMedia(postMediaUrls: post.postMediaUrls)
            PostFooter(upvotes: post.upvotes, firstPostMediaUrl: URL(string: "\(Constants.baseUrl)/\(post.postMediaUrls[0].path)")!, createdDateTime: post.createdDateTime, shareText: "User @\(post.postedBy.username) posted this Amazing Setup in United Setups, check it out.")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("Surface"))
        .cornerRadius(16)
        .padding(8)
        .shadow(radius: 16)
    }
}
