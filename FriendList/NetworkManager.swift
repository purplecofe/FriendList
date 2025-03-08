//
//  NetworkManager.swift
//  FriendList
//
//  Created by ChongKai Huang on 2025/3/6.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "NetworkError", code: httpResponse.statusCode, userInfo: nil)
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
