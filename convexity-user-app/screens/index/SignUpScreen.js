import { StatusBar } from 'expo-status-bar';
import React, { useReducer, useCallback } from 'react';
import { StyleSheet, View, Text, ScrollView, KeyboardAvoidingView, KeyboardAvoidingViewBase } from 'react-native';
import { TextInput, Button,TouchableRipple } from 'react-native-paper';
import { useDispatch } from 'react-redux';

import * as authActions from '../../store/actions/auth';

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

 const SplashScreen = props => {

  const dispatch = useDispatch();

  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      email: '',
      password: ''
    },
    inputValidities: {
      email: false,
      password: false
    },
    formIsValid: false
  });

  const signupHandler = () => {
    dispatch(
      authActions.signup(
        formState.inputValues.email,
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
    behavior="padding"
    keyboardVerticalOffset={50}
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
        onInputChange={inputChangeHandler}
        initialValue=""
        />
      </View>
       {/* <View style={styles.textInput}>
        <TextInput
        mode="outlined"
        label="Phone"
        placeholder="Type Phone"
        onValueChange={() => {}}
        initialValue=""
        />
      </View> */}
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
          onInputChange={inputChangeHandler}
          initialValue=""
        />
      </View>
      {/* <View style={styles.textInput}>
        <TextInput

        mode="outlined"
        label="Location"
        placeholder="Type Location"
        onValueChange={() => {}}
        initialValue=""
        />
      </View> */}
      <View style={styles.buttonContainer}>
        <View style={styles.button}>
          <TouchableRipple rippleColor="grey">
            <Button 
            mode="contained"
            icon="reminder"
            color="white"
            onPress={signupHandler}>Sign Up (New User)</Button>
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