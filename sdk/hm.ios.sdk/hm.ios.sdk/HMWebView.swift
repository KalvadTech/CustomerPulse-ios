//
//  HMSDKWebView.swift
//  hm.ios.sdk
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import SwiftUI
import WebKit

class HMSDKWebView: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    convenience init(surveyURL: String, dismissTimer: Double, completedCallback: (() -> Void)? = nil) {
        self.init()
        self.surveyURL = surveyURL
        self.dismissTimer = dismissTimer
        self.completedCallback = completedCallback
    }
    
    // MARK: - UI
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    var surveyURL: String?
    var completedCallback: (() -> Void)? = nil
    var dismissTimer: Double = 1
    let defaultHeight: CGFloat = 300
    let jsCompletedMessage: String = "so-widget-completed"
    var webView: WKWebView!
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = surveyURL else {
            return
        }
        
        let sURL = URL(string: urlString)
        let surveyRequest = URLRequest(url: sURL!)
        webView.load(surveyRequest)
    }
    
    override func loadView() {
        let contentController = WKUserContentController()
        contentController.add(
            self,
            name: "callbackHandler"
        )
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        view = webView
    }
    
    // MARK: - Private Methods
    
    func userCompletedSurvey() {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissTimer) {
            self.dismiss(animated: true) {
                if let callback = self.completedCallback {
                    callback()
                }
            }
        }
    }
    
    // MARK: - WebView Methods
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let jsMessage = message.body as? String else {
            return
        }
        
        if (jsMessage == jsCompletedMessage) {
            self.userCompletedSurvey()
        }
    }
}
