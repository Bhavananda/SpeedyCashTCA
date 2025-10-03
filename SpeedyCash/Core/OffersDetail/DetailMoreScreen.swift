//
//  LoginAcceptionScreen.swift
//  PayDay
//
//  Created by Bhavananda das on 20.12.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  @Binding var zoomScale: CGFloat
  let url: URL
  @ObservedObject var viewModel: LoginViewModel
  @Binding public var progress: Double
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    
    viewModel.webView = webView
    webView.load(URLRequest(url: url))
    
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = true
    
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
    let jsCode = """
                document.body.style.zoom = '\(zoomScale)';
            """
    webView.evaluateJavaScript(jsCode, completionHandler: nil)
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  
  public class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    weak var webView: WKWebView?
    
    init(_ parent: WebView) {
      self.parent = parent
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      if keyPath == #keyPath(WKWebView.estimatedProgress),
         let webView = object as? WKWebView {
        DispatchQueue.main.async {
          self.parent.progress = webView.estimatedProgress
        }
      }
    }
    
    deinit {
      webView?.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
  }
}

//#Preview {
//    LoginAcceptionScreen()
//}
