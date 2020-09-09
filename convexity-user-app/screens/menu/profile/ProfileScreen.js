import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, Image } from 'react-native';
// import { SplashScreen } from 'expo';
import Input from '../../../components/UI/Input';
import { Button } from 'react-native-paper';
import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import {  faChevronRight } from '@fortawesome/free-solid-svg-icons'

 const ProfileScreen = props => {
 
  return (
    <View style={styles.container}>
        <View style={styles.header}>
            <TouchableOpacity onPress={() => props.navigation.openDrawer()}>
              <Image source={require('../../../assets/icons/menu-open.png')}></Image>
            </TouchableOpacity>
            <View style={{paddingLeft: 20}}>
              <Text style={{
                  fontSize: 24,
                  fontFamily: 'gilroy-bold'
                  }}>Profile</Text>
            </View>
        </View>
        <View style={{ alignItems: 'center' }}>
          <Image
            // source={{uri: 'https://raw.githubusercontent.com/AboutReact/sampleresource/master/old_logo.png',}}
            //borderRadius style will help us make the Round Shape Image
            style={{ width: 100, height: 100, borderRadius: 200 / 2, borderWidth: 2, borderColor: '#000' }}
          />
          <Text style={{
                  fontSize: 18,
                  lineHeight: 24,
                  fontFamily: 'gilroy-regular'
                  }}>User Name</Text>
        </View>
        <View style={{paddingTop: 30, paddingLeft: 20, paddingRight: 40}}>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between'}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>Personal Information</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between', paddingTop: 40, paddingBottom: 48}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>Account</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between', paddingBottom: 48}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>KYC Status</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between', paddingBottom: 48}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>Security</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between', paddingBottom: 48}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>Contact Support</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
          <View style={{ flexDirection: 'row', justifyContent: 'space-between'}}>
            <Text style={{
                    fontSize: 16,
                    lineHeight: 24,
                    fontFamily: 'gilroy-regular'
                    }}>Settings</Text>
            <FontAwesomeIcon icon={ faChevronRight } style={{color: '#222222', width: 16, height: 16}} />
          </View>
        </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    // justifyContent: 'center',
    paddingTop: 30
    // alignItems: 'center'
  },
  header: {
    paddingLeft: 20,
    paddingRight: 20,
    flexDirection: "row", 
  },
  buttonPurple: {
    flexDirection: "row", 
    justifyContent: "space-between", 
    width: "97%",
    height: 50,
    margin: 3,
    paddingTop: 15,
    paddingBottom: 15,
    paddingLeft: 160,
    paddingRight: 135,
    alignItems: "center",
    borderRadius: 10,
    backgroundColor: '#492954'
  },
  buttonText : {
    fontFamily: "gilroy-regular", 
    fontSize: 16, 
    lineHeight: 25, 
    color: '#fff'
  },
  signup: {
    paddingTop: 15,
    paddingLeft: 80
  }
});

export default ProfileScreen;