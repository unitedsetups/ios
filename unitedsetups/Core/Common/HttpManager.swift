//
//  HttpManager.swift
//  unitedsetups
//
//  Created by Paras KCD on 12/10/24.
//

import Foundation

struct HttpManager {
    func GET(url: URL?, accessToken: String, revokeAccessToken: () -> Void) async throws -> (Data, URLResponse) {
        guard let url = url else {
            throw URLErrors.InvalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode < 402 else {
            throw URLErrors.InvalidResponse
        }
        
        if (response.statusCode == 401) {
            revokeAccessToken()
            throw URLErrors.Unauthorized
        }
        
        if (response.statusCode >= 400) {
            throw URLErrors.InvalidResponse
        }
        
        return (data, response)
    }
    
    func POST(url: URL?, accessToken: String, revokeAccessToken: () -> Void, body: Data) async throws -> (Data, URLResponse) {
        guard let url = url else {
            throw URLErrors.InvalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode < 402 else {
            throw URLErrors.InvalidResponse
        }
        
        if (response.statusCode == 401) {
            revokeAccessToken()
            throw URLErrors.Unauthorized
        }
        
        if (response.statusCode >= 400) {
            throw URLErrors.InvalidResponse
        }
        
        return (data, response)
    }
    
    static let shared = HttpManager()
}
