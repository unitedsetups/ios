//
//  PostFooter.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostFooter: View {
    @State var post: Post
    @State var shareText: String
    @State var postIdLoading: String?
    var likePost: (String, Bool) async throws -> Void
    
    var body: some View {
        HStack {
            HStack {
                if postIdLoading == post.id.uuidString {
                    ProgressView()
                        .foregroundStyle(.accent)
                }
                else {
                    Button {
                        Task {
                            try? await likePost(post.id.uuidString, true)
                        }
                    } label: {
                        HStack {
                            if post.liked {
                                Image("FilledThumbsUp")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.accent)
                            }
                            else {
                                Image("ThumbsUp")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Text(post.upvotes.description)
                        }
                    }
                    .contentShape(Rectangle())
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)

                    Divider()
                    
                    Button {
                        Task {
                            try? await likePost(post.id.uuidString, false)
                        }
                    } label: {
                        if post.disliked {
                            Image("FilledThumbsDown")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.accent)
                        } else {
                            Image("ThumbsDown")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .contentShape(Rectangle())
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
            }
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
            
            NavigationLink {
                PostView(postId: post.id.uuidString)
            } label: {
                Image("Comment")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
            .contentShape(Rectangle())
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
            
            Spacer()
            
            ShareLink(item: post.postMediaUrls[0].path, preview: SharePreview(shareText)) {
                Image("Share")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
            .contentShape(Rectangle())
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
        }
        
        HStack {
            Text(post.createdDateTime, format: .relative(presentation: .numeric))
                .font(.caption2)
                .foregroundStyle(.opacity(0.5))
            Spacer()
        }
    }
}
