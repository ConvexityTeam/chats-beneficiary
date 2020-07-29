import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import { faCreditCard, faMoneyBill,faChartBar, faCog, faExchangeAlt, faUniversity } from '@fortawesome/free-solid-svg-icons'
import Colors from '../../constants/colors'

const HomeScreen = ({ navigation }) => {

    return (
      <View style={styles.container}>
        <View style={styles.header}>
        <Text style={{
            fontSize: 35,
            fontFamily: 'inter-bold'
            }}>Dashboard</Text>
        </View>
          <View style={styles.name}>
            <Text style={{color: Colors.purple, fontFamily: 'inter-regular', lineHeight: 39, fontSize: 25, fontStyle: "normal"}}>Emmanuel Oaikhenan</Text>
          </View>

          <View style={{flexDirection: "row", 
          justifyContent: "space-evenly"}}>
            <View style={styles.card}>
              <FontAwesomeIcon icon={ faExchangeAlt } style={{color: Colors.purple}} />
              <Text style={styles.text}>Convert</Text>
            </View>
            <View style={styles.card}>
              <FontAwesomeIcon icon={ faUniversity } style={{color: Colors.purple}} />
              <Text style={styles.text}>Withdraw</Text>
            </View>
            <View style={styles.card}>
              <FontAwesomeIcon icon={ faMoneyBill } style={{color: Colors.purple}} />
              <Text style={styles.text}>Pay</Text>
            </View>
          </View>

          <View style={{flexDirection: "row", justifyContent: "space-evenly"}}>
            <View style={styles.card}>
            <FontAwesomeIcon icon={ faCreditCard } style={{color: Colors.purple}} />
              <Text style={styles.text}>Wallet</Text>
            </View>
            <View style={styles.card}>
            <FontAwesomeIcon icon={ faChartBar } style={{color: Colors.purple}} />
              <Text style={styles.text}>Analytics</Text>
            </View>
            <View style={styles.card}>
              <FontAwesomeIcon icon={ faCog } style={{color: Colors.purple}} />
              <Text style={styles.text}>Settings</Text>
            </View>
          </View>
          <View style={{paddingTop: 100}}>
            <View style={{flexDirection: "row", 
            justifyContent: "space-between", alignItems: "center", 
            padding: 10}}>
              <Text style={{fontFamily: "inter-bold", fontSize: 22, lineHeight: 27, fontStyle: "normal"}}>Transactions</Text>
              <Text style={{fontFamily: "inter-regular", fontSize: 12, lineHeight: 15, fontStyle: "normal"}}>View All</Text>
            </View>
            <View>
            <View style={styles.notice}>            
              <Text style={styles.textPersonTxn}>Emmanuel Oaikhenan</Text>
              <Text style={styles.textTxnAmount}>3000 NGNT</Text>
            </View>
            <View style={styles.notice}> 
              <Text style={styles.textPersonTxn}>Emmanuel Oaikhenan</Text>
              <Text style={styles.textTxnAmount}>3000 NGNT</Text>
            </View>
            <View style={styles.notice}> 
              <Text style={styles.textPersonTxn}>Emmanuel Oaikhenan</Text>
              <Text style={styles.textTxnAmount}>3000 NGNT</Text>
            </View>
            </View>
          </View>
      </View>
    );
  }

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 50
  },
 
  header: {
    padding: 10
  },
  name: {
    padding: 10
  },
  card: {
    margin: 3,
    padding: 3,
    width: 100,
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
  notice: {
    flexDirection: "row", 
    justifyContent: "space-between", 
    padding: 10,
    width: "97%",
    height: 50,
    margin: 3,
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    
    alignItems: "center",
    shadowOpacity: 0.25,
    shadowRadius: 2.22,
    elevation: 2,
    borderRadius: 2
  },
  text: {
    fontFamily: 'inter-regular', 
    paddingTop: 10
  },
  textPersonTxn : {
    fontFamily: "inter-regular", 
    fontSize: 13, 
    lineHeight: 25, 
    fontStyle: "normal"
  },
  textTxnAmount : {
    fontFamily: "inter-regular", 
    fontSize: 15, 
    lineHeight: 25, 
    fontStyle: "normal"}
});

export default HomeScreen;