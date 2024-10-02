//
//  LinkedInNetworkService.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 11.07.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import Combine

protocol ILinkedInNetworkService {
    func initiateAPISession<T: Codable>(_ type: T.Type,_ urlString: String?, method: String, token : String,parameters: [String: String]?) -> Future<T?, CustomError>
}

protocol INetworkConfiguration {
    func getHeaders(with code: String) -> [String: String]
}

class LinkedInNetworkService: ILinkedInNetworkService {
    
    let decoder = JSONDecoder()
    var configuration: INetworkConfiguration?
    
    private lazy var urlSession: URLSession = {
        return URLSession.shared
    }()

    func initiateAPISession<T: Codable>(_ type: T.Type, _ urlString: String?, method: String, token: String, parameters: [String : String]?) -> Future<T?, CustomError> {
        return Future { promise in
            guard let url = URL(string: urlString!) else {
                let error = CustomError(domain: "", code: 300, subTitle: "")
                promise(.failure(error))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.setValue(method == "GET" ? "Bearer \(token)" : "application/x-www-form-urlencoded", forHTTPHeaderField: method == "GET" ? "Authorization" : "Content-Type")
            if method == "POST" && parameters != nil{
                request.httpBody = parameters!.percentEncoded()
            }
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    let errorObj = CustomError(domain: "", code: -1, subTitle: error.localizedDescription)
                    promise(.failure(errorObj))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    let errorObj = CustomError(domain: "", code: (response as? HTTPURLResponse)!.statusCode, subTitle: "")
                    promise(.failure(errorObj))
                    return
                }
                print("Response status code: \(httpResponse.statusCode)")
                print("Error: \(error.debugDescription)")
                
                if httpResponse.statusCode < 300 && httpResponse.statusCode >= 200{
                    if let dataObject = data{
                        do {
                            let result = try JSONDecoder().decode(T.self, from: dataObject)
                            promise(.success(result))
                        } catch {
                            let errorObj = CustomError(domain: "", code: -1, subTitle: error.localizedDescription)
                            promise(.failure(errorObj))
                        }
                    }else{
                        let errorObj = CustomError(domain: "", code: httpResponse.statusCode, subTitle: "")
                        promise(.failure(errorObj))
                    }
                }else{
                    let errorObj = CustomError(domain: "", code: httpResponse.statusCode, subTitle: "")
                    promise(.failure(errorObj))
                }
            }.resume()
        }
    }
}

struct CustomError: Error {
    var domain : String = ""
    var code: Int = 0 {
        didSet{
            findErrorMessage()
        }
    }
    var message: String = ""
    var subTitle: String = ""
    
    init(domain : String, code : Int, subTitle : String) {
        self.domain = domain
        self.code = code
        self.subTitle = subTitle
        self.message = ""
    }
    
    mutating func findErrorMessage() {
        if self.code > 299 && self.code <= 399{
            self.message = "Invalid URL"
        }else if self.code > 399 && self.code >= 499{
            self.message = "Bad Request"
        }else if self.code > 499 && self.code >= 599{
            self.message = "Internal Server Error, There’s an error processing the request"
        }else{
            self.message = subTitle
        }
    }
}
