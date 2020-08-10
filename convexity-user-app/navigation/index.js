import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import SplashScreen from '../screens/index/SplashScreen';
import Login from '../screens/index/LoginScreen';
import SignUp from '../screens/index/SignUpScreen';
import Dashboard from '../screens/index/DashboardScreen';
import UserTerms from '../screens/index/UserTermsScreen';

import Auth from '../screens/user/AuthScreen';

import Wallet from '../screens/menu/wallet/WalletScreen';
import ConvertToken from '../screens/menu/wallet/ConvertTokenScreen';
import OTPConvertToken from '../screens/menu/wallet/OtpConvertTokenScreen';
import ConvertTokenSuccess from '../screens/menu/wallet/TokenSuccessConvertScreen';
import WithdrawToBank from '../screens/menu/wallet/WithdrawToBankScreen';
import OTPWithdrawToBank from '../screens/menu/wallet/OtpWithdrawScreen';
import WithdrawToBankSuccess from '../screens/menu/wallet/WithdrawSuccessScreen';

import Pay from '../screens/menu/paybills/ClickScanToPayScreen';
import QRScanning from '../screens/menu/paybills/ScanningQRCodeScreen';
import ConfirmPaymentDetails from '../screens/menu/paybills/ConfirmPaymentDetailsScreen';
import OTPScreen from '../screens/menu/paybills/OtpScreen';
import PaymentSuccess from '../screens/menu/paybills/PaymentSuccessScreen';

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
            <Stack.Screen name="Home" component={SplashScreen} options={{headerShown: false}} />
            <Stack.Screen name="Login" component={Login} options={{headerShown: false}} />
            <Stack.Screen name="Dashboard" component={Dashboard} options={({ route }) => ({
    headerTitle: getHeaderTitle(route),
  }), {headerShown: false}} />
            <Stack.Screen name="SignUp" component={SignUp} options={{headerShown: false}} />
            <Stack.Screen name="UserTerms" component={UserTerms} options={{ title: 'User Terms' }}/>

            <Stack.Screen name="Auth" component={Auth} options={{headerShown: false}} />
           
            <Stack.Screen name="Wallet" component={Wallet} />
           
            <Stack.Screen name="ConvertToken" component={ConvertToken}  />
            <Stack.Screen name="OTPConvertToken" component={OTPConvertToken} options={{ title: 'Convert Token OTP' }} />
            <Stack.Screen name="ConvertTokenSuccess" component={ConvertTokenSuccess} options={{ title: 'Convert Token Success', headerShown: false }} />

            <Stack.Screen name="WithdrawToBank" component={WithdrawToBank} options={{ title: 'Withdraw To Bank' }} />
            <Stack.Screen name="OTPWithdrawToBank" component={OTPWithdrawToBank} options={{ title: 'Withdraw To Bank OTP' }} />
            <Stack.Screen name="WithdrawToBankSuccess" component={WithdrawToBankSuccess} options={{ title: 'Withdraw To Bank Successful' }} />

            <Stack.Screen name="Pay" component={Pay} />
            <Stack.Screen name="QRScanning" component={QRScanning} options={{ title: 'QR Scanning' }} />
            <Stack.Screen name="ConfirmPaymentDetails" component={ConfirmPaymentDetails} options={{ title: 'Confirm Payment Details' }} />
            <Stack.Screen name="OTPScreen" component={OTPScreen} options={{ title: 'Enter OTP' }} />
            <Stack.Screen name="PaymentSuccess" component={PaymentSuccess} options={{ title: 'Payment Successful' }} />
          </Stack.Navigator>
        </NavigationContainer>
      );
}

export default AppNavigation;