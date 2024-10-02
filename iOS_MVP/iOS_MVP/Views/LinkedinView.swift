//
//  LinkedinView.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 28.05.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import SwiftUI
import UIKit
import WebKit

struct LinkedinView: UIViewRepresentable {
    @EnvironmentObject var authVieModel: AuthViewModel
    @Binding var isLoading: Bool
    var onSignIn: (String) -> ()
    var webView: WKWebView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        guard let url = authVieModel.linkedinFullURL else { return webView }
        print(url)
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("update")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
    var parent: LinkedinView
    
    init(_ parent: LinkedinView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if let code = url.queryParameters?["code"] {
                parent.isLoading = false
                parent.onSignIn(code)
            }
            let encoded = url.absoluteString.isPercentEncoded
            if encoded { print(url.path(percentEncoded: false)) }
            if (encoded &&
                (url.path(percentEncoded: false).contains("v2/login-cancel") ||
                 url.path(percentEncoded: false).contains("v2/authorization-cancel"))) {
                parent.isLoading = false
                parent.authVieModel.alert = false
                decisionHandler(.cancel)
                print("cancel")
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        let error = error as NSError
        print(error.code)
        switch(error.code) {
        case NSURLErrorNotConnectedToInternet:
            print("no connection")
            break
        case NSURLErrorTimedOut:
            print("time out")
            break
        default:
            break
        }
        parent.webView.reload()
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("close")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
        //handle continue with google
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        print("error")
    }
}
