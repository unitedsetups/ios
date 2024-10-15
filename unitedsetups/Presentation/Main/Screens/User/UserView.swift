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
                ZStack(alignment: Alignment.center) {
                    if (userViewModel.user != nil) {
                        let user = userViewModel.user!
                        
                        if (user.coverImageUrl != nil) {
                            let coverImageUrl = user.coverImageUrl!
                            AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(coverImageUrl)")) {
                                result in
                                if (result.image != nil) {
                                    result.image!
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 150)
                                        .cornerRadius(16, corners: [.bottomRight, .bottomLeft])
                                }
                            }
                        }
                        else {
                            Rectangle()
                                .fill(.clear)
                                .background(Color("Background"))
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 150)
                                .cornerRadius(16, corners: [.bottomRight, .bottomLeft])
                        }
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 150)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("Surface"), .clear]), startPoint: .top, endPoint: .bottom))
                        
                        VStack {
                            if (user.profileImageUrl != nil) {
                                let profileImageUrl = user.profileImageUrl!
                                AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(profileImageUrl)")) {
                                    result in
                                    if (result.image != nil) {
                                        result.image!
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                            .shadow(radius: 16)
                                    }
                                }
                            }
                            else {
                                ZStack {
                                    Image("Person")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                                .frame(width: 120, height: 120)
                                .background(Color("Background"))
                                .clipShape(Circle())
                                .shadow(radius: 16)
                            }
                            Text(user.name)
                        }
                        .offset(y: 100)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.bottom, 140)
                .background(Color("Surface"))
                .cornerRadius(16, corners: [.bottomRight, .bottomLeft])
                
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Image("USLogoWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 48)
                }
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color("Surface"), for: .navigationBar)
        .frame(maxWidth: .infinity)
        .background(Color("Background"))
        .foregroundStyle(Color.white)
    }
}
