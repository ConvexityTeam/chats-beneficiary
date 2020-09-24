import { StatusBar } from 'expo-status-bar';
import React, { useState, useEffect, useReducer, useCallback } from 'react';
import { StyleSheet, View, Text,  ScrollView, TouchableOpacity, KeyboardAvoidingView, Alert, ActivityIndicator,} from 'react-native';
import { TextInput, TouchableRipple, Button } from 'react-native-paper';
import { useDispatch } from 'react-redux';
import { useNavigation } from '@react-navigation/native'

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
  const navigation = useNavigation()
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState();
  const [isSignup, setIsSignup] = useState(false);
  const dispatch = useDispatch();

  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      first_name: '',
      last_name: '',
      email: '',
      phone: '',
      password: ''
    },
    inputValidities: {
      first_name: false,
      last_name: false,
      email: false,
      phone: false, 
      password: false
    },
    formIsValid: false
  });

  useEffect(() => {
    if (error) {
      Alert.alert('An Error Occurred!', error, [{ text: 'Okay' }]);
    }
  }, [error]);

  // const authHandler = async () => {
    
  //   let action;
  //   if (isSignup) {
  //     action = authActions.signup(
  //       formState.inputValues.first_name,
  //       formState.inputValues.last_name ,
  //       formState.inputValues.email,
  //       formState.inputValues.phone,
  //       formState.inputValues.password
  //     );
  //   } else {
  //     action = authActions.login(
  //       formState.inputValues.email,
  //       formState.inputValues.password
  //     );
  //   }
  //   setError(null);
  //   setIsLoading(true);
  //   try {
  //     await dispatch(action);
  //     navigation.navigate('Dashboard')
  //   } catch (err) {
  //     setError(err.message);
  //     setIsLoading(false);
  //   }
    
  // };

  const authHandler = async () => {
    setError(null);
    setIsLoading(true);
    try { 
      await dispatch(
        authActions.signup(
          formState.inputValues.first_name,
          formState.inputValues.last_name ,
          formState.inputValues.email,
          formState.inputValues.phone,
          formState.inputValues.password
        )
      );
      navigation.navigate('Profile')
    } catch (err){
      setError(err.message);
      setIsLoading(false);
    }
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
              id="first_name"
              label="First Name"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              onInputChange={inputChangeHandler}
              initialValue=""
            />
            <Input
              id="last_name"
              label="Last Name"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              onInputChange={inputChangeHandler}
              initialValue=""
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
              id="phone"
              label="Phone Number"
              keyboardType="default"
              required
              email
              autoCapitalize="none"
              // errorText="Please enter a valid email address."
              onInputChange={inputChangeHandler}
              initialValue=""
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
            <View style={styles.button}>
                {isLoading ? ( 
                  <ActivityIndicator size="small" color={Colors.purple} />
                ) : (
                  <Button uppercase={false} mode="contained" color='#492954' onPress={authHandler}>
                    <Text style={styles.buttonText}>Sign Up</Text>
                  </Button>
                )}
              
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
    paddingTop: 50,
    paddingLeft: 20,
    paddingRight: 20
    // borderTopLeftRadius: 30,
    // borderTopRightRadius: 30, 
    // position: 'absolute',
    // bottom: 0,
  },
  signup: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingBottom: 96,
    
  },
  button: {
    marginTop: 10,
    paddingTop: 10,
    paddingLeft: 5,
    paddingRight: 5,
    borderRadius: 10,
    width: "97%",
    height: 50,
    
  },
  
  buttonText : {
    fontFamily: "gilroy-regular", 
    fontSize: 16, 
    lineHeight: 25, 
    color: '#fff'
    
  },
  
});

export default SignUpScreen;