import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';
import Color from '../../../constants/colors';
 const OTPConvertScreen = props => {
 
  return (
    <View style={styles.container}>
      <View>
        <Text>Please enter the OTP sent to your phone number</Text>
      </View>
      <View style={styles.textInput}>
        <TextInput
          mode="outlined"
          label="Enter OTP" 
          placeholder="Enter OTP"
          // value={text}
          // onChangeText={text => setText(text)}
        />
      </View>
      <Button style={{marginTop: 50, padding: 5,}}
      mode="contained"
      color={Color.purple}
      onPress={() => {
          props.navigation.navigate('ConvertTokenSuccess')
      }}
      >Submit</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    paddingTop: 20
  },
  textInput: {
    paddingTop: 100,
  },
});

export default OTPConvertScreen;