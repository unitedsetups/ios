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
    @State var postIdLoading: String?
    var likePost: (String, Bool) async throws -> Void
    var deletePost: (String) async throws -> Void
    
    var body: some View {
        VStack {
            PostHeader(post: post, isLoggedInUser: isLoggedInUser, deletePost: deletePost)
            PostMedia(postMediaUrls: post.postMediaUrls)
            PostFooter(post: post, shareText: "User @\(post.postedBy.username) posted this Amazing Setup in United Setups, check it out.", postIdLoading: postIdLoading, likePost: likePost)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("Surface"))
        .cornerRadius(16)
        .shadow(radius: 16)
    }
}
