
# CustomerPulse

Displays CustomerPulse surveys in Swift.
<br />
CustomerPulse is a module written in Swift allowing developer to easily integrate CustomerPulse surveys in their applications.
<br /><br />

Latest version : 1.3.0<br />
https://github.com/KalvadTech/hm-ios-sdk/releases/tag/1.3.0

## Installation

### Cocoapods

You can add CustomerPulse to your project using [Cocoapods](https://cocoapods.org/).

*If Cocoapods is not added to your project, run `pod init` in the root directory of your Xcode project.*

Simply add `pod 'CustomerPulse'` to your Podfile.
Then run `pod install` in your terminal.

*If you are not familiar with Cocoapods, this will create a `[project].xcworkspace` that you will have to use from now on.*

To import the SDK to your project

```
import CustomerPulse
```

### Manually

If you do not want to add CustomerPulse using Cocoapods, you can add `CustomerPulse.xcframework` to your project. You can find the framework in the `build` folder of the SDK.
<br /><br />

To import the SDK to your project

```
import CustomerPulse
```

## Usage

First, initialise the SDK using your token or link.

```
let csSDK: CustomerPulse = CustomerPulse.init("APP_ID", "TOKEN_OR_LINK")
```

Finally, simply display the survey for your users.

```
self.csSDK.showSurvey(on: self, isDismissible: true, dimissAfter: 1000, withOptions: ["lang": "en"])
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
      <td>isDismissible</td>
      <td>Bool</td>
      <td>Defines whether the survey is dismissible by the user.</td>
      <td>true</td>
  </tr>
  <tr>
      <td>dimissAfter</td>
      <td>Int</td>
      <td>The value in milliseconds after which the questionnaire will close automatically after having been successfully completed.</td>
      <td>1000</td>
  </tr>
  <tr>
      <td>options</td>
      <td>[String: Any]</td>
      <td>Dictionary to specify optional parameters to load. (eg. lang='ar/en')</td>
      <td>[:]</td>
  </tr>
</table>

### Delegates

To be notified on certain actions, you have to subscribe to delegates.
(If you want more information, check the [example project](https://github.com/KalvadTech/CustomerPulse-ios/blob/main/example/CustomerPulseSample/CustomerPulse/ViewController.swift))


```
func csUserCompletedSurvey() -> void
```
*Automatically called whenever the user has successfully completed the survey*
<br /><br />

## Getting Help

- **Have a bug to report?** [Open a GitHub issue](https://github.com/KalvadTech/CustomerPulse-ios/issues). If possible, include the version of the build, a full log, and a project that shows the issue.
- **Have a feature request?** [Open a GitHub issue](https://github.com/KalvadTech/CustomerPulse-ios/issues). Tell us what the feature should do and why you want the feature.
<br /><br />

## License

CustomerPulse is released under the MIT license. [See LICENSE](https://github.com/KalvadTech/CustomerPulse-ios/blob/main/sdk/CustomerPulse/LICENSE) for details.
