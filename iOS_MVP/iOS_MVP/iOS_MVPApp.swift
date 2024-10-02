//
//  iOS_MVPApp.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import SwiftUI
import Navigation

@main
struct iOS_MVPApp: App {
    @ObservedObject var route: NavigationViewModel = .init()
    @Environment (\.scenePhase) private var scenePhase
    @Configurator var config: ()
    @AppManager var appManager

    init() {
        config
    }

    var body: some Scene {
        WindowGroup {
            LaunchMaker()
                .preferredColorScheme(.light)
                .environmentObject(route)
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                appManager.appPhase = .active
                print("active")
            case .inactive:
                appManager.appPhase = .inactive
                print("inactive")
            case .background:
                appManager.appPhase = .background
                print("background")
            default:
                appManager.appPhase = .none
                print("none")
            }
        }
    }
}
