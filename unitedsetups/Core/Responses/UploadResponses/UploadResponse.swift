//
//  UploadResponse.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import Foundation

struct UploadResponse: Decodable {
    let paths: [String]
    let thumbnails: [String]
}
