//
//  HMSDK.swift
//  hm.ios.sdk
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import UIKit

public protocol HappinessMeterDelegate: AnyObject {
    /// Automatically called whenever the user has successfully completed the survey
    func hmSDKUserCompletedSurvey()
}

public class HappinessMeterSDK {
    let token: String
    let baseURL: String = "https://survey.customerpulse.gov.ae"
    
    public weak var delegate: HappinessMeterDelegate?
    
    public init(_ token: String) {
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
        let webView = HMSDKWebView.init(surveyURL: "\(baseURL)/\(token)", isDismissible: isDismissible, dismissTimer: dismissTimer, withOptions: options) {
            guard let hmSdkDelegate = self.delegate else {
                return
            }
            
            hmSdkDelegate.hmSDKUserCompletedSurvey()
        }
        
        vc.isModalInPresentation = true
        vc.present(webView, animated: true, completion: nil)
    }
}
