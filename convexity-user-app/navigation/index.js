import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from '../screens/index/SplashScreen';
import Login from '../screens/index/LoginScreen';
import SignUp from '../screens/index/SignUpScreen';
import Dashboard from '../screens/index/DashboardScreen';
import UserTerms from '../screens/index/UserTermsScreen';

const Stack = createStackNavigator();

/*
  Line 15 - 35 Sets the Drawer items nested in the Dashboard Component at line 44
  You can read https://reactnavigation.org/docs/screen-options-resolution/#setting-parent-screen-options-based-on-child-navigators-state
  to understand ho this is implemented.
  */
import { getFocusedRouteNameFromRoute } from '@react-navigation/native';

function getHeaderTitle(route) {

  const routeName = getFocusedRouteNameFromRoute(route) ?? 'Dashboard';

  switch (routeName) {
    case 'Profile':
      return 'Profile';
    case 'Pay Bills':
      return 'Pay Bills';
    case 'Wallet':
      return 'Wallet';
    case 'Notifications':
      return 'Notifications';
    case 'Settings':
      return 'Settings';
    case 'Vendors':
      return 'Vendor';
  }
}


const AppNavigation = () => {
    return (
        <NavigationContainer>
          <Stack.Navigator initialRouteName="Home">
            <Stack.Screen name="Home" component={SplashScreen} />
            <Stack.Screen name="Login" component={Login} />
            <Stack.Screen name="Dashboard" component={Dashboard} options={({ route }) => ({
    headerTitle: getHeaderTitle(route),
  })} />
            <Stack.Screen name="SignUp" component={SignUp} />
            <Stack.Screen name="UserTerms" component={UserTerms} options={{ title: 'User Terms' }}/>
          </Stack.Navigator>
        </NavigationContainer>
      );
}

export default AppNavigation;