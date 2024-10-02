//
//  Defaults.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import Foundation
import SwiftUI

final class Defaults: ObservableObject {
    @AppStorage("didLaunchBefore") var didLaunchBefore: Bool = false
    @AppStorage("storedToken") var storedToken: TokenModel = .none
    @AppStorage("newUser") var newUser: Bool = true
    static let shared = Defaults()
}
