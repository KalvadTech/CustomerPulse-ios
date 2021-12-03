//
//  HMSDK.swift
//  hm.ios.sdk
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import UIKit

public protocol HMSDKDelegate: AnyObject {
    /// Automatically called whenever the user has successfully completed the survey
    func hmSDKUserCompletedSurvey()
}

public class HMSDK {
    let token: String
    let baseURL: String = "https://hm.stg.pmo.gov.ae"
    
    public weak var delegate: HMSDKDelegate?
    
    public init(_ token: String) {
        self.token = token
    }
    
    /// Displays the survey in a WKWebView.
    ///
    /// - Parameters:
    ///   - vc: The view controller where the survey will pop up.
    ///   - dismissTimer: The value in seconds after which the questionnaire will close automatically after having been successfully completed
    public func showSurvey(on vc: UIViewController, dimissAfter dismissTimer: Double) -> Void {
        let webView = HMSDKWebView.init(surveyURL: "\(baseURL)/\(token)", dismissTimer: dismissTimer) {
            guard let hmSdkDelegate = self.delegate else {
                return
            }
            
            hmSdkDelegate.hmSDKUserCompletedSurvey()
        }
        
        vc.present(webView, animated: true, completion: nil)
    }
}
