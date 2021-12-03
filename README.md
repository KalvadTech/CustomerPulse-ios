
# HappinessMeterSDK

Displays HappinessMeter surveys in Swift.
<br />
HappinessMeterSDK is a module written in Swift allowing developer to easily integrate HappinessMeter surveys in their applications.
<br /><br />

## Installation

### Cocoapods

You can add HappinessMeterSDK to your project using [Cocoapods](https://cocoapods.org/).

*If Cocoapods is not added to your project, run `pod init` in the root directory of your Xcode project.*

Simply add `pod 'HappinessMeterSDK'` to your Podfile.
Then run `pod install` in your terminal.

*If you are not familiar with Cocoapods, this will create a `[project].xcworkspace` that you will have to use from now on.*

### Manually

If you do not want to add HappinessMeterSDK using Cocoapods, you can add `HappinessMeterSDK.framework` to your project.
<br /><br />

## Usage

First, initialise the SDK using your token.

```
let hmSDK: HappinessMeterSDK = HappinessMeterSDK.init("YOUR_TOKEN_HERE")
```

Then simply display the survey for your users.

```
self.hmSDK.showSurvey(on: self, dimissAfter: 3.0)
```
### Parameters

<table>  
  <tr>
      <td>Name</td>
      <td>Type</td>
      <td>Description</td>
      <td>Default</td>
  </tr>
  <tr>
      <td>on</td>
      <td>ViewController</td>
      <td>The view controller where the survey will pop up.</td>
      <td>N/A</td>
  </tr>
  <tr>
      <td>dimissAfter</td>
      <td>Double</td>
      <td>The value in seconds after which the questionnaire will close automatically after having been successfully completed</td>
      <td>1.0</td>
  </tr>
</table>

### Delegates

To be notified on certain actions, you have to subscribe to delegates.
(If you want more information, check the [example project](https://github.com/KalvadTech/hm-ios-sdk/blob/main/example/hm.sdk.sample/hm.sdk.sample/ViewController.swift))


```
func hmSDKUserCompletedSurvey() -> void
```
*Automatically called whenever the user has successfully completed the survey*
<br /><br />

## Getting Help

- **Have a bug to report?** [Open a GitHub issue](https://github.com/KalvadTech/hm-ios-sdk/issues). If possible, include the version of the build, a full log, and a project that shows the issue.
- **Have a feature request?** [Open a GitHub issue](https://github.com/KalvadTech/hm-ios-sdk/issues). Tell us what the feature should do and why you want the feature.
<br /><br />

## License

HappinessMeterSDK is released under the MIT license.  [See LICENSE](https://github.com/KalvadTech/hm-ios-sdk/blob/main/sdk/hm.ios.sdk/LICENSE)  for details.
