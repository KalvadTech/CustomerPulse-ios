//
//  CSWebView.swift
//  CustomerPulse
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import SwiftUI
import WebKit

class CSWebView: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    convenience init(surveyURL: String, isDismissible: Bool, dismissTimer: Int, withOptions options: [String: Any], completedCallback: (() -> Void)? = nil) {
        self.init()
        self.surveyURL = surveyURL
        self.surveyOptions = options
        self.isDismissible = isDismissible
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
    var surveyOptions: [String: Any] = [:]
    var isDismissible: Bool = true
    var completedCallback: (() -> Void)? = nil
    var dismissTimer: Int = 1
    let jsCompletedMessage: String = "so-widget-completed"
    var webView: WKWebView!
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = surveyURL else {
            return
        }
        
        var sURL = URLComponents(string: urlString)
        sURL?.queryItems = surveyOptions.map({ option in
            return URLQueryItem(name: option.key, value: option.value as? String)
        })
        
        guard let test = sURL?.url else {
            return
        }

        
        let surveyRequest = URLRequest(url: test)
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
        isModalInPresentation = !self.isDismissible
        view = webView
    }
    
    // MARK: - Private Methods
    
    func userCompletedSurvey() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(dismissTimer)) {
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
