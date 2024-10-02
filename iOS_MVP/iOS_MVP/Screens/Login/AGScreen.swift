//
//  AGScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 02.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI

enum AGScreenType{
    case termsAndCondition
    case privacyPolicy
}

struct AGScreen: View {
    @StateObject var model: TextFileViewModel
    var type: AGScreenType
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer(minLength: 10.0)
                Text(type == .termsAndCondition ? SignInPage.termsAndCondition : SignInPage.privacyPolicyHeadText)
                    .frame(height: 50.0)
                    .font(Lillup_Font.fontSize26.bold)
                    .foregroundColor(Lillup_Color.Color_1D1B20.color)
                Text(model.data)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .presentationDetents([.large,.large])
    }
}
