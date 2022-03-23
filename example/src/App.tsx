import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { OnfidoAuth } from 'react-native-onfido-auth-sdk';

export default function App() {
  React.useEffect(() => {
    OnfidoAuth.start({ sdkToken: 'sdkToken' })
      .then(console.log)
      .catch(console.log);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Onfido Auth Example</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
