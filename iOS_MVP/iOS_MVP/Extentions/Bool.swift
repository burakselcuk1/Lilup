//
//  Bool.swift
//  iOS_MVP
//
//  
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

protocol BoolProtocol {
    var asBool: Bool { get }
}

extension BoolProtocol {
    var asBool: Bool { return self as! Bool }
}

extension Bool: BoolProtocol { }
