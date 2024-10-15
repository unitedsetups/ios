//
//  PostMedia.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostMedia: View {
    @State var postMediaUrls: [PostMediaUrl]
    var body: some View {
        TabView {
            ForEach(postMediaUrls, id: \.id) { postMediaUrl in
                NavigationLink {
                    PostImageView(postMediaUrls: postMediaUrls, selectedPostMedia: postMediaUrl)
                } label: {
                    ZStack {
                        AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(postMediaUrl.thumbnailPath)")) {
                            result in
                            if result.image == nil {
                                SkeletonLoadingImage()
                                    .blinking(duration: 0.75)
                            }
                            result.image?
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 20)
                                .frame(maxWidth: .infinity, maxHeight: 256)
                                .clipShape(Rectangle())
                        }
                        AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(postMediaUrl.thumbnailPath)")) {
                            result in
                            if result.image == nil {
                                SkeletonLoadingImage()
                                    .blinking(duration: 0.75)
                            }
                            result.image?
                                .resizable()
                                .scaledToFit()
                                .frame(height: 256)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .frame(height: 256)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 12)
                    .shadow(radius: 16)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(height: 256)
        .tabViewStyle(.page)
        .padding(.vertical, 16)
    }
}
