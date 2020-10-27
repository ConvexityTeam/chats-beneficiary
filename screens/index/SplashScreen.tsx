// import { StatusBar } from 'expo-status-bar';
import React, { useState } from 'react';
import { StyleSheet, Text, View, Image,
  StatusBar,
  SafeAreaView, ImageBackground, TouchableOpacity } from 'react-native';
import { Button } from 'react-native-paper'
import Icon from 'react-native-vector-icons/Ionicons';
import Color from '../../constants/colors';
import AppIntroSlider from 'react-native-app-intro-slider';
// import AuthScreen from '../index/AuthScreen';
// import AuthScreen from '../menu/HomeScreen';
import AuthScreen from '../index/LoginScreen';

const data = [
  {
    title: 'Simple And Easy',
    text: 'Easy and straightforward onboarding process',
    // image: require('../../assets/whitebg.png'),
    bg: '#59b2ab',
  },
  {
    title: 'Safe and Secure',
    text: 'CHATS is and secured to set up encrypted security using Blockchain',
    image: require('../../assets/womanUsingPhone.png'),
    bg: '#febe29',
  },
  {
    title: 'Pay Money Instantly',
    text: 'Transfer instantly between vendors and beneficiaries',
    image: require('../../assets/momAndDaughter.png'),
    bg: '#22bcb5',
  },
];

type Item = typeof data[0];

export default class SplashScreen extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
        show_Main_App: false
    };
  }

  on_Done_all_slides = () => {
    this.setState({ show_Main_App: true });
  };
  
  on_Skip_slides = () => {
    this.setState({ show_Main_App: true });
  };
  
  _renderItem = ({item}: {item: Item}) => {
    return (
      <View
        style={{
          flex: 1,
          backgroundColor: item.bg,
        }}>
        <SafeAreaView style={styles.slide}>
          {/* <ImageBackground source={item.image} style={styles.image}> */}
          <Text style={styles.title}>{item.title}</Text>
          <Text style={styles.subtitle}>{item.text}</Text>
          
          <Button uppercase={false} style={styles.buttonPurple}>            
            <Text style={styles.buttonText}>Sign Up</Text>
          </Button>
          <Button uppercase={false} style={styles.buttonWhite} >            
            <Text style={styles.buttonText}>Login</Text>
          </Button>
          
          {/* </ImageBackground> */}
        </SafeAreaView>
      </View>
    );
  };

  _keyExtractor = (item: Item) => item.title;
 
  render() {

    if (this.state.show_Main_App) {
      return (
        <AuthScreen />
      );
    } else {
      return (
        <View style={{flex: 1}}>
          <StatusBar translucent backgroundColor="transparent" />
          <AppIntroSlider
            keyExtractor={this._keyExtractor}
            renderItem={this._renderItem}
            // bottomButton
            showSkipButton
            showPrevButton
            data={data}
            onDone={this.on_Done_all_slides}
            onSkip={this.on_Skip_slides}
          />
        </View>
      );
    }
      
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 10
  },
  slide: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingBottom: 96, // Add padding to offset large buttons and pagination in bottom of page
  },
  image: {
    width: 320,
    height: 320,
    marginTop: 32,
    resizeMode: "cover",
    justifyContent: "center"
  },
  title: {
    fontFamily: "gilroy-bold",
    fontSize: 24,
    color: 'white',
    textAlign: 'center',
    paddingTop: 300
  },
  subtitle: {
    fontFamily: "gilroy-medium",
    fontSize: 18,
    color: 'white',
    textAlign: 'center',
    paddingBottom: 100
  },
  buttonPurple: {
    flexDirection: "row", 
    // justifyContent: "center", 
    width: "97%",
    height: 50,
    // margin: 3,
    paddingTop: 15,
    paddingBottom: 15,
    paddingLeft: '35%',
    paddingRight: 100,
    alignItems: "center",
    
    borderRadius: 10,
    backgroundColor: '#492954'
  },
  buttonWhite: {
    flexDirection: "row", 
    // justifyContent: "space-between", 
    width: "97%",
    height: 50,
    margin: 3,
    paddingTop: 15,
    paddingBottom: 15,
    paddingLeft: '35%',
    paddingRight: 100,
    alignItems: "center",
    borderWidth: 1,
    borderColor: '#FFFFFF',
    borderRadius: 10,
  },
  buttonText : {
    fontFamily: "gilroy-regular", 
    fontSize: 16, 
    lineHeight: 25, 
    color: '#fff'
  },
});

// export default SplashScreen;