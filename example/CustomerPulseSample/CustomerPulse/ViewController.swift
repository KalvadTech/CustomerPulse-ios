//
//  ViewController.swift
//  CustomerPulse.sample
//
//  Created by emilien on 10/11/2021.
//

import UIKit
import CustomerPulse

class ViewController: UIViewController, CustomerPulseDelegate {
    
    @IBOutlet weak var showSurveyButton: UIButton!
    
    let csSDK: CustomerPulse = CustomerPulse.init("LINK_OR_TOKEN_HERE")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        csSDK.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func showSurveyPressed(_ sender: Any) {
        self.csSDK.showSurvey(on: self, isDismissible: true, dimissAfter: 1000, withOptions: ["lang": "en"])
    }
    
    // MARK: - Customer Pulse Delegates
    
    /*
        This will be call automatically whenever the user has completed the survey.
    */
    func csUserCompletedSurvey() {
        print("User successfully completed the survey")
    }
}
