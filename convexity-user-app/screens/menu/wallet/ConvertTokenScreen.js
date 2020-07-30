import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { TextInput, Button, TouchableRipple } from 'react-native-paper';

 const ConvertTokenScreen = props => {
 
  return (
    <View style={{ flex: 1, justifyContent: 'center', paddingTop: 50 }}>
      <View>
        <Text>Welcome Emmanuel</Text>
      </View>
      <View>
        <Text>Wallet Balance:</Text>
        <Text>15,000 NGNT</Text>
      </View>
      <View style={styles.textInput}>
        <TextInput
          mode="contained" 
          label=""
          placeholder="Enter Token Amount to Convert"
          // value={text}
          // onChangeText={text => setText(text)}
        />
      </View>
      <Button>Search For Vendors</Button>
    </View>
  );
}

const styles = StyleSheet.create({
  textInput: {
    padding: 5,
    margin: 5
  },
});

export default ConvertTokenScreen;