import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import { TextInput, Button,TouchableRipple } from 'react-native-paper';

 const SplashScreen = props => {

  const [text, setText] = React.useState('');
 
  return (
    <View style={styles.container}>
      <View style={styles.textInput}>
        <TextInput
        mode="outlined"
        label="Email"
        placeholder="Type Email"
        value={text}
        onChangeText={text => setText(text)}
        />
      </View>
       <View style={styles.textInput}>
        <TextInput
        mode="outlined"
        label="Phone"
        placeholder="Type Phone"
        value={text}
        onChangeText={text => setText(text)}
        />
      </View>
      <View style={styles.textInput}>
        <TextInput
          mode="outlined" 
          label="Password"
          placeholder="Type Password"
          value={text}
          onChangeText={text => setText(text)}
        />
      </View>
      <View style={styles.textInput}>
        <TextInput
        mode="outlined"
        label="Location"
        placeholder="Type Location"
        value={text}
        onChangeText={text => setText(text)}
        />
      </View>
      <View style={styles.buttonContainer}>
        <View style={styles.button}>
          <TouchableRipple rippleColor="grey">
            <Button 
            mode="contained"
            icon="reminder"
            color="white"
            onPress={() => {
                props.navigation.navigate('Dashboard')
            }}>Sign Up (New User)</Button>
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
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    flex: 1,
    padding: 10,
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