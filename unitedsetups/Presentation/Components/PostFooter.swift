//
//  PostFooter.swift
//  unitedsetups
//
//  Created by Paras KCD on 11/10/24.
//

import SwiftUI

struct PostFooter: View {
    @State var upvotes: Int32
    @State var firstPostMediaUrl: URL
    @State var createdDateTime: Date
    @State var shareText: String
    var body: some View {
        HStack {
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image("ThumbsUp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text(upvotes.description)
                    }
                }
                .contentShape(Rectangle())

                Divider()
                
                Button {
                    
                } label: {
                    Image("ThumbsDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .contentShape(Rectangle())
            }
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
            
            Button {
                
            } label: {
                Image("Comment")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
            
            Spacer()
            
            ShareLink(item: firstPostMediaUrl, preview: SharePreview(shareText)) {
                Image("Share")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .padding(8)
            .background(.white.opacity(0.05))
            .cornerRadius(16)
        }
        
        HStack {
            Text(createdDateTime, format: .relative(presentation: .numeric))
                .font(.caption2)
                .foregroundStyle(.opacity(0.5))
            Spacer()
        }
    }
}
