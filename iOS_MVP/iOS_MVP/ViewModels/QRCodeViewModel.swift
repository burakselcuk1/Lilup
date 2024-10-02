//
//  QRCodeViewModel.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 30.08.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import UIKit
import CryptoKit

protocol ITokenable {
    associatedtype QRCodeToken
    
    func generateToken(dataModel: QRCodeToken)
}

class QRCodeViewModel: ObservableObject, ITokenable {
    @Published var qrCodeImage: UIImage?
    @Published var token: String = ""
    @Published var otp: String = ""
    @Published var digitalSignature: String = ""
    private let qrCodeGenerator = QRCodeGenerator()
    private let tokenGenerator = TokenGenerator()
    private let otpGenerator = OTPGenerator()
    private let digitalSignatureGenerator = DigitalSignatureGenerator()
    
    func generateQRCode(from string: String) {
        qrCodeImage = qrCodeGenerator.generateQRCode(from: string)
    }
    
    func generateToken(dataModel: QRCodeTokenModel) {
        let data = dataModel.data
        let secret = dataModel.secret
        let expirySeconds = dataModel.expirySeconds
        token = tokenGenerator.generateToken(data, secret, expirySeconds) ?? ""
    }
    
    func generateOTP() {
        otp = otpGenerator.generateOTP()
    }
    
    func generateDigitalSignature(for message: String) {
        digitalSignature = digitalSignatureGenerator.generateDigitalSignature(for: message)
    }
}

struct TokenGenerator {
    func generateToken(_ data: String, _ secret: String, _ expirySeconds: TimeInterval) -> String? { // The HS256 algorithm stands for HMAC using SHA-256. CryptoKit
        let currentTime = Date().timeIntervalSince1970
        let expiryTime = currentTime + expirySeconds
        guard let result = "\(data)\(expiryTime)".data(using: .utf8),
              let secretData = secret.data(using: .utf8)
        else { return nil }
        let key = SymmetricKey(data: secretData)
        // HMAC using SHA256 (HS256)
        let hmac = HMAC<SHA256>.authenticationCode(for: result, using: key)
        
        // Convert HMAC to base64
        let hmacData = Data(hmac)
        let hmacString = hmacData.base64EncodedString()
        
        // Combine the HMAC and the expiry time into the token
        let token = "\(hmacString).\(expiryTime)"
        return token
        //UUID().uuidString
    }
}

struct OTPGenerator {
    func generateOTP() -> String {
        String(format: "%06d", Int.random(in: 0...999999))
    }
}

struct DigitalSignatureGenerator {
    func generateDigitalSignature(for message: String) -> String {
        let privateKey = P256.Signing.PrivateKey()
        let data = Data(message.utf8)
        if let signature = try? privateKey.signature(for: data) {
            return signature.derRepresentation.base64EncodedString()
        }
        return "Error generating signature"
    }
}

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}
