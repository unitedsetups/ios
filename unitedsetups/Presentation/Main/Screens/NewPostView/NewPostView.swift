//
//  PostView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct NewPostView: View {
    @StateObject var viewModel = NewPostViewModel()
    @FocusState private var focussed: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if (viewModel.images.count > 0) {
                    TabView {
                        ForEach(0..<viewModel.images.count, id: \.self) { index in
                            ZStack(alignment: .topLeading) {
                                ZStack {
                                    Image(uiImage: viewModel.images[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width, height: 200)
                                        .blur(radius: 20)
                                    
                                    Image(uiImage: viewModel.images[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                }
                                
                                Button{
                                    viewModel.images.remove(at: index)
                                } label: {
                                    Image("Close")
                                        .renderingMode(.template)
                                        .padding(4)
                                        .background(.accent)
                                        .foregroundStyle(.black)
                                        .clipShape(Circle())
                                        .padding()
                                }
                            }
                            
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .tabViewStyle(.page)
                }
                
                if (!viewModel.postText.isEmpty) {
                    Text("What's on your mind?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .font(.footnote)
                        .foregroundStyle(.accent)
                }
                
                TextField(
                    "",
                    text: $viewModel.postText,
                    prompt: Text("What's on your mind?")
                        .foregroundStyle(.white.opacity(0.5)),
                    axis: .vertical
                )
                .lineLimit(1...30)
                .focused($focussed)
                .foregroundStyle(.white)
                .padding(.top, !viewModel.postText.isEmpty ? 0 : 16)
                .padding(.horizontal, 16)
                
                Spacer()
                
                Color.clear.frame(height: 32)
            }
            
        }
        .NewPostStyle(viewModel: viewModel)
        .onAppear() {
            focussed = true
        }
        .onChange(of: viewModel.selectedPhotos) { _, _ in
            viewModel.convertDataToImage()
        }
    }
}
