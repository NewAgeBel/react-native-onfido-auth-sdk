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

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
