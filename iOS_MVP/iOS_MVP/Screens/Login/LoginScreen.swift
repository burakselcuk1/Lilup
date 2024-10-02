//
//  LoginScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import UI
import Navigation

struct LoginScreen: View {
    @EnvironmentObject var route: NavigationViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 14
    @State var showSignIn: Bool = false
    @State private var showAlert = false
    @State private var showTerms = false
    @State private var showPolicy = false

    var body: some View {
        VStack {
            Image(Images.login)
                .modifier(LogoImageModifier())
                .padding(.vertical)
            welcome
                .padding(.bottom)
            button
                .buttonStyle(SignInLinkedInButton(color: Lillup_Color.Color_EC1F24.color, title: SignInPage.continueWithLinkedin, image: Images.linkedIn, font: Lillup_Font.fontSize19.semiBold, borderColor: Lillup_Color.Color_EC1F24.color))
                .padding(.vertical)
            policy
                .padding(.top)
        }
        .fullScreenCover(isPresented: $showAlert) {
            ZStack {
                Color.white.opacity(0.01)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showAlert = false
                    }
                CustomAlertView(title: (AlertViewPage.title,Lillup_Font.fontSize19.semiBold,Lillup_Color.Color_1D1B20.color), message: (AlertViewPage.message,Lillup_Font.fontSize16.regular,Lillup_Color.Color_615F64.color), primaryButtonTitle: (AlertViewPage.continueText,Lillup_Font.fontSize16.semiBold,Lillup_Color.Color_1377D1.color), secondaryButtonTitle: (AlertViewPage.cancel,Lillup_Font.fontSize16.semiBold,Lillup_Color.Color_1377D1.color)) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            showSignIn = true
                            showAlert = false
                        }
                    }
                } secondaryButtonAction: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            showAlert = false
                        }
                    }
                }
                .transition(.opacity)
                .background(BackgroundClearView())
            }
        }
        .blur(radius: showAlert ? 17 : 0)
        .padding()
        .ignoresSafeArea(.all)
    }
    
    var welcome: some View {
        VStack {
            Group {
                Text(SignInPage.welcome)
                    .font(Lillup_Font.fontSize50.semiBold)
                    .frame(maxWidth: .infinity, idealHeight: 41, alignment: .leading)
                VStack {
                    Text(SignInPage.reshapingThwWay)
                        .font(Lillup_Font.fontSize19.semiBold)
                        .frame(maxWidth: .infinity, idealHeight: 25, alignment: .leading)
                    Text(SignInPage.workLiveLearn)
                        .font(Lillup_Font.fontSize24.bold)
                        .frame(maxWidth: .infinity, idealHeight: 34, alignment: .leading)
                }
            }
            //   .foregroundStyle(.textLogin)
        }
    }
    
    var button: some View {
        Button("") {
            authViewModel.showPopUp($showAlert, $showSignIn)
        }
        .showModal(isPresented: $showSignIn, screen: {
            LinkedinView(isLoading: $showSignIn) { code in
                authViewModel.fetchAccessToken(with: code)
                route.pop()
                // to be modified
                //route.push(screeView: PendingScreen().lazy.toAnyView())
            }.lazy.toAnyView()
        })
    }
    
    var policy: some View {
        VStack(spacing: 4) {
            Group {
                HStack(spacing: 4) {
                    Text(SignInPage.agreeLillup)
                        .layoutPriority(1)
                        .foregroundColor(Lillup_Color.Color_615F64.color)
                        .font(Lillup_Font.fontSize14.regular)
                    Button(SignInPage.termsAndCondition) {
                        showTerms.toggle()
                    }
                    .foregroundStyle(Lillup_Color.Color_1377D1.color)
                    .font(Lillup_Font.fontSize14.regular)
                    .popover(isPresented: $showTerms) {
                        AGScreen(model: TextFileViewModel("Terms"), type : .termsAndCondition)
                            .lazy
                            .toAnyView()
                            .ignoresSafeArea(.all)
                    }
                }
                HStack {
                    Text(SignInPage.haveReadOur)
                        .foregroundColor(Lillup_Color.Color_615F64.color)
                        .font(Lillup_Font.fontSize14.regular)
                    Button(SignInPage.privacyPolicy) {
                        showPolicy.toggle()
                    }
                    .foregroundStyle(Lillup_Color.Color_1377D1.color)
                    .font(Lillup_Font.fontSize14.regular)
                    .popover(isPresented: $showPolicy) {
                        AGScreen(model: TextFileViewModel("Policy"), type : .privacyPolicy)
                            .lazy
                            .toAnyView()
                            .ignoresSafeArea(.all)
                    }
                }
                .padding(.top, 4)
            }
            .font(Lillup_Font.fontSize14.regular)//Font.custom("Lato-Regular", size: scaledPadding))
            .frame(maxWidth: .infinity, idealHeight: 22, alignment: .leading)
        }
    }
}

