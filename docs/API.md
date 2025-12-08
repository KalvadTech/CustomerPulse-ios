# CustomerPulse iOS SDK - API Reference

Complete API documentation for CustomerPulse iOS SDK v2.0.0.

## Table of Contents

- [CustomerPulse](#customerpulse)
  - [Static Properties](#static-properties)
  - [Instance Properties](#instance-properties)
  - [Initialization](#initialization)
  - [Methods](#methods)
- [CustomerPulse.Environment](#customerpulseenvironment)
- [CustomerPulseDelegate](#customerpulsedelegate)

---

## CustomerPulse

The main class for displaying CustomerPulse surveys.

```swift
public class CustomerPulse
```

### Static Properties

#### environment

The current environment configuration. Set this before calling `showSurvey()`.

```swift
public static var environment: Environment = .production
```

**Type:** `CustomerPulse.Environment`

**Default:** `.production`

**Example:**
```swift
// Use sandbox for testing
CustomerPulse.environment = .sandbox

// Use production for release
CustomerPulse.environment = .production
```

---

#### debugLogging

Enable or disable debug logging to the console.

```swift
public static var debugLogging: Bool = false
```

**Type:** `Bool`

**Default:** `false`

**Example:**
```swift
// Enable debug logging
CustomerPulse.debugLogging = true
```

**Console Output:**
```
[CustomerPulse] SDK initialized with appId: APP_ID
[CustomerPulse] Environment: sandbox
[CustomerPulse] Loading survey: https://sandboxsurvey.customerpulse.gov.ae/TOKEN
[CustomerPulse] Options: ["lang": "en"]
[CustomerPulse] Survey completed
```

---

### Instance Properties

#### delegate

Delegate for receiving survey completion events.

```swift
public weak var delegate: CustomerPulseDelegate?
```

**Type:** `CustomerPulseDelegate?`

**Example:**
```swift
let sdk = CustomerPulse(appId: "APP_ID", token: "TOKEN")
sdk.delegate = self
```

---

### Initialization

#### init(appId:token:)

Creates a new CustomerPulse instance.

```swift
public init(appId: String, token: String)
```

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `appId` | `String` | Your application ID |
| `token` | `String` | Your survey token or link |

**Example:**
```swift
let sdk = CustomerPulse(appId: "APP_ID", token: "TOKEN")
```

---

### Methods

#### showSurvey(on:isDismissible:dismissAfter:options:)

Displays the survey in a modal WKWebView.

```swift
public func showSurvey(
    on viewController: UIViewController,
    isDismissible: Bool = true,
    dismissAfter: Int = 1000,
    options: [String: Any] = [:]
)
```

**Parameters:**

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `viewController` | `UIViewController` | The view controller to present the survey from | Required |
| `isDismissible` | `Bool` | Whether the user can dismiss the survey | `true` |
| `dismissAfter` | `Int` | Milliseconds to wait before auto-dismiss after completion | `1000` |
| `options` | `[String: Any]` | Additional query parameters (e.g., language) | `[:]` |

**Example:**
```swift
// Basic usage
sdk.showSurvey(on: self)

// With all parameters
sdk.showSurvey(
    on: self,
    isDismissible: false,
    dismissAfter: 2000,
    options: ["lang": "ar"]
)
```

**Supported Options:**

| Key | Type | Description |
|-----|------|-------------|
| `lang` | `String` | Survey language (`"en"`, `"ar"`) |

---

## CustomerPulse.Environment

Enum representing the SDK environment configuration.

```swift
public enum Environment {
    case production
    case sandbox
}
```

### Cases

| Case | Base URL |
|------|----------|
| `.production` | `https://survey.customerpulse.gov.ae` |
| `.sandbox` | `https://sandboxsurvey.customerpulse.gov.ae` |

**Example:**
```swift
// Production (default)
CustomerPulse.environment = .production

// Sandbox for testing
CustomerPulse.environment = .sandbox
```

---

## CustomerPulseDelegate

Protocol for receiving survey events.

```swift
public protocol CustomerPulseDelegate: AnyObject {
    func csUserCompletedSurvey()
}
```

### Methods

#### csUserCompletedSurvey()

Called when the user successfully completes the survey.

```swift
func csUserCompletedSurvey()
```

**Example:**
```swift
class ViewController: UIViewController, CustomerPulseDelegate {

    func csUserCompletedSurvey() {
        print("Survey completed!")
        // Handle completion (e.g., show thank you message)
    }
}
```

---

## Complete Example

```swift
import UIKit
import CustomerPulse

class SurveyViewController: UIViewController, CustomerPulseDelegate {

    private let sdk = CustomerPulse(appId: "MY_APP_ID", token: "MY_TOKEN")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure SDK
        CustomerPulse.environment = .production
        CustomerPulse.debugLogging = false

        // Set delegate
        sdk.delegate = self
    }

    @IBAction func showSurveyTapped(_ sender: UIButton) {
        sdk.showSurvey(
            on: self,
            isDismissible: true,
            dismissAfter: 1500,
            options: ["lang": "en"]
        )
    }

    // MARK: - CustomerPulseDelegate

    func csUserCompletedSurvey() {
        print("User completed the survey")
        // Show thank you message, update UI, etc.
    }
}
```

---

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15+
