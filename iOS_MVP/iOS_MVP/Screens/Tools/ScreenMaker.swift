//
//  ScreenMaker.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import Navigation

struct ScreenMaker: View {
    @Binding var selected: Mode
    var type = ScreenViewModel()

    var screen: AnyView {
        get { type.makeScreen(selected).lazy.toAnyView() }
    }
    
    var body: some View {
        screen
    }
}
