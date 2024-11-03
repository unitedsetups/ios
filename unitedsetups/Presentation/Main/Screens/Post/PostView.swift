//
//  PostView.swift
//  unitedsetups
//
//  Created by Paras KCD on 2/11/24.
//

import SwiftUI

struct PostView: View {
    var postId: String
    @State var size: CGSize = .zero
    @Bindable var postViewModel: PostViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVStack {
                    if (postViewModel.isLoading) {
                        SkeletonLoadingPost()
                            .blinking(duration: 0.75)
                            .onAppear {
                                Task {
                                    do {
                                        try await postViewModel.fetchPostById(postId: postId)
                                    }
                                }
                            }
                    }
                    if (postViewModel.post != nil) {
                        Group {
                            ForEach(Array([postViewModel.post!]), id: \.self) {
                                post in
                                PostItem(post: post, isLoggedInUser: UUID(uuidString: postViewModel.loggedInUserId!) == post.postedBy.id, postIdLoading: nil) { _, liked in
                                    do {
                                        try await postViewModel.likePost(liked: liked)
                                    }
                                }
                                .foregroundStyle(Color.white)
                                LazyVStack {
                                    ForEach(Array(post.postThreads.enumerated()), id: \.element) {
                                        index, postThread in
                                        PostThreadItem(postThread: postThread, isChild: false, likePostThread: {id, liked in
                                            try await postViewModel.likePostThread(postThreadId: id, liked: liked)
                                        }, selectPostThread: {selected in postViewModel.selectPostThreadParent(selected: selected)
                                        })
                                        if index != (post.postThreads.count - 1) {
                                            Divider()
                                                .background(Color.gray)
                                        }
                                    }
                                }
                                .foregroundStyle(Color.white)
                                .padding()
                                .background(Color("Surface"))
                                .cornerRadius(16)
                                .shadow(radius: 16)
                                .padding(.bottom, size.height)
                            }
                        }
                        .padding(8)
                    }
                }
            }
            
            VStack {
                if (postViewModel.parentPostThread != nil) {
                    HStack(alignment: .center) {
                        HStack {
                            Image("Comment")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            VStack(alignment: .leading) {
                                Text("Reply to:")
                                Text("\(postViewModel.parentPostThread!.postedBy.username): \(postViewModel.parentPostThread!.text)")
                            }
                        }
                        Spacer()
                        Button {
                            postViewModel.parentPostThread = nil
                        } label: {
                            Image("Close")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                        }
                        .contentShape(Rectangle())
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color("Background"))
                    .cornerRadius(16)
                    .padding(8)
                }
                
                if (!postViewModel.postThreadText.isEmpty) {
                    Text("What's on your mind?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .font(.footnote)
                        .foregroundStyle(.accent)
                }
                
                TextField(
                    "",
                    text: $postViewModel.postThreadText,
                    prompt: Text("What's on your mind?")
                        .foregroundStyle(.white.opacity(0.5)),
                    axis: .vertical
                )
                .lineLimit(1...30)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            }
            .padding()
            .background(Color("Surface"))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(radius: 16)
            .saveSize(in: $size)
        }
        .CommentsStyle(viewModel: postViewModel)
    }
}
