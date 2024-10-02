//
//  AppManagerViewModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 21.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import UIKit

final class AppManagerViewModel {
    var appPhase: AppPhase = .none

    enum AppPhase {
        case active
        case inactive
        case background
        case none
    }
}

@propertyWrapper 
struct AppManager {
    var wrappedValue: AppManagerViewModel {
        return AppManagerViewModel()
    }
}

