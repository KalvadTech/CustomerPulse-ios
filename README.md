
# CustomerPulse

Displays CustomerPulse surveys in Swift.

CustomerPulse is a module written in Swift allowing developers to easily integrate CustomerPulse surveys in their applications.

**Latest version:** 2.0.0

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15+

## Installation

### CocoaPods

You can add CustomerPulse to your project using [CocoaPods](https://cocoapods.org/).

*If CocoaPods is not added to your project, run `pod init` in the root directory of your Xcode project.*

Simply add `pod 'CustomerPulse'` to your Podfile.
Then run `pod install` in your terminal.

*If you are not familiar with CocoaPods, this will create a `[project].xcworkspace` that you will have to use from now on.*

To import the SDK to your project:

```swift
import CustomerPulse
```

### Manually

If you do not want to add CustomerPulse using CocoaPods, you can add `CustomerPulse.xcframework` to your project. You can find the framework in the `build` folder of the SDK.

To import the SDK to your project:

```swift
import CustomerPulse
```

## Usage

First, initialize the SDK using your app ID and token:

```swift
let csSDK = CustomerPulse(appId: "APP_ID", token: "TOKEN_OR_LINK")
```

Then, display the survey for your users:

```swift
csSDK.showSurvey(on: self, isDismissible: true, dismissAfter: 1000, options: ["lang": "en"])
```

### Environment Configuration

By default, the SDK uses the production environment. To use the sandbox environment for testing:

```swift
// Set before showing survey
CustomerPulse.environment = .sandbox

// Then show the survey as usual
csSDK.showSurvey(on: self)
```

To switch back to production:

```swift
CustomerPulse.environment = .production
```

### Parameters

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `on` | `UIViewController` | The view controller where the survey will be presented. | N/A |
| `isDismissible` | `Bool` | Whether the survey can be dismissed by the user. | `true` |
| `dismissAfter` | `Int` | Delay in milliseconds before auto-dismiss after completion. | `1000` |
| `options` | `[String: Any]` | Dictionary of optional parameters (e.g., `["lang": "ar"]`). | `[:]` |

### Delegates

To be notified on certain actions, subscribe to the delegate:

```swift
class ViewController: UIViewController, CustomerPulseDelegate {

    let csSDK = CustomerPulse(appId: "APP_ID", token: "TOKEN")

    override func viewDidLoad() {
        super.viewDidLoad()
        csSDK.delegate = self
    }

    // Called when the user has successfully completed the survey
    func csUserCompletedSurvey() {
        print("User completed the survey")
    }
}
```

## Migrating from v1.x to v2.0

### Breaking Changes

| v1.x | v2.0 |
|------|------|
| `CustomerPulse.init("appId", "token")` | `CustomerPulse(appId: "appId", token: "token")` |
| `dimissAfter:` | `dismissAfter:` |
| `withOptions:` | `options:` |
| `showSurveyWithBaseUrl(...)` | `CustomerPulse.environment = .sandbox` |
| iOS 13.0+ | iOS 15.0+ |

### Migration Example

**Before (v1.x):**
```swift
let csSDK = CustomerPulse.init("APP_ID", "TOKEN")
csSDK.showSurvey(on: self, dimissAfter: 1000, withOptions: ["lang": "en"])

// For sandbox
csSDK.showSurveyWithBaseUrl(on: self, baseURL: "https://sandboxsurvey.customerpulse.gov.ae", dimissAfter: 1000, withOptions: ["lang": "en"])
```

**After (v2.0):**
```swift
let csSDK = CustomerPulse(appId: "APP_ID", token: "TOKEN")
csSDK.showSurvey(on: self, dismissAfter: 1000, options: ["lang": "en"])

// For sandbox
CustomerPulse.environment = .sandbox
csSDK.showSurvey(on: self, dismissAfter: 1000, options: ["lang": "en"])
```

## Getting Help

- **Have a bug to report?** [Open a GitHub issue](https://github.com/KalvadTech/CustomerPulse-ios/issues). If possible, include the version of the build, a full log, and a project that shows the issue.
- **Have a feature request?** [Open a GitHub issue](https://github.com/KalvadTech/CustomerPulse-ios/issues). Tell us what the feature should do and why you want the feature.

## License

CustomerPulse is released under the MIT license. [See LICENSE](https://github.com/KalvadTech/CustomerPulse-ios/blob/main/sdk/CustomerPulseSDK/LICENSE) for details.
