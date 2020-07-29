
import React, { useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Provider as PaperProvider } from 'react-native-paper';
import { AppLoading } from 'expo';
import * as Font from 'expo-font';


import AppNavigation from './navigation'


const fetchFonts = () => {
  return Font.loadAsync({
    'inter-black': require('./assets/fonts/Inter-Black.ttf'),
    'inter-bold': require('./assets/fonts/Inter-Bold.ttf'),
    'inter-regular': require('./assets/fonts/Inter-Regular.ttf')
  })
}

export default function App() {

  const  [fontLoaded, setFontLoaded ] = useState(false)

  if(!fontLoaded) {
    return (
      <AppLoading 
        startAsync={fetchFonts}
        onFinish={() => setFontLoaded(true)}
      />
    )
  }

 
  return (
    <PaperProvider>
      <AppNavigation />
    </PaperProvider>
  );
}