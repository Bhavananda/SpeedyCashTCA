//
//  LoginViewModel.swift
//  PayDay
//
//  Created by Bhavananda das on 20.12.2024.
//

import Foundation
import WebKit

class LoginViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }
    
    @Published var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func loadURLString() {
        if let url = URL(string: urlString) {
            webView?.load(URLRequest(url: url))
        }
    }
    
    func goBack() {
        webView?.goBack()
    }
    
    func goForward() {
        webView?.goForward()
    }
    
    func reload() {
        webView?.reload()
    }
}
