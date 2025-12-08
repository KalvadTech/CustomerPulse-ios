//
//  ViewController.swift
//  CustomerPulse.sample
//
//  Created by emilien on 10/11/2021.
//
//  Example implementation of CustomerPulse SDK integration.
//  This demonstrates how to:
//  - Initialize the SDK with app ID and token
//  - Configure environment (production/sandbox)
//  - Enable debug logging
//  - Display surveys and handle completion callbacks
//

import UIKit
import CustomerPulse

/// Example view controller demonstrating CustomerPulse SDK integration.
///
/// This class shows the recommended pattern for integrating CustomerPulse:
/// 1. Create a `CustomerPulse` instance with your credentials
/// 2. Configure the environment and logging in `viewDidLoad`
/// 3. Set the delegate to receive completion callbacks
/// 4. Call `showSurvey()` when you want to display the survey
class ViewController: UIViewController, CustomerPulseDelegate {

    // MARK: - IBOutlets

    /// Button that triggers the survey display.
    @IBOutlet weak var showSurveyButton: UIButton!

    // MARK: - Properties

    /// CustomerPulse SDK instance.
    ///
    /// Initialize with your app ID and survey token/link.
    /// - Note: Replace "APP_ID" and token with your actual credentials.
    private let csSDK = CustomerPulse(appId: "APP_ID", token: "v2/F/t0/")

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSDK()
    }

    // MARK: - Configuration

    /// Configures the view's appearance.
    private func configureUI() {
        view.backgroundColor = .white
    }

    /// Configures the CustomerPulse SDK settings.
    ///
    /// This method sets up:
    /// - Environment: `.sandbox` for testing, `.production` for release
    /// - Debug logging: Enable to see SDK activity in console
    /// - Delegate: Set to receive survey completion callbacks
    private func configureSDK() {
        // Use sandbox environment for testing
        // Change to .production for release builds
        CustomerPulse.environment = .sandbox

        // Enable debug logging to see SDK activity in console
        // Disable in production for cleaner logs
        CustomerPulse.debugLogging = true

        // Set delegate to receive completion callbacks
        csSDK.delegate = self
    }

    // MARK: - IBActions

    /// Called when the user taps the "Show Survey" button.
    ///
    /// Displays the CustomerPulse survey in a modal web view.
    /// - Parameter sender: The button that triggered this action.
    @IBAction func showSurveyPressed(_ sender: Any) {
        csSDK.showSurvey(
            on: self,
            isDismissible: true,
            dismissAfter: 1000,
            options: ["lang": "en"]
        )
    }

    // MARK: - CustomerPulseDelegate

    /// Called when the user successfully completes the survey.
    ///
    /// Use this callback to:
    /// - Thank the user for their feedback
    /// - Update your UI
    /// - Track analytics events
    /// - Perform any post-survey logic
    func csUserCompletedSurvey() {
        print("User successfully completed the survey")

        // Example: Show a thank you alert
        // let alert = UIAlertController(
        //     title: "Thank You!",
        //     message: "We appreciate your feedback.",
        //     preferredStyle: .alert
        // )
        // alert.addAction(UIAlertAction(title: "OK", style: .default))
        // present(alert, animated: true)
    }
}
