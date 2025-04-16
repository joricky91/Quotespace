//
//  NetworkingManager.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private let baseURL = "https://zenquotes.io"
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    
    typealias NetworkResponse = (data: Data, response: URLResponse)
    
    func getData<T: Codable>(from endpoint: Endpoints) async throws -> T {
        let request = try createRequest(endpoint: endpoint)
        let response: NetworkResponse = try await session.data(for: request)
        
        guard let url = request.url else { throw NetworkingError.unknown }
        try handleURLResponse(response, for: url)
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: response.data)
    }
    
    private func handleURLResponse(_ response: NetworkResponse, for url: URL) throws {
        guard let httpResponse = response.response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkingError.badURLResponse(url: url)
        }
    }
    
}

extension NetworkingManager {
    
    private func createRequest(endpoint: Endpoints) throws -> URLRequest {
        guard let path = URL(string: baseURL.appending(endpoint.path)), var components = URLComponents(url: path, resolvingAgainstBaseURL: true) else {
            throw NetworkingError.unknown
        }
        
        guard let url = components.url else { throw NetworkingError.unknown }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        return request
    }
    
}
