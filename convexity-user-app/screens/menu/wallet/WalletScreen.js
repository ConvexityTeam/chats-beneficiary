import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Button, TouchableRipple } from 'react-native-paper';
// import { SplashScreen } from 'expo';

 const WalletScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <View>
        <Text>Welcome Emmanuel</Text>
      </View>
      <View>
        <Text>Wallet Balance:</Text>
        <Text>15,000 NGNT</Text>
      </View>
      <View>
        <Text>Convert Token</Text>
        <Text>Withdraw Funds</Text>
      </View>
      <View>
          <TouchableRipple rippleColor="grey">
            <Button 
            mode="contained"
            color="white"
            onPress={() => {
                props.navigation.navigate('ConvertToken')
            }}>Scan To Pay</Button>
          </TouchableRipple>
        
      </View>
      <Button>Search For Vendors</Button>
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

export default WalletScreen;