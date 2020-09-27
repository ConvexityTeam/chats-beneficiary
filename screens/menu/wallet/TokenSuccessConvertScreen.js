import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';
import Colors from '../../../constants/colors'

 const OTPConvertScreen = props => {
 
  return (
    <View style={styles.container}>
      <View style={{padding: 100}}>
        <Text style={{color: Colors.purple, fontFamily: 'inter-bold', fontSize: 24, lineHeight: 35}}>Token Convert Transaction successfull</Text>
      </View>
      
      <Button style={{}}
      mode="contained"
      onPress={() => {
          props.navigation.navigate('Dashboard')
      }}
      >Return Home</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 5
  },
});

export default OTPConvertScreen;