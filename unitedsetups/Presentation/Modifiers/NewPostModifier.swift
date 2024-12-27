//
//  File.swift
//  unitedsetups
//
//  Created by Paras KCD on 8/10/24.
//

import SwiftUI
import PhotosUI

struct NewPostModifier: ViewModifier {
    @State var viewModel: NewPostViewModel
    @State var loading: Bool = false
    let maxPhotosToSelect = 5
    
    init (viewModel: NewPostViewModel) {
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("New Post")
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
                        if !loading {
                            NewPostBottomBarButtons(selectedPhotos: $viewModel.selectedPhotos) {
                                Task {
                                    loading = true
                                    try await viewModel.createNewPost()
                                }
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
                        if !loading {
                            NewPostBottomBarButtons(selectedPhotos: $viewModel.selectedPhotos) {
                                Task {
                                    loading = true
                                    try await viewModel.createNewPost()
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 56)
                    .background(Color("Surface"))
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
            .toolbarBackground(Color("Surface"), for: .bottomBar)
    }
}

extension View {
    func NewPostStyle(viewModel: NewPostViewModel) -> some View {
        modifier(NewPostModifier(viewModel: viewModel))
    }
}
