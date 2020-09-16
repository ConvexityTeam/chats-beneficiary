export const SIGNUP = 'SIGNUP';
export const LOGIN = 'LOGIN';

export const LOGOUT = 'LOGOUT';

export const signup = (firstName, lastName, email, phoneNumber, password) => {
  // console.log("email");
  // console.log(email);
  return async dispatch => {
    const response = await fetch(
      'https://chats-backend.herokuapp.com/api/v1/auth/register',
      // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
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
          'https://chats-backend.herokuapp.com/api/v1/auth/login',
        // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: email,
            password: password,
            // returnSecureToken: true
          })
        }
      );
  
      if (!response.ok) {
        const errorResData = await response.json();
        // const errorId = errorResData.error.message;
        // let message = 'Something went wrong!';
        // if (errorId === 'EMAIL_NOT_FOUND') {
        //   message = 'This user is not registered!';
        // } else if (errorId === 'INVALID_PASSWORD') {
        //   message = 'This password is not valid!';
        // }
        console.log(errorResData.message, errorResData.status)
        throw new Error(errorResData.message);
      }
  
      const resData = await response.json();
      console.log(resData);
      dispatch({ type: LOGIN, 
                  token: resData.token, 
                  // userId: resData.user.id 
                });
    };
  };
  
  export const logout = () => {
    return { type: LOGOUT };
  };