//
//  PostViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 8/10/24.
//

import SwiftUI
import PhotosUI

class NewPostViewModel: ObservableObject {
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var postText: String = ""
    
    @MainActor
    func convertDataToImage() {
        // reset the images array before adding more/new photos
        images.removeAll()
        
        if !selectedPhotos.isEmpty {
            for eachItem in selectedPhotos {
                Task {
                    if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: imageData) {
                            images.append(image)
                        }
                    }
                }
            }
        }
        
        // uncheck the images in the system photo picker
        selectedPhotos.removeAll()
    }
}
