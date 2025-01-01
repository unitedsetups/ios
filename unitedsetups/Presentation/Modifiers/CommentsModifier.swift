//
//  CommentsModifier.swift
//  unitedsetups
//
//  Created by Paras KCD on 3/11/24.
//

import SwiftUI
import PhotosUI

struct CommentsModifier: ViewModifier {
    @State var viewModel: PostViewModel
    @State var loading: Bool = false
    
    init (viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea(.container)
            .frame(maxWidth: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Comments")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("Surface"), for: .navigationBar)
            .background(Color("Background"))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        NewPostBottomBarButtons(selectedPhotos: $viewModel.selectedPhotos, loading: self.loading) {
                            Task {
                                self.loading = true
                                try await viewModel.createNewPostThread()
                                self.loading = false
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 56)
                    .background(Color("Surface"))
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        NewPostBottomBarButtons(selectedPhotos: $viewModel.selectedPhotos, loading: self.loading) {
                            Task {
                                self.loading = true
                                try await viewModel.createNewPostThread()
                                self.loading = false
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color("Surface"))
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
            .toolbarBackground(Color("Surface"), for: .bottomBar)
    }
}

extension View {
    func CommentsStyle(viewModel: PostViewModel) -> some View {
        modifier(CommentsModifier(viewModel: viewModel))
    }
}
