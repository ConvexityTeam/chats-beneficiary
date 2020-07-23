import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

import SplashScreen from './screens/SplashScreen'

export default function App() {
 
  return (
    <View style={styles.container}>
      <SplashScreen title={'Convexity'}/>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 50
  },
});
