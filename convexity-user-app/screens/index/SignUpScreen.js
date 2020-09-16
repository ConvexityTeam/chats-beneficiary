import { StatusBar } from 'expo-status-bar';
import React, { useReducer, useCallback } from 'react';
import { StyleSheet, View, Text, ScrollView, TouchableOpacity, KeyboardAvoidingView, KeyboardAvoidingViewBase } from 'react-native';
import { TextInput, Button,TouchableRipple } from 'react-native-paper';
import { useDispatch } from 'react-redux';
import Input from '../../components/UI/Input';
import Card from '../../components/UI/Card';
import Colors from '../../constants/colors';

import * as authActions from '../../store/actions/auth';

const FORM_INPUT_UPDATE = 'FORM_INPUT_UPDATE';

const formReducer = (state, action) => {
  if (action.type === FORM_INPUT_UPDATE) {
    const updatedValues = {
      ...state.inputValues,
      [action.input]: action.value
    };
    const updatedValidities = {
      ...state.inputValidities,
      [action.input]: action.isValid
    };
    let updatedFormIsValid = true;
    for (const key in updatedValidities) {
      updatedFormIsValid = updatedFormIsValid && updatedValidities[key];
    }
    return {
      formIsValid: updatedFormIsValid,
      inputValidities: updatedValidities,
      inputValues: updatedValues
    };
  }
  return state;
};

 const SignUpScreen = props => {

  const dispatch = useDispatch();

  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      firstName: '',
      lastName: '',
      email: '',
      phoneNumber: '',
      password: ''
    },
    inputValidities: {
      firstName: false,
      lastName: false,
      email: false,
      phoneNumber: false, 
      password: false
    },
    formIsValid: false
  });

  const signupHandler = () => {
    dispatch(
      authActions.signup(
        formState.inputValues.firstName,
        formState.inputValues.lastName ,
        formState.inputValues.email,
        formState.inputValues.phoneNumber,
        formState.inputValues.password
      )
    );
  };

  const inputChangeHandler = useCallback(
    (inputIdentifier, inputValue, inputValidity) => {
      dispatchFormState({
        type: FORM_INPUT_UPDATE,
        value: inputValue,
        isValid: inputValidity,
        input: inputIdentifier
      });
    },
    [dispatchFormState]
  );

 
  return (
<KeyboardAvoidingView
      behavior={Platform.OS == "ios" ? "padding" : "height"}
      keyboardVerticalOffset={5}
      style={styles.screen}
    >
      {/* <LinearGradient colors={['#ffedff', '#ffe3ff']} style={styles.gradient}> */}
        <View style={styles.gradient}>
        <Card style={styles.authContainer}>
          <ScrollView>
          <Input
              id="firstName"
              label="First Name"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              // onInputChange={inputChangeHandler}
              // initialValue=""
            />
            <Input
              id="lastName"
              label="Last Name"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              // onInputChange={inputChangeHandler}
              // initialValue=""
            />
            <Input
              id="email"
              label="E-Mail"
              keyboardType="email-address"
              required
              email
              autoCapitalize="none"
              errorText="Please enter a valid email address."
              onInputChange={inputChangeHandler}
              initialValue=""
            />
            <Input
              id="phoneNumber"
              label="Phone Number"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              // onInputChange={inputChangeHandler}
              // initialValue=""
            />
            <Input
              id="password"
              label="Password"
              keyboardType="default"
              secureTextEntry
              required
              minLength={5}
              autoCapitalize="none"
              errorText="Please enter a valid password."
              onInputChange={inputChangeHandler}
              initialValue=""
            />
           
            {/* <View style={styles.buttonContainer}>
              {isLoading ? (
                <ActivityIndicator size="small" color={Colors.purple} />
              ) : (
                <View style={styles.buttonPurple}>
                <Button
                  title={isSignup ? 'Sign Up' : 'Login'}
                  color={Colors.purple}
                  onPress={authHandler}
                />
                </View>
              )}
            </View> */}
            <View style={styles.signup}>
              {/* <Button uppercase={false} style={styles.buttonPurple}>             */}
                <Text style={styles.buttonText}>Sign Up</Text>
              {/* </Button> */}
              {/* <Button
                title={`Dont have an account? ${isSignup ? 'Login' : 'Sign Up'}`}
                color={Colors.accent}
                onPress={() => {
                  setIsSignup(prevState => !prevState);
                }}
              /> */}
              {/* <TouchableOpacity onPress={() => {
                  setIsSignup(prevState => !prevState);
                }}>
                <Text>{`Dont have an account? ${isSignup ? 'Login' : 'Sign Up'}`}</Text>
              </TouchableOpacity> */}
            </View>
          </ScrollView>
        </Card>
        </View>
      {/* </LinearGradient> */}
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  screen: {
    flex: 1,
  },
  gradient: {
    flex: 1,
    
  },
  authContainer: {
    width: '100%',
    height: '100%',
    padding: 20,
    // borderTopLeftRadius: 30,
    // borderTopRightRadius: 30, 
    position: 'absolute',
    bottom: 0,
  },
  signup: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingBottom: 96,
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
    color: '#000'
  },
  
});

export default SignUpScreen;