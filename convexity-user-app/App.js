
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { AppLoading } from 'expo';
import { NavigationContainer } from '@react-navigation/native';

// import SplashScreen from './screens/SplashScreen'
import AppNavigation from './navigation'

export default function App() {
 
  return (
      <AppNavigation />
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 50,
    justifyContent: 'center',
    alignItems: 'center'
  },
});
