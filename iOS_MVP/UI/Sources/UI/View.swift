//
//  View.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 03.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

public struct TabBarBackgroundBlurView: View {
    
    public init() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = .clear
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                BlurView(style: .systemMaterial)
                    .frame(height: geometry.safeAreaInsets.bottom + 49)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

public struct BackgroundClearView: UIViewRepresentable {
    
    public init () {}
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        //let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

public struct OnboardingView: View {
    let imageName: String
    let titleProperties : (String, Font, Color)
    let descriptionProperties : (String, Font, Color)
    
    public init(imageName: String, title: (String, Font, Color), description: (String, Font, Color), currentPageIndicator: UIColor,pageIndicatorColor : UIColor) {
        self.imageName = imageName
        self.titleProperties = title
        self.descriptionProperties = description
        UIPageControl.appearance().currentPageIndicatorTintColor = currentPageIndicator
        UIPageControl.appearance().pageIndicatorTintColor = pageIndicatorColor.withAlphaComponent(0.1)
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            Text(titleProperties.0)
                .font(titleProperties.1)
                .foregroundColor(titleProperties.2)
                .padding(.vertical)
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.teal)
                .padding(.vertical)
            Spacer()
            Text(descriptionProperties.0)
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .foregroundColor(descriptionProperties.2)
                .font(descriptionProperties.1)
                .frame(idealWidth: 214)
                .padding()
        }
        .padding(.top)
        .padding(.horizontal)
        .padding(.bottom, 100)
    }
}
