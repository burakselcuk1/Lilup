//
//  SplashScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 01.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import UI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Image(Images.splash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            Image(Images.logo)
                .dynamicTypeSize(.small)
                //add animation
        }
        .edgesIgnoringSafeArea(.all)
    }
}

