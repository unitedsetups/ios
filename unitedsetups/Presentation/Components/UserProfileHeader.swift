//
//  UserProfileHeader.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

import SwiftUI

struct UserProfileHeader: View {
    var userData: User?
    
    var body: some View {
        ZStack(alignment: Alignment.center) {
            if (userData != nil) {
                let user = userData!
                
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
    }
}
