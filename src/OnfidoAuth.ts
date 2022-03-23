import { NativeModules, Platform } from 'react-native';
import type { OnfidoAuthConfig } from './types';

const LINKING_ERROR =
  `The package 'react-native-onfido-auth-sdk' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const OnfidoAuthSdk = NativeModules.OnfidoAuthSdk
  ? NativeModules.OnfidoAuthSdk
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

const OnfidoAuth = {
  start(config: OnfidoAuthConfig) {
    if (!config) {
      return configError('config is missing');
    }

    if (!config.sdkToken) {
      return configError('sdkToken is missing');
    }

    if (
      typeof config.sdkToken !== 'string' ||
      !config.sdkToken.match(
        /^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$/
      )
    ) {
      return configError('sdkToken is not a valid jwt');
    }

    return OnfidoAuthSdk.start(config);
  },
};

const configError = (message: string) => {
  return Promise.reject(new Error(message));
};

export default OnfidoAuth;
