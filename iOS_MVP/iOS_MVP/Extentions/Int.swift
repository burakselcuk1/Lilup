//
//  Int.swift
//  iOS_MVP
//
//
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

//MARK :- Optional Int to its value
protocol IntProtocol {
    var asInt: Int { get }
}

extension IntProtocol {
    var asInt: Int { return self as! Int }
}

extension Int: IntProtocol { }

extension Optional where Wrapped : IntProtocol {
    
    var safeValue: Int {
        if case let .some(value) = self {
            return value.asInt
        }
        return 0
    }
}
