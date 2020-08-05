// import { StatusBar } from 'expo-status-bar';
import React, { useState } from 'react';
import { StyleSheet, Text, View, Image,
  StatusBar,
  SafeAreaView } from 'react-native';
import Icon from 'react-native-vector-icons/Ionicons';
import Color from '../../constants/colors';
import AppIntroSlider from 'react-native-app-intro-slider';
import LoginScreen from './LoginScreen';

const data = [
  {
    title: 'Title 1',
    image: require('../../assets/manWorkingonAnalytics.png'),
    bg: '#59b2ab',
  },
  {
    title: 'Title 2',
    image: require('../../assets/womanUsingPhone.png'),
    bg: '#febe29',
  },
  {
    title: 'Rocket guy',
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
          <Text style={styles.title}>{item.title}</Text>
          <Image source={item.image} style={styles.image} />
        </SafeAreaView>
      </View>
    );
  };

  _keyExtractor = (item: Item) => item.title;
 
  render() {

    if (this.state.show_Main_App) {
      return (
        <LoginScreen />
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
  },
  title: {
    fontSize: 18,
    color: 'white',
    textAlign: 'center',
  },
});

// export default SplashScreen;