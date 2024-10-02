//
//  AuthViewModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Injected var network: LinkedInNetworkService?
    @Injected var keychain: KeychainService?
    @Default(\.storedToken) var storedToken
    @Published var isLoading: Bool = false
    @Published var linkedinProfileModel: LinkedinProfileModel?
    private var cancellable: AnyCancellable?
    private let service = "com.example.linkedin"
    private let account = "authToken"
    var errorMessage: String?
    var alert: Bool?
    
    var showPopUp: (Binding<Bool>, Binding<Bool>)->() {
        return { [self] popup, login in
            guard let _ = self.alert else {
                return popup.wrappedValue.toggle()
            }
            login.wrappedValue.toggle()
        }
    }
    
    var linkedinFullURL: URL? {
        AuthLinkedinConfig.getQueryItems().url
    }
    
    init() {
        self.network?.configuration = AuthLinkedinConfig()
    }
    
    func fetchAccessToken(with code: String) {
        isLoading = true
        if let _ = cancellable { return }
        cancellable = network?.initiateAPISession(ProfileTokenModel.self, AuthLinkedinConfig.getBaseUrl(), method: "POST", token: "", parameters: AuthLinkedinConfig().getHeaders(with: code)).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching user info: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }, receiveValue: { [self] tokenModel in
                if let token = tokenModel?.access_token.safeValue.data(using: .utf8) {
                    let _ = keychain?.save(service: service, account: account, data: token)
                    self.storedToken = .valid
                    self.isLoading = false
                }
            })
    }
    
    func getProfileDataFromLinkedIn() {
        if let token = keychain?.retrieve(service: service, account: account){
            print("token:\(token)")
            if let _ = cancellable, let _ = linkedinProfileModel { return }
            cancellable = network?.initiateAPISession(LinkedinProfileModel.self, AuthLinkedinConfig.getUserInfoUrl(), method: "GET", token: token, parameters: nil)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error fetching user info: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { info in
                    print(info as Any)
                    self.linkedinProfileModel = info
                    self.cancellable?.cancel()
                })
        }
    }
}
