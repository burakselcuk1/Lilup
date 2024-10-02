//
//  Optional.swift
//  iOS_MVP
//
//
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

extension Optional where Wrapped : StringsProtocol {
    
    var safeValue: String {
        if case let .some(value) = self {
            return value.asString
        }
        return ""
    }
    
    var safeValueForNA: String {
        if case let .some(value) = self {
            return value.asString
        }
        return ""
    }
    
}

extension Optional where Wrapped : BoolProtocol {
    
    var safeValue: Bool {
        if case let .some(value) = self {
            return value.asBool
        }
        return false
    }
    
    var safeValueForNA: Bool {
        if case let .some(value) = self {
            return value.asBool
        }
        return false
    }
    
}
