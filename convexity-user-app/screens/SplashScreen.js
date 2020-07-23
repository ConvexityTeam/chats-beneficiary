import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
// import { SplashScreen } from 'expo';

 const SplashScreen = props => {
 
  return (
    <View style={styles.container}>
      <Text>Welcome to {props.title}!</Text>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default SplashScreen;