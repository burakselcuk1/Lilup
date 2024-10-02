//
//  Alerts.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 04.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import SwiftUI

public struct CustomAlertView: View {
    var primaryButtonAction: () -> Void
    var secondaryButtonAction: () -> Void
    
    var titleProperties : (String, Font, Color)
    var messageProperties : (String, Font, Color)
    var primaryButtonTextProperties : (String, Font, Color)
    var secondaryButtonTextProperties : (String, Font, Color)

    public init(title: (String, Font, Color), message: (String, Font, Color), primaryButtonTitle: (String, Font, Color), secondaryButtonTitle: (String, Font, Color),primaryButtonAction: @escaping () -> Void, secondaryButtonAction: @escaping () -> Void) {
        self.titleProperties = title
        self.messageProperties = message
        self.primaryButtonTextProperties = primaryButtonTitle
        self.secondaryButtonTextProperties = secondaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Group {
                VStack(spacing: 4) {
                    alertTitle
                    alertMessage
                }
                .padding()
            }
            .multilineTextAlignment(.center)
            Divider()
            HStack(spacing: 0) {
                Button(action: {
                    secondaryButtonAction()
                }) {
                    alertSecondary
                        .fixedSize()
                }
                .frame(maxWidth: .infinity)
                .padding()
                Divider()
                Button(action: {
                    primaryButtonAction()
                }) {
                    alertPrimary
                        .fixedSize()
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .background(Color.white)
        .cornerRadius(14)
        .shadow(radius: 1)
        .frame(maxWidth: 300)
    }
    
    
    var alertTitle: Text {
        Text(with: titleProperties.0,
             font: titleProperties.1,
             color: titleProperties.2)
    }
    
    var alertMessage: Text {
        Text(with: messageProperties.0,
             font: messageProperties.1,
             color: titleProperties.2)
    }
    
    var alertPrimary: Text {
        Text(with: primaryButtonTextProperties.0,
             font: primaryButtonTextProperties.1,
             color: primaryButtonTextProperties.2)
    }
    
    var alertSecondary: Text {
        Text(with: secondaryButtonTextProperties.0,
             font: secondaryButtonTextProperties.1,
             color: secondaryButtonTextProperties.2)
    }
}
