//
//  PostPostedByDetails.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostHeader: View {
    var post: Post
    var isLoggedInUser: Bool
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    UserView(userId: post.postedBy.id.uuidString)
                } label: {
                    if (post.postedBy.profileImageThumbnailUrl == nil) {
                        ZStack {
                            Image("Person")
                                .frame(width: 32, height: 32)
                        }
                        .frame(width: 32, height: 32)
                        .background(Color("Background"))
                        .clipShape(Circle())
                        .shadow(radius: 16)
                    } else {
                        AsyncImage(url: URL(string: post.postedBy.profileImageThumbnailUrl!)) {
                            result in
                            if result.image == nil {
                                Color("Background")
                                    .frame(width: 32, height: 32)
                                    .blinking(duration: 0.75)
                            }
                            result.image?
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .shadow(radius: 16)
                    }
                    
                    Text(post.postedBy.name)
                        .font(.caption)
                    Text(" @\(post.postedBy.username)")
                        .font(.caption)
                        .foregroundStyle(.opacity(0.5))
                }
                
                Spacer()
                if (isLoggedInUser) {
                    Menu {
                        Button("Add Device") {
                            
                        }
                        Button("Add Setup Items") {
                            
                        }
                        Button("Edit Post") {
                            
                        }
                        Divider()
                        Button("Delete", role: .destructive) {
                            
                        }
                    } label: {
                        Image("MoreMenu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .contentShape(Circle())
                }
            }
            HStack {
                Text(post.text)
                    .font(.body)
                Spacer()
            }
        }
    }
}
