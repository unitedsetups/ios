//
//  PostThreadFooter.swift
//  unitedsetups
//
//  Created by Paras KCD on 2/11/24.
//

import SwiftUI

struct PostThreadFooter: View {
    var postThread: PostThread
    var likePostThread: (String, Bool) async throws -> Void
    var selectPostThread: (PostThread) -> Void
    
    var body: some View {
        HStack {
            Button {
                Task {
                    try? await likePostThread(postThread.id.uuidString, true)
                }
            } label: {
                HStack {
                    if postThread.liked {
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
                    
                    Text(postThread.upvotes.description)
                }
            }
            .contentShape(Rectangle())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            
            Button {
                Task {
                    try? await likePostThread(postThread.id.uuidString, false)
                }
            } label: {
                if postThread.disliked {
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
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            
            Button {
                selectPostThread(postThread)
            } label: {
                Image("Comment")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            
            Spacer()
        }
    }
}
