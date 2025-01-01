//
//  HomeView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = .init(
        getAllPostsUseCase: Injection.shared.provideGetAllPostsUseCase(),
        likePostUseCase: Injection.shared.provideLikePostUseCase(),
        deletePostUseCase: Injection.shared.provideDeletePostUseCase()
    )
    @StateObject var newPostViewModel: NewPostViewModel = NewPostViewModel()
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    if (homeViewModel.isLoading) {
                        VStack {
                            SkeletonLoadingPost()
                            SkeletonLoadingPost()
                            SkeletonLoadingPost()
                        }
                        .blinking(duration: 0.75)
                        .onAppear {
                            Task {
                                do {
                                    try await homeViewModel.fetchPosts()
                                } catch {
                                    print(homeViewModel.errorMessage ?? "Couldn't fetch posts")
                                }
                            }
                        }
                    }
                    if (homeViewModel.posts.count > 0) {
                        ForEach(homeViewModel.posts, id: \.self) {
                            post in
                            Group {
                                PostItem(
                                    post: post,
                                    isLoggedInUser: UUID(uuidString: homeViewModel.loggedInUserId!) == post.postedBy.id,
                                    postIdLoading: homeViewModel.postIdLoading,
                                    likePost: { id, liked in
                                        do {
                                            try await homeViewModel.likePost(id: id, liked: liked)
                                        } catch {
                                            print(error)
                                        }
                                    },
                                    deletePost: {id in
                                        do {
                                            try await homeViewModel.deletePost(id: id)
                                        } catch {
                                            print(error)
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity)
            .refreshable {
                do {
                    try await homeViewModel.fetchPosts()
                } catch {
                    print(error)
                }
            }
            .onChange(of: newPostViewModel.newPost) { _ in
                Task {
                    try await homeViewModel.fetchPosts()
                }
            }
            .onChange(of: postViewModel.post) { _ in
                Task {
                    try await homeViewModel.fetchPosts()
                }
            }
            
            NavigationLink(
                destination:
                    NewPostView()
                    .environmentObject(newPostViewModel)
            ) {
                Image("EditNote")
                    .renderingMode(.template)
                    .padding()
                    .background(.accent)
                    .foregroundStyle(Color("Background"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 16)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
