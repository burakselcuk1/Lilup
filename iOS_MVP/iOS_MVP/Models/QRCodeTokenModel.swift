//
//  QRCodeTokenModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 30.08.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

struct QRCodeTokenModel {
    let data: String
    let secret: String
    let expirySeconds: TimeInterval
}
