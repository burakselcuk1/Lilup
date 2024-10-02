//
//  Buttons.swift
//  ios_v1
//
//  Created by Anna Ershova on 26.05.2024.
//  Copyright © 2024 lillup. All rights reserved.
//

import Foundation
import SwiftUI

public struct SignInLinkedInButton: ButtonStyle {
    
    var color: Color
    var title: String
    var image : String
    var font : Font
    var borderColor : Color
    
    public init(color: Color = .red,title: String = "",image : String = "",font : Font = .body,borderColor : Color = .red) {
        self.color = color
        self.title = title
        self.image = image
        self.font = font
        self.borderColor = borderColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        Label(title, image: image)
            .font(font)
            .foregroundStyle(color)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 34)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}
