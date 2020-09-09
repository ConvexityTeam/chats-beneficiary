import React, { useState, useEffect, useReducer, useCallback } from 'react';
import {
  ScrollView,
  View,
  KeyboardAvoidingView,
  StyleSheet,
  Button,
  ActivityIndicator,
  Alert, TouchableOpacity, Text
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
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

const AuthScreen = props => {
  const navigation = useNavigation()
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState();
  const [isSignup, setIsSignup] = useState(false);
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

  useEffect(() => {
    if (error) {
      Alert.alert('An Error Occurred!', error, [{ text: 'Okay' }]);
    }
  }, [error]);

  const authHandler = async () => {
    let action;
    if (isSignup) {
      action = authActions.signup(
        formState.inputValues.email,
        formState.inputValues.password
      );
    } else {
      action = authActions.login(
        formState.inputValues.email,
        formState.inputValues.password
      );
    }
    setError(null);
    setIsLoading(true);
    try {
      await dispatch(action);
      navigation.navigate('Dashboard')
    } catch (err) {
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
      behavior={"padding"}
      keyboardVerticalOffset={5}
      style={styles.screen}
    >
      {/* <LinearGradient colors={['#ffedff', '#ffe3ff']} style={styles.gradient}> */}
        <View style={styles.gradient}>
        <Card style={styles.authContainer}>
          <ScrollView>
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
            <View style={{alignItems: 'flex-end', paddingEnd: 10, paddingTop: 10}}>
              <Text>Forgot Password?</Text>
            </View>
            <View style={styles.buttonContainer}>
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
            </View>
            <View style={styles.signup}>
              {/* <Button
                title={`Dont have an account? ${isSignup ? 'Login' : 'Sign Up'}`}
                color={Colors.accent}
                onPress={() => {
                  setIsSignup(prevState => !prevState);
                }}
              /> */}
              <TouchableOpacity onPress={() => {
                  setIsSignup(prevState => !prevState);
                }}>
                <Text>{`Dont have an account? ${isSignup ? 'Login' : 'Sign Up'}`}</Text>
              </TouchableOpacity>
            </View>
          </ScrollView>
        </Card>
        </View>
      {/* </LinearGradient> */}
    </KeyboardAvoidingView>
  );
};

AuthScreen.navigationOptions = {
  headerTitle: 'Authenticate'
};

const styles = StyleSheet.create({
  screen: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'flex-end'
  },
  gradient: {
    flex: 1,
    
  },
  authContainer: {
    width: '100%',
    height: '60%',
    padding: 20,
    borderTopLeftRadius: 30,
    borderTopRightRadius: 30, 
    position: 'absolute',
    bottom: 0,
  },
  buttonContainer: {
    marginTop: 10,
    padding: 10,
    borderRadius: 10
  },
  signup: {
    paddingTop: 15,
    paddingLeft: 80
  }
});

export default AuthScreen;
