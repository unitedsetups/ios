//
//  UploadDataSource.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import Foundation
import Alamofire

struct UploadDataSource {
    let tokenManager: TokenManager = Injection.shared.provideTokenManager()
    
    private init() {}
    
    static let shared: UploadDataSource = UploadDataSource()
}

extension UploadDataSource : UploadDataSourceProtocol {
    func uploadFiles(uploadRequest: UploadRequest) async throws -> UploadResponse? {
        let headers: HTTPHeaders = [
            .authorization("Bearer \(tokenManager.getAccessToken())"),
            .accept("multipart/form-data")
        ]
        
        let req = AF.upload(multipartFormData: { multipartFormData in
            for (index, image) in uploadRequest.images.enumerated() {
                multipartFormData.append(image.pngData()!, withName: "files", fileName: "File\(index).png", mimeType: "image/png")
            }
            
        }, to: Constants.uploadFilesEndpoint(uploadRequest), method: .post, headers: headers)

        let result = try? await withCheckedThrowingContinuation { continuation in
            req.responseDecodable(of: UploadResponse.self) { responseData in
                continuation.resume(with: responseData.result)
            }
        }
        
        return result
    }
}
