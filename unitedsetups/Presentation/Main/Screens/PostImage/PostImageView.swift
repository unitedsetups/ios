//
//  SwiftUIView.swift
//  unitedsetups
//
//  Created by Paras KCD on 15/10/24.
//

import SwiftUI
import Zoomable

struct PostImageView: View {
    @State var screenW = 0.0
    @State var postMediaUrls: [PostMediaUrl]
    @State var selectedPostMedia: PostMediaUrl
    @State private var changeOpacity: Double = 0.4
    @State var scale = 1.0
    @State var lastScale = 0.0
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(selectedPostMedia.path)")) {
                result in
                result.image?
                    .resizable()
                    .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
                    .scaledToFill()
                    .brightness(-0.5)
                    .ignoresSafeArea(.all)
                    .blur(radius: 20)
                    .opacity(changeOpacity)
                    .animation(.easeInOut, value: changeOpacity)
                    .clipShape(Rectangle())
            }
            TabView(selection: $selectedPostMedia) {
                ForEach(postMediaUrls, id: \.id) { postMediaUrl in
                        AsyncImage(url: URL(string: "\(Constants.baseUrl)/\(postMediaUrl.path)")) {
                            result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .zoomable()
                        }
                        .tag(postMediaUrl)
                }
            }
            .tabViewStyle(.page)
            .onChange(of: selectedPostMedia) { _, _ in
                self.changeOpacity = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.changeOpacity = 0.4
                }
            }
        }
        .background(Color("Background"))
        .ignoresSafeArea(.all)
    }
    
    private func handleScaleChange(_ zoom: CGFloat) -> CGFloat {
        lastScale + zoom - (lastScale == 0 ? 0 : 1)
    }
    
    private func handleOffsetChange(_ offset: CGSize) -> CGSize {
        var newOffset: CGSize = .zero

        newOffset.width = offset.width + lastOffset.width
        newOffset.height = offset.height + lastOffset.height

        return newOffset
    }
}
