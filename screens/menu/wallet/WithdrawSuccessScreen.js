import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';

 const OTPConvertScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <View>
        <Text>Transaction successfull!</Text>
      </View>
      
      <Button 
      mode="contained"
      icon="reminder"
      color="white"
      onPress={() => {
          props.navigation.navigate('Dashboard')
      }}
      >Return Home</Button>
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

export default OTPConvertScreen;