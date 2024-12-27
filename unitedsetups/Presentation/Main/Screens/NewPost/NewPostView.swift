//
//  PostView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: NewPostViewModel
    @FocusState private var focussed: Bool
    
    var body: some View {
        ZStack {
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
                                            .frame(height: 256)
                                            .blur(radius: 20)
                                            .clipShape(Rectangle())
                                        
                                        Image(uiImage: viewModel.images[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 256)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.horizontal, 8)
                                    .shadow(radius: 16)
                                    
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
                        .frame(width: UIScreen.main.bounds.width, height: 256)
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
                            .foregroundColor(.white.opacity(0.5)),
                        axis: .vertical
                    )
                    .lineLimit(1...30)
                    .focused($focussed)
                    .foregroundStyle(.white)
                    .padding(.top, !viewModel.postText.isEmpty ? 0 : 16)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Color("Surface").frame(maxWidth: .infinity, maxHeight: 56)
                }
            }
            .NewPostStyle(viewModel: viewModel)
            .onAppear() {
                focussed = true
            }
            .onChange(of: viewModel.selectedPhotos) { _ in
                viewModel.convertDataToImage()
            }
            .onChange(of: viewModel.newPost) { _ in
                dismiss()
            }
            if viewModel.loading {
                ZStack(alignment: .center) {
                    VStack {
                        ProgressView()
                            .controlSize(.large)
                        Text("Adding your post!")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
            }
        }
    }
}
