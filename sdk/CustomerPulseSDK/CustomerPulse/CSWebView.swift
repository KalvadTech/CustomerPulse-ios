//
//  CSWebView.swift
//  CustomerPulse
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import SwiftUI
import WebKit

/// Internal view controller that displays the survey in a WKWebView.
///
/// This class handles:
/// - Loading the survey URL with query parameters
/// - JavaScript message handling for survey completion
/// - Auto-dismissal after survey completion
///
/// - Note: This is an internal class and should not be used directly.
///   Use `CustomerPulse.showSurvey()` instead.
class CSWebView: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {

    // MARK: - Initialization

    /// Creates a new CSWebView instance configured for displaying a survey.
    ///
    /// - Parameters:
    ///   - surveyURL: The base URL of the survey to load.
    ///   - appId: The application identifier to include in query parameters.
    ///   - isDismissible: Whether the user can dismiss the survey by swiping down.
    ///   - dismissTimer: Delay in milliseconds before auto-dismiss after completion.
    ///   - options: Additional query parameters to append to the URL.
    ///   - completedCallback: Closure called when the survey is completed.
    convenience init(
        surveyURL: String,
        appId: String,
        isDismissible: Bool,
        dismissTimer: Int,
        options: [String: Any],
        completedCallback: (() -> Void)? = nil
    ) {
        self.init()
        self.surveyURL = surveyURL
        self.appId = appId
        self.surveyOptions = options
        self.isDismissible = isDismissible
        self.dismissTimer = dismissTimer
        self.completedCallback = completedCallback
    }

    // MARK: - UI Components

    /// Container view with rounded corners for the survey content.
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Properties

    /// The base URL of the survey to load.
    var surveyURL: String?

    /// The application identifier included in query parameters.
    var appId: String?

    /// Additional query parameters for the survey URL.
    var surveyOptions: [String: Any] = [:]

    /// Whether the user can dismiss the survey by swiping down.
    var isDismissible: Bool = true

    /// Closure called when the survey is completed and dismissed.
    var completedCallback: (() -> Void)?

    /// Delay in milliseconds before auto-dismiss after completion.
    var dismissTimer: Int = 1000

    /// JavaScript message name that indicates survey completion.
    private let jsCompletedMessage: String = "so-widget-completed"

    /// The WKWebView instance displaying the survey.
    var webView: WKWebView!

    /// Height constraint for the container view (unused, reserved for future use).
    var containerViewHeightConstraint: NSLayoutConstraint?

    /// Bottom constraint for the container view (unused, reserved for future use).
    var containerViewBottomConstraint: NSLayoutConstraint?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSurvey()
    }

    override func loadView() {
        configureWebView()
    }

    // MARK: - Private Methods

    /// Configures the WKWebView with JavaScript message handling.
    private func configureWebView() {
        // Set up JavaScript message handler for survey completion callbacks
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")

        // Configure WKWebView
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false

        // Control whether user can dismiss by swiping down
        isModalInPresentation = !isDismissible

        view = webView
    }

    /// Builds the survey URL with query parameters and loads it in the web view.
    private func loadSurvey() {
        guard let urlString = surveyURL else {
            CustomerPulse.log("Error: surveyURL is nil")
            return
        }

        // Build URL with query parameters
        var urlComponents = URLComponents(string: urlString)

        // Add app_id to options if provided
        if let appIdentifier = appId {
            surveyOptions["app_id"] = appIdentifier
        }

        // Convert options dictionary to query items
        urlComponents?.queryItems = surveyOptions.map { option in
            URLQueryItem(name: option.key, value: option.value as? String)
        }

        guard let finalURL = urlComponents?.url else {
            CustomerPulse.log("Error: Failed to construct survey URL")
            return
        }

        CustomerPulse.log("Loading URL: \(finalURL.absoluteString)")

        let surveyRequest = URLRequest(url: finalURL)
        webView.load(surveyRequest)
    }

    /// Handles survey completion by dismissing the view after the configured delay.
    private func userCompletedSurvey() {
        CustomerPulse.log("Survey completed, dismissing in \(dismissTimer)ms")

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(dismissTimer)) { [weak self] in
            self?.dismiss(animated: true) {
                self?.completedCallback?()
            }
        }
    }

    // MARK: - WKScriptMessageHandler

    /// Receives JavaScript messages from the web view.
    ///
    /// The survey sends a "so-widget-completed" message when the user
    /// successfully completes the survey.
    ///
    /// - Parameters:
    ///   - userContentController: The content controller that delivered the message.
    ///   - message: The script message containing the completion status.
    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        guard let jsMessage = message.body as? String else {
            return
        }

        if jsMessage == jsCompletedMessage {
            userCompletedSurvey()
        }
    }
}
