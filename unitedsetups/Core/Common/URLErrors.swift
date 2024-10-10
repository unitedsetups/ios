//
//  URLErrors.swift
//  unitedsetups
//
//  Created by Paras KCD on 6/10/24.
//

import Foundation

enum URLErrors: Error {
    case InvalidUrl
    case FailedToEncodeRequest
    case InvalidResponse
    case ParsingError
    case Unauthorized
}
