//
//  URL.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(string: "\(value)")!
    }
    
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
}
