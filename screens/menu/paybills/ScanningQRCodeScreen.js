// // import { StatusBar } from 'expo-status-bar';
// import React, { useState } from 'react';
// import { StyleSheet, Text, View, Button, 
//   SafeAreaView,
//   ScrollView,
//   StatusBar,
//   TouchableOpacity,
//   Dimensions,
// } from 'react-native';
// import { BarCodeScanner, Permissions } from "expo";
// // import { SplashScreen } from 'expo';

//  const PayBillsScreen = props => {
  
//   const [cameraPermission, setCameraPerssion] = useState(null)

//   const 

//   return (
//     <View style={styles.container}>
//       <View style={styles.card}>
//         <Text style={{
//             fontSize: 16,
//             fontFamily: 'gilroy-regular',
//             color: ''
//             }}>Scan QR code for transaction</Text>
//       </View>
//     </View>
//   );
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     paddingTop: 100,
//     // justifyContent: 'center',
//     // alignItems: 'center'
//     backgroundColor: '#E5E5E5'
//   },
//   card: {
//     marginLeft: 40,
//     marginRight: 40,
//     paddingLeft: 5,
//     width: 327,
//     height: 50,
//     borderRadius: 5,
//     backgroundColor: '#fff',
    
//     flexDirection: "row",
//     justifyContent: "space-evenly",
//     alignItems: "center", 
//   }
// });

// export default PayBillsScreen;

import React, { Component } from 'react';
import {
  Alert,
  Linking,
  Dimensions,
  LayoutAnimation,
  Text,
  View,
  StatusBar,
  StyleSheet,
  TouchableOpacity,
} from 'react-native';
import { BarCodeScanner } from 'expo-barcode-scanner';
import * as Permissions from 'expo-permissions' 

export default class PayBillsScreen extends Component {
  state = {
    hasCameraPermission: null,
    lastScannedUrl: null,
  };

  componentDidMount() {
    this._requestCameraPermission();
  }

  _requestCameraPermission = async () => {
    const { status } = await Permissions.askAsync(Permissions.CAMERA);
    this.setState({
      hasCameraPermission: status === 'granted',
    });
  };

  _handleBarCodeRead = result => {
    if (result.data !== this.state.lastScannedUrl) {
      LayoutAnimation.spring();
      this.setState({ lastScannedUrl: result.data });
    }
  };

  render() {
    return (
      <>
      <View style={styles.container}>

        {this.state.hasCameraPermission === null
          ? <Text>Requesting for camera permission</Text>
          : this.state.hasCameraPermission === false
              ? <Text style={{ color: '#fff' }}>
                  Camera permission is not granted
                </Text>
              : <BarCodeScanner
                  onBarCodeRead={this._handleBarCodeRead}
                  style={{
                    height: Dimensions.get('window').height,
                    width: Dimensions.get('window').width,
                  }}
                />}

        {this._maybeRenderUrl()}

        <StatusBar hidden />
      </View>
      </>
    );
  }

  _handlePressUrl = () => {
    Alert.alert(
      'Open this URL?',
      this.state.lastScannedUrl,
      [
        {
          text: 'Yes',
          onPress: () => Linking.openURL(this.state.lastScannedUrl),
        },
        { text: 'No', onPress: () => {} },
      ],
      { cancellable: false }
    );
  };

  _handlePressCancel = () => {
    this.setState({ lastScannedUrl: null });
  };

  _maybeRenderUrl = () => {
    if (!this.state.lastScannedUrl) {
      return;
    }

    return (
      <View style={styles.bottomBar}>
        <TouchableOpacity style={styles.url} onPress={this._handlePressUrl}>
          <Text numberOfLines={1} style={styles.urlText}>
            {this.state.lastScannedUrl}
          </Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.cancelButton}
          onPress={this._handlePressCancel}>
          <Text style={styles.cancelButtonText}>
            Cancel
          </Text>
        </TouchableOpacity>
      </View>
    );
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#000',
  },
  bottomBar: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: 'rgba(0,0,0,0.5)',
    padding: 15,
    flexDirection: 'row',
  },
  url: {
    flex: 1,
  },
  urlText: {
    color: '#fff',
    fontSize: 20,
  },
  cancelButton: {
    marginLeft: 10,
    alignItems: 'center',
    justifyContent: 'center',
  },
  cancelButtonText: {
    color: 'rgba(255,255,255,0.8)',
    fontSize: 18,
  },
});

// import React from 'react';


// import { Container, Spinner, TextH3 } from '../../../components/UI/Index'
// import { BarCodeScanner } from 'expo';
// import * as Permissions from 'expo-permissions' 

// import {window} from '../../../constants/Layout'

// class QRScanningScreen extends React.Component{
//   static navigationOptions = {
//     header: null
//   }
//   // Component State
//   state = {
//     hasCameraPermission: null, // if app has permissions to acess camera
//     isScanned: false // scanned
//   }
//   async componentDidMount() {
//     // ask for camera permission
//     const { status } = await Permissions.askAsync(Permissions.CAMERA);
//     console.log(status);
//     this.setState({ hasCameraPermission: status === "granted" ? true : false });
//   }


//   handleBarCodeScanned = ({ type, data }) => {
//       // Do something here
//       this.props.navigation.navigate('Decode', {
//         data: data 
//       });
//   }
//   render(){
//     const { hasCameraPermission, isScanned } = this.state;
//     if(hasCameraPermission === null){
//       console.log("Requesting permission");
//       return (
//         <Spinner />
//       );
//     }

//     if(hasCameraPermission === false){
//       return ( 
//         <Container>
//          <TextH3>Please grant Camera permission</TextH3>
//         </Container> 
//       )
//     }
//     if(hasCameraPermission === true && !isScanned && this.props.navigation.isFocused() ){
//       return <Container style = {{
//         flex: 1,
//         flexDirection: 'column',
//         justifyContent: 'center',
//         alignItems: 'center'

//       }}>
//         <TextH3>Scan code inside window</TextH3>
//         <BarCodeScanner
//           onBarCodeScanned = { isScanned ? undefined : this.handleBarCodeScanned }
//           style = {{
//             height:  window.height / 2,
//             width: window.height,
//           }}
//         >
//         </BarCodeScanner>
//       </Container>
//     }
//     else{
//       return <Spinner />;
//     }


//   }

// }




// export default QRScanningScreen;

// export default PayBillsScreen;
