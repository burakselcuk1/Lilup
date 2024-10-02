//
//  AuthLinkedinConfig.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

class AuthLinkedinConfig: INetworkConfiguration {
    private let clientID: String = "78dpczyrtg5too"
    private let clientSecret: String = "WPL_AP0.msNtZfOmQTLtyXPr.MTIzODQwMjM5NQ=="
    private let redirectUrl: String = "https://app.lillup.com/auth/linkedin/callback"
    private let authBaseUrl: String = "https://www.linkedin.com/oauth/v2/authorization"

    static func getQueryItems() -> URLComponents {
        var urlComponents = URLComponents(string: "https://www.linkedin.com/oauth/v2/authorization")!
        urlComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: "78dpczyrtg5too"),
            URLQueryItem(name: "redirect_uri", value: "https://app.lillup.com/auth/linkedin/callback"),
            URLQueryItem(name: "scope", value: "openid email w_member_social profile")
        ]
        return urlComponents
    }
    
    func getHeaders(with code: String) -> [String: String] {
        return [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirectUrl,
            "client_id": clientID,
            "client_secret": clientSecret
        ]
    }
    
    static func getBaseUrl() -> String {
        "https://www.linkedin.com/oauth/v2/accessToken"
    }
    
    static func getUserInfoUrl() -> String {
        "https://api.linkedin.com/v2/userinfo" // ok
    }
}
