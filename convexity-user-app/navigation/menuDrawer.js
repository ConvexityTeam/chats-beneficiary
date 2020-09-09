import React from 'react';
import { View, Text, Button, SafeAreaView } from 'react-native';

import {
  createDrawerNavigator,
  DrawerContentScrollView,
  DrawerItemList,
  DrawerItem,
} from '@react-navigation/drawer';

import { useDispatch } from 'react-redux';
import * as authActions from '../store/actions/auth';
 
import Home from '../screens/menu/HomeScreen';
import Profile from '../screens/menu/profile/ProfileScreen';
import PayBills from '../screens/menu/paybills/ClickScanToPayScreen';
import Wallet from '../screens/menu/wallet/WalletScreen';
import Notifications from '../screens/menu/notifications/NotificationScreen'; 
import AppSettings from '../screens/menu/settings/AppSettingScreen'; 
import Vendor from '../screens/menu/vendor/ClickScanToPayVendorScreen'; 
// import { logout } from '../store/actions/auth';

// const Dashboard = ({ navigation }) => {

//   return (
//     <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
//       <Text>Dashboard Screen</Text>
//       <Button title="Open drawer" onPress={() => navigation.openDrawer()} />
//       <Button title="Toggle drawer" onPress={() => navigation.toggleDrawer()} />
//     </View>
//   );
// }

function LogOut({ navigation }) {
  const dispatch = useDispatch();
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Button onPress={() => {
        dispatch(authActions.logout())
        navigation.navigate('Auth')
      }} title="Log Out" />
      <Text>Are you sure?</Text>
    </View>
  );
}

// const CustomDrawerContent = props=> {
//   return (
//     <DrawerContentScrollView {...props}>
//       <DrawerItemList {...props} />
//       <DrawerItem
//         label="Close drawer"
//         onPress={() => props.navigation.closeDrawer()}
//       />
//       <DrawerItem
//         label="Toggle drawer"
//         onPress={() => props.navigation.toggleDrawer()}
//       />
//     </DrawerContentScrollView>
//   );
// }

const Drawer = createDrawerNavigator();

function MenuDrawer() {
  return (
    <Drawer.Navigator>
      <Drawer.Screen name="Dashboard" component={Home} options={{ title: 'Home' }} style={{color: '#fff'}}/>
      <Drawer.Screen name="Profile" component={Profile} options={{ title: 'Profile' }}/>
      <Drawer.Screen name="Wallet" component={Wallet} />
      <Drawer.Screen name="QR Code" component={PayBills} />
      <Drawer.Screen name="Settings" component={AppSettings} />
      <Drawer.Screen name="Notifications" component={Notifications} />
      <Drawer.Screen name="Vendors" component={Vendor} />
      <Drawer.Screen name="Logout" component={LogOut} />
    </Drawer.Navigator>
  );
}

export default MenuDrawer;