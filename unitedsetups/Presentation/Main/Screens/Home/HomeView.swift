//
//  HomeView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel : HomeViewModel = .init(getAllPostsUseCase: Injection.shared.provideGetAllPostsUseCase())
    @StateObject var newPostViewModel : NewPostViewModel = NewPostViewModel()
    
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
                    }
                    ForEach(homeViewModel.posts, id: \.id) {
                        post in
                        PostItem(post: post, isLoggedInUser: UUID(uuidString: homeViewModel.loggedInUserId!) == post.postedBy.id)
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
        .task {
            do {
                try await homeViewModel.fetchPosts()
            } catch {
                print(homeViewModel.errorMessage ?? "Couldn't fetch posts")
            }
        }
        .frame(maxWidth: .infinity)
    }
}
