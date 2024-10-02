//
//  ScreenViewModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI

final class ScreenViewModel: ObservableObject {
    
    @ViewBuilder
    func makeScreen(_ type: Mode) -> some View {
        type.screen.associatedView().lazy.toAnyView()
    }
    
    @ViewBuilder
    func createRootScreen(_ type: ModeRoot) -> some View {
        type.rootScreen.associatedRootView().lazy.toAnyView()
    }
}
