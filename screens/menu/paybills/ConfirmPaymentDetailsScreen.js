import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Button } from 'react-native-paper';
// import { SplashScreen } from 'expo';

 const PayBillsScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Please Verify that the Payment details are correct.</Text>
        <Text>Vendor</Text>
        <Text>Charles Mbah</Text>
        <Text>Amount</Text>
        <Text>1700 NGNT</Text>
        <Button
         onPress={() => {
            props.navigation.navigate('OTPScreen')}}
        >Confirm Payment</Button>
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