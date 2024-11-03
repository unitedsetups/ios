//
//  PostThreadItem.swift
//  unitedsetups
//
//  Created by Paras KCD on 2/11/24.
//

import SwiftUI

struct PostThreadItem: View {
    var postThread: PostThread
    var isChild: Bool
    var likePostThread: (String, Bool) async throws -> Void
    var selectPostThread: (PostThread) -> Void
    
    var body: some View {
        HStack {
            if (isChild) {
                Divider().frame(maxWidth: 1, maxHeight: .infinity).background(Color.gray)
            }
            VStack {
                PostThreadHeader(postThread: postThread)
                if (postThread.postMediaUrls.count > 0) {
                    PostMedia(postMediaUrls: postThread.postMediaUrls)
                }
                PostThreadFooter(postThread: postThread, likePostThread: likePostThread, selectPostThread: selectPostThread)
                LazyVStack {
                    ForEach(Array(postThread.childrenPostThreads.enumerated()), id: \.element) {
                        index, childPostThread in
                        PostThreadItem(postThread: childPostThread, isChild: true, likePostThread: likePostThread, selectPostThread: selectPostThread)
                            .padding(.leading, 8)
                        if index != (postThread.childrenPostThreads.count - 1) {
                            Divider()
                                .background(Color.gray)
                        }
                    }
                }
            }
        }
    }
}
