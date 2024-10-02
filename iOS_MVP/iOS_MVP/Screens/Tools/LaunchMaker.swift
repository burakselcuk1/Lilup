//
//  LaunchMaker.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import Navigation
import UI

struct LaunchMaker: View {
    @StateObject var authViewModel: AuthViewModel = .init()
    @State var isActive: Bool = false
    @Default(\.storedToken) var storedToken
    
    var selected: ModeRoot {
        get {
            if storedToken == .none { return ModeRoot.login(LoginRootMode()) }
            return ModeRoot.content(ContentRootMode())
        }
    }
    var type = ScreenViewModel()
    
    var body: some View {
        //TabView {
        content
        //}
        //.background(TabBarBackgroundBlurView())
            .edgesIgnoringSafeArea(.all)
            .environmentObject(authViewModel)
    }
    
    var screen: AnyView {
        get {
            type.createRootScreen(selected).lazy.toAnyView()
        }
    }
    
    var content: some View {
        GeometryReader { geometry in
            ZStack {
                Navigation(transition: Transition.custom(.opacity)) {
                    screen
                }
                .opacity(isActive ? 1 : 0)
                .offset(y: isActive ? 0 : geometry.size.height + geometry.safeAreaInsets.bottom)
                SplashScreen()
                    .offset(y: isActive ? -geometry.size.height - geometry.safeAreaInsets.bottom : 0)
                    .opacity(isActive ? 0 : 1)
            }
            .frame(width: geometry.size.width, height: geometry.size.height + geometry.safeAreaInsets.bottom)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
