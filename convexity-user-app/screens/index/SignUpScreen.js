import { StatusBar } from 'expo-status-bar';
import React, { useReducer } from 'react';
import { StyleSheet, View, Text, ScrollView, KeyboardAvoidingView, KeyboardAvoidingViewBase } from 'react-native';
import { TextInput, Button,TouchableRipple } from 'react-native-paper';
import { useDispatch } from 'react-redux';

import * as authActions from '../../store/actions/auth';

 const SplashScreen = props => {

  const signupHandler = () => {

  }
 
  return (
    <KeyboardAvoidingView
    behavior="padding"
    keyboardVerticalOffset={10}
    style={styles.container}>
      <ScrollView>
      <View style={styles.textInput}>
        <TextInput
        id="email"
        mode="outlined"
        label="Email"
        keyboardType="email-address"
        placeholder="Type Email"
        required
        email
        autoCapitalize="none"
        errorText="Please enter a Valid email address"
        onValueChange={() => {}}
        initialValue=""
        />
      </View>
       <View style={styles.textInput}>
        <TextInput
        mode="outlined"
        label="Phone"
        placeholder="Type Phone"
        onValueChange={() => {}}
        initialValue=""
        />
      </View>
      <View style={styles.textInput}>
        <TextInput
          id="password"
          mode="outlined" 
          label="Password"
          placeholder="Type Password"
          keyboardType="default"
          secureTextEntry
          required
          minLength={5}
          errorText="Please Enter more than 5 characters!"
          onValueChange={() => {}}
          initialValue=""
        />
      </View>
      <View style={styles.textInput}>
        <TextInput

        mode="outlined"
        label="Location"
        placeholder="Type Location"
        onValueChange={() => {}}
        initialValue=""
        />
      </View>
      <View style={styles.buttonContainer}>
        <View style={styles.button}>
          <TouchableRipple rippleColor="grey">
            <Button 
            mode="contained"
            icon="reminder"
            color="white"
            onPress={() => {
                props.navigation.navigate('Dashboard')
            }}>Sign Up (New User)</Button>
          </TouchableRipple>
        </View>
      </View>
      <Button title="User Terms" onPress={() => {
          props.navigation.navigate('Login')
      }}><Text style={styles.text}>Login (Existing User?)</Text></Button>
      <Button color="white" onPress={() => {
          props.navigation.navigate('UserTerms')
      }} />
      <StatusBar style="auto" />
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    flex: 1,
    paddingTop: 50,
    alignItems: 'center'
    // backgroundColor: "#4C296B"
  },
  textInput: {
    padding: 5,
    margin: 5
  },
  buttonContainer: { flexDirection: "row", justifyContent: "center", paddingTop: 50 },
  button: { width: "80%", margin: 10, color: "white" },
  // text: { color: "white" }
});

export default SplashScreen;