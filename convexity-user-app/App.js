
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Provider as PaperProvider } from 'react-native-paper';
import { AppLoading } from 'expo';
import { NavigationContainer } from '@react-navigation/native';

// import SplashScreen from './screens/SplashScreen'
import AppNavigation from './navigation'

import theme from './constants/PaperTheme'

export default function App() {
 
  return (
    <PaperProvider>
      <AppNavigation />
    </PaperProvider>
  );
}

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     paddingTop: 50,
//     justifyContent: 'center',
//     alignItems: 'center'
//   },
// });
