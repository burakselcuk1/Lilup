//
//  OnboardingScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 12.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import UI

struct OnboardingScreen: View {
    @Binding var hide: Bool
    @State var current: Int = 1 {
        didSet {
            if oldValue == 3 {
                // change to the chat screen
                hide.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            TabView(selection: $current) {
                OnboardingView(imageName: Images.onboard_FirstPageImage,
                               title: (OnBoardingPage.firstPageTitle,Lillup_Font.fontSize24.bold,Lillup_Color.Color_1D1B20.color),
                               description: (OnBoardingPage.firstPageDescription,Lillup_Font.fontSize17.regular,Lillup_Color.Color_1D1B20.color), currentPageIndicator: Lillup_Color.Color_EC1F24.uiColor, pageIndicatorColor: Lillup_Color.Color_EC1F24.uiColor)
                .tag(1)
                OnboardingView(imageName: Images.onboard_SecondPageImage,
                               title: (OnBoardingPage.secondPageTitle,Lillup_Font.fontSize24.bold,Lillup_Color.Color_1D1B20.color),
                               description: (OnBoardingPage.secondPageDescription,Lillup_Font.fontSize17.regular,Lillup_Color.Color_1D1B20.color), currentPageIndicator: Lillup_Color.Color_EC1F24.uiColor, pageIndicatorColor: Lillup_Color.Color_EC1F24.uiColor)
                .tag(2)
                OnboardingView(imageName:Images.onboard_ThirdPageImage,
                               title: (OnBoardingPage.thirdPageTitle,Lillup_Font.fontSize24.bold,Lillup_Color.Color_1D1B20.color),
                               description: (OnBoardingPage.thirdPageDescription,Lillup_Font.fontSize17.regular,Lillup_Color.Color_1D1B20.color), currentPageIndicator: Lillup_Color.Color_EC1F24.uiColor, pageIndicatorColor: Lillup_Color.Color_EC1F24.uiColor)
                .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            Button(OnBoardingPage.skip) {
                current += 1
            }
            .foregroundColor(Lillup_Color.Color_1377D1.color)
            .font(Lillup_Font.fontSize16.semiBold)
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
    }
}
