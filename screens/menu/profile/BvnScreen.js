import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';

 const OTPConvertScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center' }}>
      <View>
        <Text>Please enter your BVN</Text>
      </View>
      <View style={styles.textInput}>
        <TextInput
          mode="contained" 
          placeholder="Enter OTP"
          // value={text}
          // onChangeText={text => setText(text)}
        />
      </View>
      <Button
      mode="contained"
      color="white"
      onPress={() => {
          props.navigation.navigate('ConvertTokenSuccess')
      }}
      >Submit</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  
  textInput: {
    padding: 5,
    margin: 5
  },
});

export default OTPConvertScreen;