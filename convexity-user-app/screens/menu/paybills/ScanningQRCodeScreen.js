import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
// import { SplashScreen } from 'expo';

 const PayBillsScreen = props => {
 
  return (
    <View style={styles.container}>
        <Text>Wait... Scanning</Text>
        <Button title="click" onPress={() => {
          props.navigation.navigate('ConfirmPaymentDetails')
      }} />
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