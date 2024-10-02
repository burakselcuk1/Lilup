//
//  Images.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 01.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI

public struct LogoImageModifier: IImageModifier {
    public init() {}
    
    public func body(image: Image) -> some View {
        image
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
