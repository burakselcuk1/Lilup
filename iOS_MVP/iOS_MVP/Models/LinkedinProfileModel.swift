//
//  LinkedinProfileModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 08.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation

struct LinkedinProfileModel: Codable {
    let sub: String
    let emailVerified: Bool
    let name: String
    let locale: Locale
    let givenName, familyName, email: String

    enum CodingKeys: String, CodingKey {
        case sub
        case emailVerified = "email_verified"
        case name, locale
        case givenName = "given_name"
        case familyName = "family_name"
        case email
    }
}

struct ProfileTokenModel: Codable{
    let access_token : String?
    enum CodingKeys: String, CodingKey {
        case access_token
    }
}
// MARK: - Locale
struct Locale: Codable {
    let country, language: String
}
