# Changelog

All notable changes to CustomerPulse iOS SDK will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-12-08

### Added
- `Environment` enum for switching between production and sandbox URLs
- `CustomerPulse.environment` static property (`.production` or `.sandbox`)
- `CustomerPulse.debugLogging` static property for console logging
- Labeled initializer parameters: `init(appId:token:)`
- Comprehensive API documentation comments

### Changed
- **BREAKING:** CocoaPods package renamed from `CustomerPulse` to `CustomerPulseSDK`
- **BREAKING:** Minimum iOS version raised from 13.0 to 15.0
- **BREAKING:** Swift version raised from 5.0 to 5.9
- **BREAKING:** Parameter `dimissAfter` renamed to `dismissAfter` (typo fix)
- **BREAKING:** Parameter `withOptions` renamed to `options`
- **BREAKING:** Initializer now uses labeled parameters
- Consolidated `showSurvey` and `showSurveyWithBaseUrl` into single method
- Moved `baseURL` logic into `Environment` enum
- Improved code organization with MARK comments

### Removed
- **BREAKING:** `showSurveyWithBaseUrl()` method (use `CustomerPulse.environment = .sandbox` instead)
- Debug print statement from CSWebView

### Fixed
- Typo in parameter name: `dimissAfter` → `dismissAfter`

## [1.3.0] - 2024-XX-XX

### Added
- `appId` parameter for SDK initialization
- `showSurveyWithBaseUrl()` method for custom/sandbox URLs

## [1.2.0] - 2024-XX-XX

### Changed
- Updated base URL configuration

## [1.1.0] - 2023-XX-XX

### Added
- `CustomerPulseDelegate` for survey completion callbacks
- `isDismissible` parameter
- `dismissTimer` parameter for auto-dismiss

## [1.0.0] - 2021-11-10

### Added
- Initial release
- `CustomerPulse` class for displaying surveys
- WKWebView-based survey presentation
- Support for custom options (language, etc.)
