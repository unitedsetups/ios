//
//  UploadDataSourceProtocol.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import Foundation

protocol UploadDataSourceProtocol {
    func uploadFiles(uploadRequest: UploadRequest) async throws -> UploadResponse?
}
