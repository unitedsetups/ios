//
//  PostPostedByDetails.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostHeader: View {
    var postedByName: String
    var postedByUsername: String
    var asyncProfilePictureUrl: URL?
    var isLoggedInUser: Bool
    var text: String
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: asyncProfilePictureUrl) {
                    result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .shadow(radius: 16)
                Text(postedByName)
                    .font(.caption)
                Text(" @\(postedByUsername)")
                    .font(.caption)
                    .foregroundStyle(.opacity(0.5))
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
                Text(text)
                    .font(.body)
                Spacer()
            }
        }
    }
}
