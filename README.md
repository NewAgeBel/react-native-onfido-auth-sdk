# react-native-onfido-auth-sdk

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
  - [1. Creating the SDK configuration](#1-creating-the-sdk-configuration)
  - [2. Parameter details](#2-parameter-details)
  - [3. Success Response](#3-success-response)
  - [4. Failure Response](#4-failure-response)
- [UI Customization](#ui-customization)
  - [iOS](#ui-customization-ios)
  - [Android](#ui-customization-android)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Onfido Authentication SDK provides a set of screens for React Native applications to capture 3D face scans for the purpose of identity authentication.

## Installation

```sh
yarn add react-native-onfido-auth-sdk
```

## Usage

You can launch the app with a call to `OnfidoAuth.start`.

```js
import { OnfidoAuth } from 'react-native-onfido-auth-sdk';
// ...
OnfidoAuth.start({ sdkToken: 'sdkToken' })
  .then(/* ... */)
  .catch(/* ... */);
```

### 1. Creating the SDK configuration

Once you have an added the SDK as a dependency and you have a SDK token, you can configure the SDK:

Example configuration:

```js
config = {
  sdkToken: 'EXAMPLE-TOKEN-123',
  retryCount: 2,
}
```

### 2. Parameter details

* **`sdkToken`**: Required.  This is the JWT sdk token obtained by making a call to the SDK token API.
* **`retryCount`**: Optional. This value is used to set the number of repeat attempts a user can do after the first unsuccessful try.

### 3. Success Response

Success is when the user has reached the end of the flow. The result has the `verified`, `uuid` and `token` properties. If authentication was successful, `verified` will be `true` and `token` will be the JWT. This JWT token can be used to validate the response.

Example:

```js
{
  token: 'EXAMPLE-TOKEN-456',
  uuid: 'uuid',
  verified: true,
}
```

### 4. Failure Response

The SDK will reject the promise any time the OnfidoAuth SDK exits without a success.  Error messages are not in a presentable format to the end user and are not localised.

## UI Customization

### iOS

You can customize the iOS UI by adding a `customization.ios.json` file to your project at the same level as your `node_modules` directory. The file should contain a single json object with the desired keys and values.  For example:

```json
{
  "onfidoPrimaryTextColor": "",
  "onfidoPrimaryTextDynamicDimmingColor": "",

  "onfidoPrimaryButtonColor": "#4BC0B1",
  "onfidoPrimaryButtonDynamicDimmingColor": "",
  "onfidoPrimaryButtonPressedColor": "#2EAC9C",
  "onfidoPrimaryButtonDisabledColor": "",
  "onfidoPrimaryButtonDisabledDynamicDimmingColor": "",
  "onfidoPrimaryButtonTextColor": "#FFFFFF",
  "onfidoPrimaryButtonTextDynamicDimmingColor": "",
  "onfidoPrimaryButtonTextPressedColor": "",
  "onfidoPrimaryButtonTextDisabledColor": "",
  "onfidoPrimaryButtonTextDisabledDynamicDimmingColor": "",

  "onfidoSecondaryButtonPressedColor": "",
  "onfidoDualSpinnerColor": "",
  "onfidoRetryScreenOvalStrokeColor": "",
  "onfidoUploadProgressFillColor": "",

  "onfidoButtonCornerRadius": 24,

  "onfidoFontRegular": "",
  "onfidoFontMedium": "", 
  "onfidoFontBold": ""
}

```

Once you've added the `customization.ios.json` to your project, you should add `customization.ios.json` file to your xcode project as bundle resource. You can create symbolic link (rather than copy paste) to prevent redundancy. Then when running on an iOS device the values will be picked up dynamically at runtime.

Below is a description of all available keys:

| Color     |    Description    |
| -----|-------|
| `onfidoPrimaryTextColor`     |    Color of most text    |
| `onfidoPrimaryTextDynamicDimmingColor`     |    Color of text in Dynamic Dimming mode<br/><br/>Dynamic Dimming mode is automatically enabled in certain lighting conditions and will include UI differences such as the background turning black    |
| `onfidoPrimaryButtonColor`     |    Background color of buttons    |
| `onfidoPrimaryButtonDynamicDimmingColor`     |    Background color of buttons in Dynamic Dimming mode<br/><br/>Dynamic Dimming mode is automatically enabled in certain lighting conditions and will include UI differences such as the background turning black    |
| `onfidoPrimaryButtonPressedColor`     |    Background color of buttons while being pressed    |
| `onfidoPrimaryButtonDisabledColor`     |    Background color of buttons that are disabled    |
| `onfidoPrimaryButtonDisabledDynamicDimmingColor`     |    Background color of buttons that are disabled in Dynamic Dimming mode<br/><br/>Dynamic Dimming mode is automatically enabled in certain lighting conditions and will include UI differences such as the background turning black    |
| `onfidoPrimaryButtonTextColor`     |    Color of text in buttons    |
| `onfidoPrimaryButtonTextDynamicDimmingColor`     |    Color of text in buttons in Dynamic Dimming mode<br/><br/>Dynamic Dimming mode is automatically enabled in certain lighting conditions and will include UI differences such as the background turning black    |
| `onfidoPrimaryButtonTextPressedColor`     |    Color of text in buttons while being pressed    |
| `onfidoPrimaryButtonTextDisabledColor`     |    Color of text in buttons that are disabled    |
| `onfidoPrimaryButtonTextDisabledDynamicDimmingColor`     |    Color of text in buttons that are disabled in Dynamic Dimming mode<br/><br/>Dynamic Dimming mode is automatically enabled in certain lighting conditions and will include UI differences such as the background turning black    |
| `onfidoSecondaryButtonPressedColor`     |    Background color of secondary button (currently this is only the “Do not accept” button in the optional consent screen)    |
| `onfidoDualSpinnerColor`     |    Color of dual spinner rotating around selfie preview    |
| `onfidoRetryScreenOvalStrokeColor`     |     Stroke color of oval on ideal selfie image in retry screen   |
| `onfidoUploadProgressFillColor`     |    Color of completed portion of upload progress bar    |
| `onfidoButtonCornerRadius`     |    Corner radius of buttons (should be set to 40 maximum, otherwise will not work on some buttons)    |
| `onfidoFontRegular`     |    Name of font to use on regular text    |
| `onfidoFontMedium`     |    Name of font to use on medium text    |
| `onfidoFontBold`     |    Name of font to use on bold text    |

### Android
You can customize the Android UI by adding a `customization.android.json` file to your project at the same level as your `node_modules` directory. The file should contain a single json object with the desired keys and values.  For example:

```json
{
  "onfidoColorPrimaryDark": "",
  "onfidoTextColorPrimary": "",

  "onfidoPrimaryButtonTextColor": "#FFFFFF",
  "onfidoPrimaryButtonDisabledTextColor": "#FFFFFF",
  "onfidoPrimaryButtonColor": "#4BC0B1",
  "onfidoPrimaryButtonColorPressed": "#2EAC9C",
  "onfidoPrimaryButtonColorDisabled": "",

  "onfidoSecondaryButtonColor": "",
  "onfidoSecondaryButtonColorPressed": "",

  "onfidoColorAccent": "#4BC0B1",
  "onfidoAuthDualSpinnerColor": "",
  "onfidoAuthRetryScreenOvalStrokeColor": "",
  "onfidoUploadProgressFillColor": "",

  "onfidoPrimaryButtonColorDynamicDimmingMode": "",
  "onfidoPrimaryButtonColorPressedDynamicDimmingMode": "",
  "onfidoPrimaryButtonColorDisabledDynamicDimmingMode": "",

  "onfidoButtonCornerRadius": 32
}

```
Below is a description of all available keys:

| Color     |    Description    |
| -----|-------|
| `onfidoColorPrimaryDark`     |    Color of the status bar    |
| `onfidoColorAccent`     |    Default color of certain UI elements such as dual spinner around selfie preview, oval around images in retry screen, and upload progress color. These elements can also be customised individually    |
| `onfidoTextColorPrimary`     |    Primary color of the texts used throughout the screens    |
| `onfidoPrimaryButtonTextColor`     |    Color of the text inside the primary action buttons    |
| `onfidoPrimaryButtonDisabledTextColor`     |    Color of the text inside the primary action buttons when disabled    |
| `onfidoPrimaryButtonColor`     |    Background color of the primary action buttons    |
| `onfidoPrimaryButtonColorPressed`     |    Background color of the primary action buttons when pressed    |
| `onfidoPrimaryButtonColorDisabled`     |    Background color of the primary action buttons when disabled    |
| `onfidoSecondaryButtonColor`     |    Background color of the secondary action buttons    |
| `onfidoSecondaryButtonColorPressed`     |    Background color of the secondary action buttons when pressed    |
| `onfidoAuthDualSpinnerColor`     |    Color of dual spinner rotating around selfie preview. This will override the default color provided by `onfidoColorAccent`    |
| `onfidoAuthRetryScreenOvalStrokeColor`     |    Stroke color of oval on ideal selfie image in retry screen. This will override the default color provided by `onfidoColorAccent`    |
| `onfidoUploadProgressFillColor`     |    Fill color of the uploading progress indicator bar. This will override the default color provided by `onfidoColorAccent`    |
| `onfidoPrimaryButtonColorDynamicDimmingMode`     |    Background color of the primary action buttons in dark mode    |
| `onfidoPrimaryButtonColorPressedDynamicDimmingMode`     |     Background color of the primary action buttons when pressed in dark mode   |
| `onfidoPrimaryButtonColorDisabledDynamicDimmingMode`     |    Background color of the primary action buttons when disabledin dark mode    |


You can customize the corner radius of all buttons by providing `onfidoButtonCornerRadius` in your `customization.android.json` resource file.

Once you've added the customization.android.json to your project, you should run the following command at the same level of your `node_modules` directory.

```shell
$ npm --prefix node_modules/react-native-onfido-auth-sdk/ run customizeAndroid
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
