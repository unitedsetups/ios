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
                ZStack {
                    AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(postMediaUrl.thumbnailPath)")) {
                        result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 20)
                            .clipShape(Rectangle())
                    }
                    AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(postMediaUrl.thumbnailPath)")) {
                        result in
                        result.image?
                            .resizable()
                            .scaledToFit()
                            .frame(height: 256)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .frame(height: 256)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 8)
                .shadow(radius: 16)
            }
        }
        .frame(height: 256)
        .tabViewStyle(.page)
        .padding(.vertical, 16)
    }
}
