//
//  NewPostBottomBarButtons.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct NewPostBottomBarButtons: View {
    @Binding var selectedPhotos: [PhotosPickerItem]
    @State var loading: Bool
    @MainActor var createNewPost: () -> Void
    
    var body: some View {
        if (loading) {
            ProgressView()
        } else {
            PhotosPicker(
                selection: $selectedPhotos,
                maxSelectionCount: 5,
                selectionBehavior: .ordered,
                matching: .images
            ) {
                Image("Image")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
            }

            Spacer()
            
            Button {
                createNewPost()
            } label: {
                Image("Send")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
            }
        }
    }
}
