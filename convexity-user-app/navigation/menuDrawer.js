import React from 'react';
import { View, Text, Button, SafeAreaView, StyleSheet, TouchableOpacity } from 'react-native';
import Icon from 'react-native-vector-icons/Ionicons';

import {
  createDrawerNavigator,
  DrawerContentScrollView,
  DrawerItemList,
  DrawerItem,
} from '@react-navigation/drawer';

import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import { faHome, faWallet, faChartBar, faCog, faQrcode, faUser, faSignOutAlt, faHeadset, faUniversity, faBell, faChevronDown } from '@fortawesome/free-solid-svg-icons'


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
        navigation.navigate('Login')
      }} title="Log Out" />
      <Text>Are you sure?</Text>
    </View>
  );
}

const CustomDrawerContent = props=> {
  return (
    <DrawerContentScrollView {...props}>
      <DrawerItemList {...props} />
      {/* <DrawerItem
        label="Close drawer"
        onPress={() => props.navigation.closeDrawer()}
      /> */}
      {/* <View style={styles.header}>
        <FontAwesomeIcon icon={ faChartBar } style={{color: '#000'}} />
        <View style={{paddingLeft: 5}}>
          <DrawerItem
            label="Toggle drawer"
            onPress={() => props.navigation.toggleDrawer()}
          />
        </View>
      </View> */}
      <View style={styles.header}>
        <FontAwesomeIcon icon={ faHeadset } style={{color: '#000'}} />
        <View style={{paddingLeft: 10}}>
          <DrawerItem
            label="Contact Us"
            onPress={() => props.navigation.navigate('Dashboard', { screen: 'Profile' })}
          />
        </View>
      </View>
      
    </DrawerContentScrollView>
  );
}

const Drawer = createDrawerNavigator();

function MenuDrawer() {
  return (
    <Drawer.Navigator drawerContent={(props) => <CustomDrawerContent {...props} />}>
      <Drawer.Screen name="Dashboard" component={Home} options={{ title: 'Home', drawerIcon: config => <FontAwesomeIcon icon={ faHome } style={{color: '#000'}} /> }} />
      <Drawer.Screen name="Wallet" component={Wallet} options={{
            drawerIcon: config => <FontAwesomeIcon icon={ faWallet } style={{color: '#000'}} /> }} />
      <Drawer.Screen name="Generate/Scan QR Code" component={PayBills} options={{drawerIcon: config => <FontAwesomeIcon icon={ faQrcode } style={{color: '#000'}} />}} />
      <Drawer.Screen name="Notifications" component={Notifications} options={{drawerIcon: config => <FontAwesomeIcon icon={ faBell } style={{color: '#000'}} />}} />
      <Drawer.Screen name="Profile" component={Profile} options={{drawerIcon: config => <FontAwesomeIcon icon={ faUser } style={{color: '#000'}} />}} />
      {/* <Drawer.Screen name="Vendors" component={Vendor} /> */}
      <Drawer.Screen name="Settings" component={AppSettings} options={{drawerIcon: config => <FontAwesomeIcon icon={ faCog } style={{color: '#000'}} />}} />
      <Drawer.Screen name="Logout" component={LogOut} options={{drawerIcon: config => <FontAwesomeIcon icon={ faSignOutAlt } style={{color: '#000'}} />}} /> 
    </Drawer.Navigator>
  );
}

const styles = StyleSheet.create({
  header: {
    paddingLeft: 20,
    // paddingRight: 10,
    flexDirection: "row", 
    alignItems: "center"
  },
})

export default MenuDrawer;