# react-native-onfido-auth-sdk

The Onfido Authentication SDK provides a set of screens for React Native applications to capture 3D face scans for the purpose of identity authentication.

## Installation

```sh
yarn add react-native-onfido-auth-sdk
```

## Usage

```js
import { OnfidoAuth } from 'react-native-onfido-auth-sdk';
// ...
OnfidoAuth.start({ sdkToken: 'sdkToken' })
  .then(/* ... */)
  .catch(/* ... */);
```

## UI Customization

### iOS

T.B.D.

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
