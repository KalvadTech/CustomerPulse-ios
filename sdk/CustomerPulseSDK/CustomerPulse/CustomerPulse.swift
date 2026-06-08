//
//  CustomerPulse.swift
//  CustomerPulse
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import UIKit

/// Delegate protocol for CustomerPulse survey events.
///
/// `csUserSurveyError()` and `csUserDismissedSurvey()` are optional: empty default
/// implementations are provided by the protocol extension below, so existing
/// conformers that only implement `csUserCompletedSurvey()` continue to compile
/// unchanged.
public protocol CustomerPulseDelegate: AnyObject {
    /// Called when the user has successfully completed the survey
    /// (web event `so-widget-completed`).
    func csUserCompletedSurvey()

    /// Called when the survey reports an error (web event `so-widget-error`).
    ///
    /// Fires at event-receipt time. The survey is not dismissed by the SDK in
    /// response to this event. Optional — defaults to a no-op.
    func csUserSurveyError()

    /// Called when the survey is dismissed (web event `so-widget-closed`).
    ///
    /// Fires at event-receipt time. Optional — defaults to a no-op.
    func csUserDismissedSurvey()
}

public extension CustomerPulseDelegate {
    func csUserSurveyError() {}
    func csUserDismissedSurvey() {}
}

/// CustomerPulse SDK for displaying surveys
public class CustomerPulse {

    // MARK: - Configuration

    /// Environment configuration for CustomerPulse SDK
    public enum Environment {
        case production
        case sandbox

        var baseURL: String {
            switch self {
            case .production:
                return "https://survey.customerpulse.gov.ae"
            case .sandbox:
                return "https://sandboxsurvey.customerpulse.gov.ae"
            }
        }
    }

    /// Current environment. Set before calling showSurvey. Default: .production
    public static var environment: Environment = .production

    /// Enable debug logging. Default: false
    public static var debugLogging: Bool = false

    // MARK: - Private Properties

    private let appId: String
    
    private let token: String

    // MARK: - Public Properties

    /// Delegate for survey events (completion, error, dismissal)
    public weak var delegate: CustomerPulseDelegate?

    // MARK: - Initialization

    /// Initialize CustomerPulse SDK
    /// - Parameters:
    ///   - appId: Your application ID
    ///   - token: Your survey token or link
    public init(appId: String, token: String) {
        self.appId = appId
        self.token = token
        Self.log("SDK initialized with appId: \(appId)")
    }

    // MARK: - Public Methods

    /// Displays the survey in a WKWebView.
    ///
    /// - Parameters:
    ///   - viewController: The view controller where the survey will be presented.
    ///   - isDismissible: Whether the survey can be dismissed by the user. Default: true.
    ///   - dismissAfter: Delay in milliseconds before auto-dismiss after completion. Default: 1000ms.
    ///   - options: Dictionary of optional parameters (e.g., ["lang": "ar"]).
    public func showSurvey(
        on viewController: UIViewController,
        isDismissible: Bool = true,
        dismissAfter: Int = 1000,
        options: [String: Any] = [:]
    ) {
        let surveyURL = "\(Self.environment.baseURL)/\(token)"
        Self.log("Environment: \(Self.environment)")
        Self.log("Loading survey: \(surveyURL)")
        Self.log("Options: \(options)")

        let webView = CSWebView(
            surveyURL: surveyURL,
            appId: appId,
            isDismissible: isDismissible,
            dismissTimer: dismissAfter,
            options: options,
            completedCallback: { [weak self] in
                Self.log("Survey completed")
                self?.delegate?.csUserCompletedSurvey()
            },
            errorCallback: { [weak self] in
                Self.log("Survey error")
                self?.delegate?.csUserSurveyError()
            },
            dismissedCallback: { [weak self] in
                Self.log("Survey dismissed")
                self?.delegate?.csUserDismissedSurvey()
            }
        )

        viewController.present(webView, animated: true)
    }

    // MARK: - Internal Logging

    static func log(_ message: String) {
        guard debugLogging else { return }
        print("[CustomerPulse] \(message)")
    }
}
