import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Button } from 'react-native-paper'
// import { SplashScreen } from 'expo';

 const PayBillsScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Pay Bills Screen</Text>
        <Text>Click the Pay Button Postion your back camera 
          and scan the QR Code on the Vendor’s device</Text>
        <Button
          mode="outlined"
          color="black"
          onPress={() => {
              props.navigation.navigate('QRScanning')
          }}
        >Pay</Button>
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

export default PayBillsScreen;