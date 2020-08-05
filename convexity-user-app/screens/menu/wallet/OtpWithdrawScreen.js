import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';

 const OTPWithdrawScreen = props => {
 
  return (
    <View style={styles.container}>
      <View>
        <Text>Please enter the OTP sent to your phone number</Text>
      </View>
      <View>
        <TextInput
          mode="contained" 
          label="Password"
          placeholder="Enter Token Amount to Convert"
          // value={text}
          // onChangeText={text => setText(text)}
        />
      </View>
      <Button
        onPress={() => {
          props.navigation.navigate('WithdrawToBankSuccess')
      }}
      >Submit</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
  },
});

export default OTPWithdrawScreen;