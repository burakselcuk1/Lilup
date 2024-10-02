//
//  ContentView.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import SwiftUI
import Navigation

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var route: NavigationViewModel // navigation
    @State private var isPresented = false
    @State var selected: Mode = Mode.library(LibraryMode())
    @State var show: Bool = false
    
    var text: String {
        get {
//            guard let _ = authViewModel.authToken else {
//                return ""
//            }
            return "yes"
        }
    }
    
    var body: some View {
        VStack {
            ChatScreen()
            Text("Access Linkedin Token:")
            Text("\(text)")
            VStack {
                getUserInfo
            }
        }
        .padding()
    }
    
    @ViewBuilder // temp info
    var getUserInfo: some View {
        if let model = authViewModel.linkedinProfileModel {
            Text("This is temporary info")
            Text("ID: \(model.sub)")
            Text("Name: \(model.name)")
            Text("email: \(model.email)")
            Text("locale: \(model.locale)")
            Button("Finish and continue") {
                show.toggle()
            }
            .showModal(isPresented: $show) {
                OnboardingScreen(hide: $show).lazy.toAnyView()
            }
            Button("Show QR") {
                route.push(screeView: QRcodeScreen().toAnyView())
            }
        } else if let errorMessage = authViewModel.errorMessage {
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
        } else {
            VStack {
                PendingScreen()
                    .onAppear {
                        print("Fetching user info...")
                        authViewModel.getProfileDataFromLinkedIn()
                    }
            }
        }
    }
}
