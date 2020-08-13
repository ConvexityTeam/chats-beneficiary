import React, { useState, useEffect } from 'react';
import { TouchableOpacity, ScrollView, View, TextInput, KeyboardAvoidingView, Text, StyleSheet, StatusBar } from 'react-native';
import Color from '../../constants/colors'
import { useNavigation } from '@react-navigation/native';
import { Button } from 'react-native-paper';

const AuthScreen = props => {
    const navigation = useNavigation();
    
    return (
        <View style={styles.container}>
        <View style={{alignItems: "center"}}>
            <Text style={{color: Color.purple, fontFamily: 'inter-bold', fontSize: 40}}>
            Convexity Humanitarian Aids Transfer Service
            </Text>
        </View>
        <View>
        <TouchableOpacity>
                <Button style={{marginTop: 30, fontFamily: 'inter-bold'}}
        mode="outlined"
        onPress={() => {
            navigation.navigate('Login')
        }}
        >Login</Button>
            </TouchableOpacity>
        
        </View>
       
        <StatusBar style="auto" />
        <View style={{}}>
        <Button style={{marginTop: 30}}
        mode="contained"
        color={Color.success}
        onPress={() => {
            navigation.navigate('SignUp')
        }}>SignUp</Button>
        <StatusBar style="auto" />
        </View>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
    
        justifyContent: 'center',
        flex: 1,
        padding: 10,
        // backgroundColor: "#4C296B"
      },
    screen: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    },
    input: {
        height: 30,
        borderColor: 'grey',
       borderBottomWidth: 1,
       marginVertical: 10
    }
});

export default AuthScreen;