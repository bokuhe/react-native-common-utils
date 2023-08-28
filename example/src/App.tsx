import * as React from 'react';

import { StyleSheet, View, Text, Button } from 'react-native';
import { AppNavigator } from '@sleiv/react-native-common-utils';

export default function App() {
  const backToPreviousApp = async () => {
    AppNavigator.backToPreviousApp().catch((e) => {
      console.error(e);
    });
  };

  const exitApp = async () => {
    AppNavigator.exitApp().catch((e) => {
      console.error(e);
    });
  };

  return (
    <View style={styles.container}>
      <Text>{`AppNavigator`}</Text>
      <Button title="Back to Previous App" onPress={backToPreviousApp} />
      <Button title="Exit App" onPress={exitApp} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
