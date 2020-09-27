import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, Image } from 'react-native';
import { Button, TouchableRipple } from 'react-native-paper';
import Color from '../../../constants/colors'

import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import { faExchangeAlt, faPaperPlane } from '@fortawesome/free-solid-svg-icons'
// import { SplashScreen } from 'expo';

 const WalletScreen = props => {
 
  return (
    <View style={styles.container}>
      <View style={styles.header}>
            <TouchableOpacity onPress={() => props.navigation.openDrawer()}>
              <Image source={require('../../../assets/icons/menu-open.png')}></Image>
            </TouchableOpacity>
            <View style={{paddingLeft: 5}}>
              <Text style={{
                  fontSize: 24,
                  fontFamily: 'gilroy-bold'
                  }}>Wallet</Text>
            </View>
      </View>
      {/* <View>
        <Text style={{fontFamily: "inter-regular", fontSize: 14, lineHeight: 15}}>
          Welcome Emmanuel
        </Text>
      </View> */}
      <View style={styles.walletCard}>
        <Text style={{color: '#000', fontFamily: 'gilroy-medium', fontSize: 36, lineHeight: 42}}>
          $1250.00
        </Text>
        <Text style={{color: '#555555', fontFamily: 'gilroy-medium', fontSize: 14, lineHeight: 16}}>
          Current balance
        </Text>
      </View>
      <View>
      <View style={{flexDirection: "row", justifyContent: "space-evenly"}}>
      <View style={styles.card}>
        <View style={{padding: 10}}>
          <FontAwesomeIcon icon={ faPaperPlane } style={{color: '#222222', width: 16, height: 16}} />
        </View>
        <TouchableRipple onPress={() => {
          props.navigation.navigate('ConvertTokenWithdrawToBank')
        }}>
          <Text style={{color: Color.purple, fontFamily: 'gilroy-medium', fontSize: 14, lineHeight: 16}}>
            Pay
          </Text>
        </TouchableRipple>
      </View>
      <View style={styles.card}>
        <View style={{padding: 10}}>
          <FontAwesomeIcon icon={ faExchangeAlt } style={{color: '#222222', width: 16, height: 16}} />
        </View>
        <TouchableRipple onPress={() => {
          props.navigation.navigate('ConvertToken')
        }}>
          <Text style={{color: '#555555', fontFamily: 'gilroy-medium', fontSize: 14, lineHeight: 16}}>
            Convert
          </Text>
        </TouchableRipple>
      </View>
      </View>
      </View>
      <View style={{flexDirection: 'row', justifyContent: 'space-between', padding: 20}}>
        <Text style={{color: '#333333', fontFamily: 'gilroy-medium', fontSize: 16, lineHeight: 19}}>Recent Transactions</Text>
        <TouchableOpacity onPress={() => props.navigation.openDrawer()}>
          <View style={{padding: 2}}>
            <Text style={{color: '#555', fontFamily: 'gilroy-medium', fontSize: 14, lineHeight: 16}}>See all</Text>
          </View>
        </TouchableOpacity>
      </View>
      {/* <View>
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
      >Search For Vendors</Button> */}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 10,
    backgroundColor: '#FFFFFF'
  },
  header: {
    paddingLeft: 10,
    paddingRight: 20,
    paddingBottom: 20,
    flexDirection: "row", 
  },
  walletCard: {
    marginTop: 20,
    marginBottom: 0,
    marginLeft: 20,
    marginRight: 20,
    backgroundColor: '#EFEBF9',
    width: '90%',
    height: 195,  
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
    borderRadius: 5,
  },
  card: {
    marginTop: -30,
    marginBottom: 10,
    padding: 3,
    width: 100,
    height: 70,  
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
    borderRadius: 5,
    backgroundColor: '#FFFFFF'
  },
});

export default WalletScreen;