//
//  ViewController.swift
//  hm.sdk.sample
//
//  Created by emilien on 10/11/2021.
//

import UIKit
import hm_ios_sdk

class ViewController: UIViewController, HappinessMeterDelegate {
    
    @IBOutlet weak var showSurveyButton: UIButton!
    
    let hmSDK: HappinessMeterSDK = HappinessMeterSDK.init("LINK_OR_TOKEN_HERE")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        hmSDK.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func showSurveyPressed(_ sender: Any) {
        self.hmSDK.showSurvey(on: self, isDismissible: true, dimissAfter: 1000, withOptions: ["lang": "en"])
    }
    
    // MARK: - HMSDK Delegates
    
    /*
        This will be call automatically whenever the user has completed the survey.
    */
    func hmSDKUserCompletedSurvey() {
        print("User successfully completed the survey")
    }
}
