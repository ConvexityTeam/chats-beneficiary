import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
// import { SplashScreen } from 'expo';

 const SplashScreen = props => {
 
  return (
    <View style={styles.container}>
      <Text>Sign Up!</Text>
      <Button title="UserTerms" onPress={() => {
          props.navigation.navigate('UserTerms')
      }} />
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
});

export default SplashScreen;