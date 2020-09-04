
import React, { useState } from 'react';
import { Provider as PaperProvider } from 'react-native-paper';
import { AppLoading } from 'expo';
import * as Font from 'expo-font';
import { createStore, combineReducers, applyMiddleware, } from 'redux';
import { Provider } from 'react-redux';
import ReduxThunk from 'redux-thunk';

import AppNavigation from './navigation'

import authReducer from './store/reducers/auth'


const fetchFonts = () => {
  return Font.loadAsync({
    'inter-black': require('./assets/fonts/Inter-Black.ttf'),
    'inter-bold': require('./assets/fonts/Inter-Bold.ttf'),
    'inter-regular': require('./assets/fonts/Inter-Regular.ttf'),
    'gilroy-bold': require('./assets/fonts/Gilroy-Bold.ttf'),
    'gilroy-heavy': require('./assets/fonts/Gilroy-Heavy.ttf'),
    'gilroy-light': require('./assets/fonts/Gilroy-Light.ttf'),
    'gilroy-medium': require('./assets/fonts/Gilroy-Medium.ttf'),
    'gilroy-regular': require('./assets/fonts/Gilroy-Regular.ttf')
  })
}

const rootReducers = combineReducers({
  auth: authReducer
})
//const store = createStore(() => {}, applyMiddleware(ReduxThunk)) - Revert here

// const store = createStore(authReducer)
const store = createStore(rootReducers, applyMiddleware(ReduxThunk))

export default function App() {

  const  [fontLoaded, setFontLoaded ] = useState(false)

  if(!fontLoaded) {
    return (
      <AppLoading 
        startAsync={fetchFonts}
        onFinish={() => setFontLoaded(true)}
      />
    )
  }

 
  return (
    <PaperProvider>
      <Provider store={store}>
       <AppNavigation />
      </Provider>
    </PaperProvider>
  );
}