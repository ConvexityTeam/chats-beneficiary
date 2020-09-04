export const SIGNUP = 'SIGNUP';
export const LOGIN = 'LOGIN';

export const LOGOUT = 'LOGOUT';

export const signup = (email, password) => {
  // console.log("email");
  // console.log(email);
  return async dispatch => {
    const response = await fetch(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          email,
          password,
          returnSecureToken: true
        })
      });

    if (!response.ok) {
        const errorResData = await response.json();
        const errorId = errorResData.error.message;
        let message = 'Something went wrong!';
        if (errorId === 'EMAIL_EXISTS') {
          message = 'This email is already registered!';
        }
        throw new Error(message);
    }
    
    const resData = await response.json();
    console.log(resData);
    dispatch({ type: SIGNUP, token: resData.idToken, userId: resData.localId });
  };
};

export const login = (email, password) => {
    return async dispatch => {
      const response = await fetch(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: email,
            password: password,
            returnSecureToken: true
          })
        }
      );
  
      if (!response.ok) {
        const errorResData = await response.json();
        const errorId = errorResData.error.message;
        let message = 'Something went wrong!';
        if (errorId === 'EMAIL_NOT_FOUND') {
          message = 'This user is not registered!';
        } else if (errorId === 'INVALID_PASSWORD') {
          message = 'This password is not valid!';
        }
        throw new Error(message);
      }
  
      const resData = await response.json();
      console.log(resData);
      dispatch({ type: LOGIN, token: resData.idToken, userId: resData.localId });
    };
  };
  
  export const logout = () => {
    return { type: LOGOUT };
  };