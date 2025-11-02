//
//  API.swift
//  Card
//
//  Created by Tim on 02/11/2025.
//

import SwiftUI

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct API {
    static func request(method: HTTPMethod, url: String) async -> URLRequest {
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    static func decode<T: Decodable>(to type: T.Type, for request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(type, from: data)
        
        return decodedData
    }
}
