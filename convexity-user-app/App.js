
import React, { useState } from 'react';
import { Provider as PaperProvider } from 'react-native-paper';
import { AppLoading } from 'expo';
import * as Font from 'expo-font';
import { createStore, combineReducers, applyMiddleware, } from 'redux';
import { Provider } from 'react-redux';
import ReduxThunk from 'redux-thunk';
// import store from './store/reducers';

import rootReducer from './store/reducers/auth';

import AppNavigation from './navigation'

import authReducer from './store/reducers/auth'


const fetchFonts = () => {
  return Font.loadAsync({
    'inter-black': require('./assets/fonts/Inter-Black.ttf'),
    'inter-bold': require('./assets/fonts/Inter-Bold.ttf'),
    'inter-regular': require('./assets/fonts/Inter-Regular.ttf')
  })
}

const rootReducers = combineReducers({
  auth: authReducer
})
//  applyMiddleware(ReduxThunk)
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