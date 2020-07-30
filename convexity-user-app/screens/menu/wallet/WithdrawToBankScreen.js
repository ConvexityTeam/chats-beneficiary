import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';

 const WithdrawToBankScreen = props => {
 
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
        <TextInput
          mode="contained" 
          label="Password"
          placeholder="Enter Token Amount to Convert"
          value={text}
          onChangeText={text => setText(text)}
        />
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

export default WithdrawToBankScreen;