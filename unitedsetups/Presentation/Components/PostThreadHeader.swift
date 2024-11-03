//
//  PostThreadHeader.swift
//  unitedsetups
//
//  Created by Paras KCD on 2/11/24.
//

import SwiftUI

struct PostThreadHeader: View {
    var postThread: PostThread
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    UserView(userId: postThread.postedBy.id.uuidString)
                } label: {
                    if (postThread.postedBy.profileImageThumbnailUrl == nil) {
                        ZStack {
                            Image("Person")
                                .frame(width: 32, height: 32)
                        }
                        .frame(width: 32, height: 32)
                        .background(Color("Background"))
                        .clipShape(Circle())
                        .shadow(radius: 16)
                    } else {
                        AsyncImage(url: URL(string: postThread.postedBy.profileImageThumbnailUrl!)) {
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
                    
                    Text(postThread.postedBy.name)
                        .font(.caption)
                    Text(" @\(postThread.postedBy.username)")
                        .font(.caption)
                        .foregroundStyle(.opacity(0.5))
                    
                    Spacer()
                }
            }
            HStack {
                Text(postThread.text)
                    .font(.body)
                Spacer()
            }
        }
    }
}
