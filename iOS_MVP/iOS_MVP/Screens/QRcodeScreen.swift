//
//  QRcodeScreen.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 17.07.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeImageView: View {
    @Binding private var qrImage: UIImage?
    
    init(qrImage: Binding<UIImage?>) {
        self._qrImage = qrImage
    }
    
    var body: some View {
        Image(uiImage: qrImage ?? UIImage())
            .interpolation(.none)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct QRcodeScreen: View {
    @StateObject private var qrCodeViewModel = QRCodeViewModel()
    @State private var input = ""
    private var dataModel: QRCodeTokenModel {
        get {
            QRCodeTokenModel(data: "\(qrCodeViewModel.otp)\(qrCodeViewModel.digitalSignature)",
                             secret: "yourSecret",
                             expirySeconds: 60)
        }
    }
    
    var body: some View {
        VStack {
            QRCodeImageView(qrImage: $qrCodeViewModel.qrCodeImage)
                .frame(width: 300, height: 300) // size
            Button("generate from input") {
                qrCodeViewModel.generateQRCode(from: input)
            }
            .padding()
            Button("generate from token") {
                qrCodeViewModel.generateQRCode(from: qrCodeViewModel.token)
            }
            .padding()
            Button("token: \(qrCodeViewModel.token)") {
                qrCodeViewModel.generateToken(dataModel: dataModel)
            }
            .padding()
            Button("OTP: \(qrCodeViewModel.otp)") {
                qrCodeViewModel.generateOTP()
            }
            .padding()
            TextField("Enter your data", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Digital Signature: \(qrCodeViewModel.digitalSignature)")
                .lineLimit(3)
                .truncationMode(.tail)
            Button("Generate Digital Signature") {
                qrCodeViewModel.generateDigitalSignature(for: input)
            }
            .padding()
        }
        .onAppear {
            qrCodeViewModel.generateOTP()
            qrCodeViewModel.generateDigitalSignature(for: input)
            qrCodeViewModel.generateToken(dataModel: self.dataModel)
            qrCodeViewModel.generateQRCode(from: qrCodeViewModel.token)
        }
    }
}
