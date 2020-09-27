import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, Image, TouchableOpacity } from 'react-native';
import { Button } from 'react-native-paper';
import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import { faCreditCard, faMoneyBill,faChartBar, faCog, faExchangeAlt, faUniversity, faArrowUp, faChevronDown } from '@fortawesome/free-solid-svg-icons'
import Colors from '../../constants/colors';
import { TouchableRipple } from 'react-native-paper';

const HomeScreen = ( props) => {

    return (
      <View style={styles.container}>
        
        
        <View style={styles.header}>
        <TouchableOpacity onPress={() => props.navigation.openDrawer()}>
          <Image source={require('../../assets/icons/menu-open.png')}></Image>
          </TouchableOpacity>
          <View style={{paddingLeft: 5}}>
        <Text style={{
            fontSize: 24,
            fontFamily: 'gilroy-bold'
            }}>Home</Text>
            </View>
        </View>
        <View style={styles.one}>
          <View style={styles.daily}>
            <Text>Daily</Text>
            <FontAwesomeIcon icon={ faChevronDown } style={{color: '#222222'}} />
          </View>
          <View style={{paddingLeft: 10}}><Text>7th Dec.</Text></View>
        </View>
          <View style={styles.name}>
            <View>
            <Text style={{color: '#222222', fontFamily: 'gilroy-regular', lineHeight: 24, fontSize: 24, fontStyle: "normal"}}>$12,500.00</Text>
            </View>
            <View style={{paddingLeft: 5, paddingBottom: 3}}>
              <Text style={{color: '#00C2A8'}}>2.5%</Text></View>
            <View style={{paddingLeft: 5, paddingBottom: 3}}>
            <FontAwesomeIcon icon={ faArrowUp } style={{color: '#00C2A8', width: 16, height: 16}} />
            </View>
          </View>
          <View style={styles.name}>
            <Text style={{fontFamily: "gilroy-regular", fontSize: 14, lineHeight: 15, color: '#555555'}}>Total balance</Text>
          </View>
          <View style={{flexDirection: "row", justifyContent: "center", paddingTop: 250}}>
            <View style={styles.card}>
            {/* <FontAwesomeIcon icon={ faChartBar } style={{color: Colors.purple}} /> */}
              <Text style={styles.text}>Monthly Income</Text>
              <Text style={styles.text2}>$25,000</Text>
            </View>
            <View style={styles.card}>
              {/* <FontAwesomeIcon icon={ faCog } style={{color: Colors.purple}} /> */}
              <Text style={styles.text}>Monthly Expemses</Text>
              <Text style={styles.text2}>$15,000</Text>
            </View>
          </View>
      </View>
    );
  }

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 10,
    backgroundColor: '#fff'
  },
  header: {
    paddingLeft: 10,
    paddingRight: 10,
    flexDirection: "row", 
  },
  one: {
    paddingTop: 30,
    paddingBottom: 20,
    paddingLeft: 20,
    paddingRight: 20,
    marginRight: 20,
    flexDirection: "row", 
    // justifyContent: "space-between",
    alignItems: "center", 
  },
  name: {
    paddingLeft: 20,
    paddingRight: 20,
    marginRight: 20,
    flexDirection: "row", 
    // justifyContent: "space-between",
    alignItems: "center", 
  },
  daily: {
    margin: 0,
    paddingLeft: 5,
    width: 67,
    height: 33,
    borderRadius: 5,
    backgroundColor: '#EFEBF9',
    
    flexDirection: "row",
    justifyContent: "space-evenly",
    alignItems: "center", 
  },
  card: {
    margin: 10,
    padding: 0,
    width: 150,
    height: 150,  
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    // justifyContent: "center", 
    alignItems: "center",
    shadowOpacity: 0.25,
    shadowRadius: 2,
    elevation: 4,
    borderRadius: 5,
    backgroundColor: '#fff'
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
    fontFamily: 'gilroy-regular', 
    color: '#333333',
    fontSize: 14,
    paddingTop: 25
  },
  text2: {
    fontFamily: 'gilroy-medium', 
    color: '#333333',
    fontSize: 18,
    paddingTop: 1
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