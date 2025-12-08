<p align="center">
  <h1 align="center">CustomerPulse iOS SDK</h1>
  <p align="center">
    Easily integrate CustomerPulse surveys into your iOS applications
    <br />
    <a href="docs/API.md"><strong>Explore the API docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/KalvadTech/CustomerPulse-ios/issues">Report Bug</a>
    ·
    <a href="https://github.com/KalvadTech/CustomerPulse-ios/issues">Request Feature</a>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2015.0+-blue.svg" alt="Platform iOS 15.0+" />
  <img src="https://img.shields.io/badge/Swift-5.9+-orange.svg" alt="Swift 5.9+" />
  <img src="https://img.shields.io/badge/CocoaPods-compatible-green.svg" alt="CocoaPods compatible" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License MIT" />
  <img src="https://img.shields.io/badge/Version-2.0.0-brightgreen.svg" alt="Version 2.0.0" />
</p>

---

## Overview

CustomerPulse iOS SDK provides a simple and elegant way to display customer satisfaction surveys in your iOS applications. With just a few lines of code, you can gather valuable feedback from your users.

### Features

- 🚀 **Simple Integration** - Get started with just 3 lines of code
- 🔒 **Secure** - All communications over HTTPS
- 🌍 **Multi-language Support** - Built-in support for English and Arabic
- 🎨 **Native Experience** - Surveys displayed in a native WKWebView
- 🔧 **Configurable** - Environment switching, dismissal control, auto-close timing
- 📊 **Debug Mode** - Built-in logging for development

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Migration Guide](#migration-guide)
- [Example Project](#example-project)
- [Support](#support)

---

## Requirements

| Requirement | Minimum Version |
|-------------|-----------------|
| iOS | 15.0+ |
| Swift | 5.9+ |
| Xcode | 15.0+ |

---

## Installation

Choose **one** of the following installation methods:

---

### Option 1: CocoaPods (Recommended)

Add the following to your `Podfile`:

```ruby
pod 'CustomerPulseSDK', '~> 2.0'
```

Then run:

```bash
pod install
```

---

### Option 2: Swift Package Manager

In Xcode, go to **File → Add Package Dependencies** and enter:

```
https://github.com/KalvadTech/CustomerPulse-ios.git
```

Or add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/KalvadTech/CustomerPulse-ios.git", from: "2.0.0")
]
```

---

### Option 3: Manual Installation

1. Download `CustomerPulse.xcframework` from the [Releases](https://github.com/KalvadTech/CustomerPulse-ios/releases) page
2. Drag and drop it into your Xcode project
3. Ensure it's added to **"Frameworks, Libraries, and Embedded Content"** with **"Embed & Sign"**

---

## Quick Start

### 1. Import the SDK

```swift
import CustomerPulse
```

### 2. Initialize

```swift
let pulse = CustomerPulse(appId: "YOUR_APP_ID", token: "YOUR_TOKEN")
```

### 3. Show Survey

```swift
pulse.showSurvey(on: self)
```

That's it! 🎉

---

## Configuration

### Environment

Switch between production and sandbox environments:

```swift
// Production (default)
CustomerPulse.environment = .production

// Sandbox (for testing)
CustomerPulse.environment = .sandbox
```

### Debug Logging

Enable console logging during development:

```swift
CustomerPulse.debugLogging = true
```

**Output:**
```
[CustomerPulse] SDK initialized with appId: YOUR_APP_ID
[CustomerPulse] Environment: sandbox
[CustomerPulse] Loading survey: https://sandboxsurvey.customerpulse.gov.ae/TOKEN
[CustomerPulse] Survey completed
```

### Survey Options

Customize survey behavior:

```swift
pulse.showSurvey(
    on: self,
    isDismissible: true,      // Allow user to dismiss
    dismissAfter: 2000,       // Auto-close after 2 seconds
    options: ["lang": "ar"]   // Arabic language
)
```

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `on` | `UIViewController` | Presenting view controller | Required |
| `isDismissible` | `Bool` | User can swipe to dismiss | `true` |
| `dismissAfter` | `Int` | Auto-dismiss delay (ms) | `1000` |
| `options` | `[String: Any]` | Additional parameters | `[:]` |

### Delegate

Handle survey completion events:

```swift
class MyViewController: UIViewController, CustomerPulseDelegate {

    let pulse = CustomerPulse(appId: "APP_ID", token: "TOKEN")

    override func viewDidLoad() {
        super.viewDidLoad()
        pulse.delegate = self
    }

    func csUserCompletedSurvey() {
        // User finished the survey
        print("Thank you for your feedback!")
    }
}
```

---

## API Reference

For complete API documentation, see [docs/API.md](docs/API.md).

### Quick Reference

```swift
// Static Properties
CustomerPulse.environment: Environment     // .production or .sandbox
CustomerPulse.debugLogging: Bool           // Enable/disable logging

// Instance Properties
pulse.delegate: CustomerPulseDelegate?     // Completion callback delegate

// Methods
pulse.showSurvey(on:isDismissible:dismissAfter:options:)
```

---

## Migration Guide

### Upgrading from v1.x to v2.0

#### CocoaPods Name Change

The CocoaPods package has been renamed from `CustomerPulse` to `CustomerPulseSDK`.

**Update your Podfile:**
```ruby
# Old (v1.x)
pod 'CustomerPulse'

# New (v2.0)
pod 'CustomerPulseSDK', '~> 2.0'
```

> **Note:** The Swift module name remains `CustomerPulse`, so your `import CustomerPulse` statements stay the same.

#### Breaking Changes

| v1.x | v2.0 |
|------|------|
| `pod 'CustomerPulse'` | `pod 'CustomerPulseSDK'` |
| `CustomerPulse("id", "token")` | `CustomerPulse(appId: "id", token: "token")` |
| `dimissAfter:` | `dismissAfter:` |
| `withOptions:` | `options:` |
| `showSurveyWithBaseUrl(...)` | `CustomerPulse.environment = .sandbox` |
| iOS 13.0+ | iOS 15.0+ |

#### Before (v1.x)

```swift
let sdk = CustomerPulse.init("APP_ID", "TOKEN")
sdk.showSurvey(on: self, dimissAfter: 1000, withOptions: ["lang": "en"])

// Sandbox
sdk.showSurveyWithBaseUrl(on: self, baseURL: "https://sandbox...", dimissAfter: 1000)
```

#### After (v2.0)

```swift
let sdk = CustomerPulse(appId: "APP_ID", token: "TOKEN")
sdk.showSurvey(on: self, dismissAfter: 1000, options: ["lang": "en"])

// Sandbox
CustomerPulse.environment = .sandbox
sdk.showSurvey(on: self, dismissAfter: 1000)
```

---

## Example Project

Check out the example project in the [`example/`](example/) directory for a complete implementation.

```bash
cd example/CustomerPulseSample
open CustomerPulseSample.xcworkspace
```

---

## Support

- 📖 **Documentation**: [API Reference](docs/API.md)
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/KalvadTech/CustomerPulse-ios/issues)
- 💡 **Feature Requests**: [GitHub Issues](https://github.com/KalvadTech/CustomerPulse-ios/issues)
- 📧 **Email**: mohamed@kalvad.com

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

---

<p align="center">
  Made with ❤️ by <a href="https://kalvad.com">Kalvad Tech</a>
</p>
