import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';

const SplashScreen = props => {
 
  return (
    <View style={styles.container}>
      <Text>Welcome to SplashScreen</Text>
      <Button title="Login" onPress={() => {
         props.navigation.navigate('Login')
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