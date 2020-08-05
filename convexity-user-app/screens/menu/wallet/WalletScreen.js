import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { Button, TouchableRipple } from 'react-native-paper';
import Color from '../../../constants/colors'
// import { SplashScreen } from 'expo';

 const WalletScreen = props => {
 
  return (
    <View style={styles.container}>
      <View>
        <Text style={{fontFamily: "inter-regular", fontSize: 14, lineHeight: 15}}>
          Welcome Emmanuel
        </Text>
      </View>
      <View style={styles.walletCard}>
        <Text style={{color: 'white', fontFamily: 'inter-bold', fontSize: 14}}>
          Wallet Balance:
        </Text>
        <Text style={{color: 'white', fontFamily: 'inter-bold', fontSize: 24}}>
          15,000 NGNT
        </Text>
      </View>
      <View>
      <View style={{flexDirection: "row", justifyContent: "space-evenly"}}>
      <View style={styles.card}>
      <TouchableRipple onPress={() => {
        props.navigation.navigate('ConvertToken')
      }}>
        <Text style={{color: Color.purple, fontFamily: 'inter-bold', fontSize: 14}}>
          Convert Token
        </Text>
      </TouchableRipple>
      </View>
      <View style={styles.card}>
      <TouchableRipple onPress={() => {
        props.navigation.navigate('WithdrawToBank')
      }}>
        <Text style={{color: Color.purple, fontFamily: 'inter-bold', fontSize: 14}}>
          Withdraw Funds
        </Text>
      </TouchableRipple>
      </View>
      </View>
      </View>
      <View>
          <TouchableRipple rippleColor="grey">
            <Button style={{marginTop: 30}}
            mode="contained"
            color="white"
            onPress={() => {
                props.navigation.navigate('Pay')
            }}>Scan To Pay</Button>
          </TouchableRipple>
        
      </View>
      <Button style={{marginTop: 10}}
        mode="contained"
        onPress={() => {
            props.navigation.navigate('ConvertToken')
        }}
      >Search For Vendors</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 50,
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
  card: {
    marginTop: 30,
    marginBottom: 10,
    padding: 3,
    width: '50%',
    height: 90,  
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
});

export default WalletScreen;