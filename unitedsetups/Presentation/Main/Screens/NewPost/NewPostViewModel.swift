//
//  PostViewModel.swift
//  unitedsetups
//
//  Created by Paras KCD on 8/10/24.
//

import SwiftUI
import PhotosUI

@MainActor class NewPostViewModel: Observable, ObservableObject {
    var uploadDataSource: UploadDataSource = Injection.shared.provideUploadDataSource()
    var createNewPostUseCase: CreateNewPostUseCase = Injection.shared.provideCreateNewPostUseCase()
    
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var postText: String = ""
    @Published var newPost: Post? = nil
    @Published var loading: Bool = false
    
    func convertDataToImage() {
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
        
        selectedPhotos.removeAll()
    }
    
    func uploadImages()  async throws -> Result<UploadResponse, Error> {
        do {
            let result = try await uploadDataSource.uploadFiles(uploadRequest: UploadRequest(apiPath: "post-media", images: images))
            if (result != nil) {
                return .success(result!)
            } else {
                return .failure(ViewModelErrors.NullException)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func createNewPost() async throws -> Void{
        do {
            loading = true
            let uploadResponse = try await uploadImages()
            
            switch uploadResponse {
            case.failure(let error):
                throw error
            
            case .success(let uploadData):
                var postMediaUrls = [PostMediaUrlRequest]()
                
                for (index, _) in uploadData.paths.enumerated() {
                    postMediaUrls.append(PostMediaUrlRequest(path: uploadData.paths[index], thumbnailPath: uploadData.thumbnails[index]))
                }
                
                let postResponse = try await createNewPostUseCase.execute(request: CreatePostRequest(text: postText, postMediaUrls: postMediaUrls))
                
                switch postResponse {
                case .success(let postData):
                    newPost = postData
                    postText = ""
                    images = []
                    loading = false
                case .failure(let error):
                    postText = ""
                    images = []
                    loading = false
                    throw error
                }
            }
        } catch {
            postText = ""
            images = []
            loading = false
            loading = false
            throw error
        }
    }
}
