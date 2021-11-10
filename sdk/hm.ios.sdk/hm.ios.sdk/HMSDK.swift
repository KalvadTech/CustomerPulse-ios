//
//  HMSDK.swift
//  hm.ios.sdk
//
//  Created by emilien on 10/11/2021.
//

import Foundation
import UIKit

public class HMSDK {
    let token: String
    let baseURL: String = "https://hm.stg.pmo.gov.ae"
    
    public init(_ token: String) {
        self.token = token
    }
    
    public func showSurvey(on vc: UIViewController) -> Void {
        let webView = HMSDKWebView()
        webView.surveyURL = "\(baseURL)/\(token)"
        vc.present(webView, animated: true, completion: nil)
    }
}
