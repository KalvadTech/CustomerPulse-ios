//
//  CustomerPulse.swift
//  CustomerPulse
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import UIKit

public protocol CustomerPulseDelegate: AnyObject {
    /// Automatically called whenever the user has successfully completed the survey
    func csUserCompletedSurvey()
}

public class CustomerPulse {
    let appId: String
    let token: String
    let baseURL: String = "https://survey.customerpulse.gov.ae"
    
    public weak var delegate: CustomerPulseDelegate?
    
    public init(_ appId: String, _ token: String) {
        self.appId = appId
        self.token = token
    }
    
    /// Displays the survey in a WKWebView.
    ///
    /// - Parameters:
    ///   - vc: The view controller where the survey will pop up.
    ///   - isDimissible: Defines whether the survey is dismissible by the user. Default is set at true.
    ///   - dismissTimer: The value in milliseconds after which the questionnaire will close automatically after having been successfully completed. Default value is 1000ms.
    ///   - options: Dictionary to specify optional parameters to load. (eg. lang='ar/en')
    public func showSurvey(on vc: UIViewController, isDismissible: Bool = true, dimissAfter dismissTimer: Int = 1000, withOptions options:[String: Any] = [:]) -> Void {
        let webView = CSWebView.init(surveyURL: "\(baseURL)/\(token)", appId: appId, isDismissible: isDismissible, dismissTimer: dismissTimer, withOptions: options) {
            guard let sdkDelegate = self.delegate else {
                return
            }
            
            sdkDelegate.csUserCompletedSurvey()
        }
        
        vc.isModalInPresentation = true
        vc.present(webView, animated: true, completion: nil)
    } 
    
    public func showSurveyWithBaseUrl(on vc: UIViewController, isDismissible: Bool = true, baseURL: String = "https://sandboxsurvey.customerpulse.gov.ae", dimissAfter dismissTimer: Int = 1000, withOptions options:[String: Any] = [:]) -> Void {
        let webView = CSWebView.init(surveyURL: "\(baseURL)/\(token)", appId: appId, isDismissible: isDismissible, dismissTimer: dismissTimer, withOptions: options) {
            guard let sdkDelegate = self.delegate else {
                return
            }
            
            sdkDelegate.csUserCompletedSurvey()
        }
        
        vc.isModalInPresentation = true
        vc.present(webView, animated: true, completion: nil)
    }
}
