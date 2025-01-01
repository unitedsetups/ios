//
//  UserView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    @StateObject var userViewModel: UserViewModel = UserViewModel(
        getUserByIdUseCase: Injection.shared.provideGetUserByIdUseCase(),
        getMyProfileUseCase: Injection.shared.provideGetMyProfileUseCase(),
        getAllPostsUseCase: Injection.shared.provideGetAllPostsUseCase(),
        likePostUseCase: Injection.shared.provideLikePostUseCase(),
        deletePostUseCase: Injection.shared.provideDeletePostUseCase()
    )
    
    @State var userId: String?
    
    @EnvironmentObject var postViewModel: PostViewModel
    @StateObject var newPostViewModel: NewPostViewModel = NewPostViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    UserProfileHeader(loggedInUserId: userViewModel.loggedInUserId, userData: userViewModel.user, signOutAction: {authViewModel.signOut()})
                    
                    LazyVStack {
                        if (userViewModel.isLoading) {
                            VStack {
                                SkeletonLoadingPost()
                                SkeletonLoadingPost()
                                SkeletonLoadingPost()
                            }
                            .blinking(duration: 0.75)
                            .onAppear {
                                Task {
                                    do {
                                        try await userViewModel.fetchPostsByUserId(userId: userId)
                                    } catch {
                                        print(userViewModel.errorMessage ?? "Couldn't fetch posts by user id")
                                    }
                                }
                            }
                        }
                        ForEach(userViewModel.posts, id: \.self) {
                            post in
                            PostItem(
                                post: post,
                                isLoggedInUser: UUID(uuidString: userViewModel.loggedInUserId!) == post.postedBy.id,
                                postIdLoading: userViewModel.postIdLoading,
                                likePost: { id, index in
                                    do {
                                        try await userViewModel.likePost(id: id, liked: index)
                                    } catch {
                                        print(error)
                                    }
                                },
                                deletePost: {id in
                                    do {
                                        try await userViewModel.deletePost(id: id)
                                    }
                                }
                            )
                        }
                    }
                    .padding(8)
                    
                }
            }
            .refreshable {
                do {
                    try await userViewModel.fetchPostsByUserId(userId: userId)
                } catch {
                    print(userViewModel.errorMessage ?? "Couldn't fetch posts by user id")
                }
            }
            .onChange(of: newPostViewModel.newPost) { _ in
                Task {
                    try await userViewModel.fetchPostsByUserId(userId: userId)
                }
            }
            .onChange(of: postViewModel.post) { _ in
                Task {
                    try await userViewModel.fetchPostsByUserId(userId: userId)
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
        .NavigationStackStyle()
        .frame(maxWidth: .infinity)
        .background(Color("Background"))
        .foregroundStyle(Color.white)
    }
}
