import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
// import { SplashScreen } from 'expo';

 const LoginScreen = props => {
 
  return (
    <View style={styles.container}>
      <Text>Login!</Text>
      <Button title="Dashboard" onPress={() => {
          props.navigation.navigate('Dashboard')
      }} />

      <Button title="SignUp" onPress={() => {
          props.navigation.navigate('SignUp')
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

export default LoginScreen;