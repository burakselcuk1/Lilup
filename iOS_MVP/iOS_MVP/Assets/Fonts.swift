//
//  Fonts.swift
//  iOS_MVP
//
//  Created by SID on 7/10/24.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI

enum Lillup_Font: CGFloat {
    case fontSize10 = 10
    case fontSize11 = 11
    case fontSize12 = 12
    case fontSize13 = 13
    case fontSize14 = 14
    case fontSize15 = 15
    case fontSize16 = 16
    case fontSize17 = 17
    case fontSize18 = 18
    case fontSize19 = 19
    case fontSize20 = 20
    case fontSize22 = 22
    case fontSize24 = 24
    case fontSize26 = 26
    case fontSize28 = 28
    case fontSize30 = 30
    case fontSize32 = 32
    case fontSize50 = 50

    var semiBold:Font{
        return Font.custom("Lato-SemiBold", size: self.rawValue)
    }
    var bold:Font{
        return Font.custom("Lato-Bold", size: self.rawValue)
    }
    var regular:Font{
        return Font.custom("Lato-Regular", size: self.rawValue)
    }
}
