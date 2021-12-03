//
//  ViewController.swift
//  hm.sdk.sample
//
//  Created by emilien on 10/11/2021.
//

import UIKit
import hm_ios_sdk

class ViewController: UIViewController, HMSDKDelegate {
    
    
    @IBOutlet weak var showSurveyButton: UIButton!
    
    let hmSDK: HappinessMeterSDK = HappinessMeterSDK.init("YOUR_TOKEN_HERE")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        hmSDK.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func showSurveyPressed(_ sender: Any) {
        self.hmSDK.showSurvey(on: self, dimissAfter: 3.0)
    }
    
    // MARK: - HMSDK Delegates
    
    /*
        This will be call automatically whenever the user has completed the survey.
    */
    func hmSDKUserCompletedSurvey() {
        print("User successfully completed the survey")
    }
}
