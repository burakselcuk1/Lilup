//
//  String.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

extension String: Identifiable {
    public var id: String {
        self
    }

    var isPercentEncoded: Bool {
        let decoded = self.removingPercentEncoding
        return decoded != nil && decoded != self
    }
}

protocol StringsProtocol {
    var asString: String { get }
}

extension StringsProtocol {
    var asString: String { return self as! String }
}

extension String: StringsProtocol { }
