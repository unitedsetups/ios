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
    case ServerError
}

extension URLErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .InvalidUrl:
            return "Invalid URL"
        case .FailedToEncodeRequest:
            return "Failed to encode request"
        case .InvalidResponse:
            return "Something went wrong, please try again."
        case .ParsingError:
            return "Failed to parse response"
        case .Unauthorized:
            return "Invalid credentials"
        case .ServerError:
            return "Something went wrong, please try again."
        }
    }
}
