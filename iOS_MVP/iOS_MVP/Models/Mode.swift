//
//  Mode.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import Foundation
import SwiftUI

protocol ModeProtocol {
    associatedtype ContentView: View
    @ViewBuilder func associatedView() -> ContentView
}

protocol ModeRootProtocol {
    associatedtype ContentRootView: View
    
    @ViewBuilder func associatedRootView() -> ContentRootView
}

enum Mode {
    case library(LibraryMode)
    case passport(PassportMode)
    case settings(SettingsMode)
    case wallet(WalletMode)
    
    var screen: any ModeProtocol {
        switch self {
        case .library(let mode): return mode
        case .passport(let mode): return mode
        case .settings(let mode): return mode
        case .wallet(let mode): return mode
        }
    }
}

enum ModeRoot {
    case login(LoginRootMode)
    case content(ContentRootMode)
    
    var rootScreen: any ModeRootProtocol {
        switch self {
        case .login(let mode): return mode
        case .content(let mode): return mode
        }
    }
}

struct LibraryMode: ModeProtocol {
    func associatedView() -> some View {
        LibraryScreen()
    }
}

struct PassportMode: ModeProtocol {
    func associatedView() -> some View {
        TallentPassportScreen()
    }
}

struct SettingsMode: ModeProtocol {
    func associatedView() -> some View {
        SettingsScreen()
    }
}

struct WalletMode: ModeProtocol {
    func associatedView() -> some View {
        WalletScreen()
    }
}

struct ContentRootMode: ModeRootProtocol {
    func associatedRootView() -> some View {
        ContentView()
    }
}

struct LoginRootMode: ModeRootProtocol {
    func associatedRootView() -> some View {
        LoginScreen()
    }
}
