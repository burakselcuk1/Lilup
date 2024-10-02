//
//  Colors.swift
//  iOS_MVP
//
//  Created by SID on 7/10/24.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI

enum Lillup_Color : String{
    case Color_EC1F24
    case Color_1D1B20
    case Color_615F64
    case Color_1377D1
    
    var color: Color{
        return Color(uiColor: UIColor(named: self.rawValue) ?? .black)
    }
    
    var uiColor : UIColor{
        return UIColor(named: self.rawValue) ?? .black
    }
}
