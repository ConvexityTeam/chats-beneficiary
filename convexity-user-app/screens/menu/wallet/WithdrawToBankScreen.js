import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';
import Color from '../../../constants/colors'

 const WithdrawToBankScreen = props => {
 
  return (
    <View style={styles.container}>
      <View>
        <Text style={{fontFamily: "inter-regular", fontSize: 14, lineHeight: 15}}>Welcome Emmanuel</Text>
      </View>
      <View style={styles.walletCard}>
        <Text style={{color: 'white', fontFamily: 'inter-bold', fontSize: 14}}>
          Wallet Balance:
        </Text>
        <Text style={{color: 'white', fontFamily: 'inter-bold', fontSize: 24}}>
          15,000 NGNT
        </Text>
      </View>
      <View style={styles.textInput}>
        <TextInput
          mode="contained" 
          label="Password"
          placeholder="Enter Amount to Transfer"
          // value={text}
          // onChangeText={text => setText(text)}
        />
      </View>
      <Button style={{marginTop: 10}}
        mode="outlined"
        color="black"
        onPress={() => {
            props.navigation.navigate('OTPWithdrawToBank')
        }}
      >Submit</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 10,
    margin: 10
  },
  walletCard: {
    marginTop: 20,
    backgroundColor: Color.purple,
    paddingTop: 20,
    paddingBottom: 20,
    width: '100%',
    height: '25%',  
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    justifyContent: "center", 
    alignItems: "center",
    shadowOpacity: 0.25,
    shadowRadius: 2,
    elevation: 4,
    borderRadius: 4,
  },
  textInput: {
    paddingTop: 10,
    width: '100%'
  },
});

export default WithdrawToBankScreen;