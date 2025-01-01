//
//  UserView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    
    @StateObject var userViewModel: UserViewModel = UserViewModel(getUserByIdUseCase: Injection.shared.provideGetUserByIdUseCase(), getMyProfileUseCase: Injection.shared.provideGetMyProfileUseCase(), getAllPostsUseCase: Injection.shared.provideGetAllPostsUseCase(), likePostUseCase: Injection.shared.provideLikePostUseCase())
    
    @State var userId: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                UserProfileHeader(userData: userViewModel.user, signOutAction: {authViewModel.signOut()})
                
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
                            postIdLoading: userViewModel.postIdLoading
                        ) { id, index in
                            do {
                                try await userViewModel.likePost(id: id, liked: index)
                            } catch {
                                print(error)
                            }
                        }
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
        .NavigationStackStyle()
        .frame(maxWidth: .infinity)
        .background(Color("Background"))
        .foregroundStyle(Color.white)
    }
}
