//
//  ViewController.swift
//  hm.sdk.sample
//
//  Created by emilien on 10/11/2021.
//

import UIKit
import hm_ios_sdk

class ViewController: UIViewController {
    
    @IBOutlet weak var showSurveyButton: UIButton!
    
    let hmSDK: HMSDK = HMSDK.init("M")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
    }

    @IBAction func showSurveyPressed(_ sender: Any) {
        hmSDK.showSurvey(on: self)
    }
}
