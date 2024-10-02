//
//  NetworkService.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 11.09.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import Combine

protocol INetworkService {
    func performGETRequest<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error>
}

class NetworkService: INetworkService {
    let decoder = JSONDecoder()
    
    private lazy var urlSession: URLSession = {
        return URLSession.shared
    }()
    
    init() {}
    
    func performGETRequest<T: Decodable>(url: URL, responseType: T.Type) -> AnyPublisher<T, Error> {
        print("do your GET request")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(data)
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
