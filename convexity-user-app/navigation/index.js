import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from '../screens/SplashScreen';
import Login from '../screens/LoginScreen';
import SignUp from '../screens/SignUpScreen';
import Dashboard from '../screens/DashboardScreen';
import UserTerms from '../screens/UserTermsScreen';

const Stack = createStackNavigator();

const AppNavigation = () => {
    return (
        <NavigationContainer>
          <Stack.Navigator initialRouteName="Home">
            <Stack.Screen name="Home" component={SplashScreen} />
            <Stack.Screen name="Login" component={Login} />
            <Stack.Screen name="Dashboard" component={Dashboard} />
            <Stack.Screen name="SignUp" component={SignUp} />
            <Stack.Screen name="UserTerms" component={UserTerms} />
          </Stack.Navigator>
        </NavigationContainer>
      );
}

export default AppNavigation;