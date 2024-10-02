//
//  PendingScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 12.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI

struct PendingScreen: View {
    @State private var imageIndex = 0
    @State private var isAnimating = false
    
    let images = [Images.pendingCube1, Images.pendingCube2,Images.pendingCube3,Images.pendingCube4]
    
    let animationDuration = 1.0
    
    var body: some View {
        VStack {
            Image(images[imageIndex])
                .resizable()
                .frame(width: 50, height: 50)
                .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true), value: isAnimating)
                .onAppear {
                    startAnimation()
                    self.isAnimating = true
                }
            Text(Common.loading)
                .font(.headline)
                .padding(.top, 20)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(.top, 10)
        }
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { timer in
            imageIndex = (imageIndex + 1) % images.count
        }
    }
}
