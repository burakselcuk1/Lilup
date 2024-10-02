//
//  Configurator.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import Foundation
import SwiftUI

class Configuration {
    static func register() {
        ServiceLocator.shared.addServices(service: LinkedInNetworkService())
        ServiceLocator.shared.addServices(service: KeychainService())
        ServiceLocator.shared.addServices(service: NetworkService())
    }
}

@propertyWrapper
struct Configurator {
    var wrappedValue: () {
        return Configuration.register()
    }
}
