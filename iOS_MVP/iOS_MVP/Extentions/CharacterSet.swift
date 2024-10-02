//
//  CharacterSet.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 11.07.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "&=?/")
        return allowed
    }()
}
