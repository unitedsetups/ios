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
    let maxPhotosToSelect = 5
    
    init (viewModel: NewPostViewModel) {
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        content
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
                        PhotosPicker(
                            selection: $viewModel.selectedPhotos, // holds the selected photos from the picker
                            maxSelectionCount: maxPhotosToSelect, // sets the max number of photos the user can select
                            selectionBehavior: .ordered, // ensures we get the photos in the same order that the user selected them
                            matching: .images // filter the photos library to only show images
                        ) {
                            Image("Image")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("Send")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
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
                        PhotosPicker(
                            selection: $viewModel.selectedPhotos, // holds the selected photos from the picker
                            maxSelectionCount: maxPhotosToSelect, // sets the max number of photos the user can select
                            selectionBehavior: .ordered, // ensures we get the photos in the same order that the user selected them
                            matching: .images // filter the photos library to only show images
                        ) {
                            Image("Image")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("Send")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
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
    func NewPostStyle(viewModel: NewPostViewModel) -> some View {
        modifier(NewPostModifier(viewModel: viewModel))
    }
}


