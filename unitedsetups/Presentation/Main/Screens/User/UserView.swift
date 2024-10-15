//
//  UserView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct UserView: View {
    @StateObject var userViewModel: UserViewModel = UserViewModel(getUserByIdUseCase: Injection.shared.provideGetUserByIdUseCase(), getMyProfileUseCase: Injection.shared.provideGetMyProfileUseCase(), getAllPostsUseCase: Injection.shared.provideGetAllPostsUseCase())
    
    @State var userId: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                UserProfileHeader(userData: userViewModel.user)
                
                LazyVStack {
                    if (userViewModel.isLoading) {
                        VStack {
                            SkeletonLoadingPost()
                            SkeletonLoadingPost()
                            SkeletonLoadingPost()
                        }
                        .blinking(duration: 0.75)
                    }
                    ForEach(userViewModel.posts, id: \.id) {
                        post in
                        PostItem(post: post, isLoggedInUser: UUID(uuidString: userViewModel.loggedInUserId!) == post.postedBy.id)
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
        .task {
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
