export const SIGNUP = 'SIGNUP';

export const signup = (email, password) => {
    return async dispatch => {
        const response = await fetch('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI', {
            method: 'POST',
            headers: {
                'CONTENT-TYPE': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                password: password,
                returnSecureToken: true
            })
        })

        if(!response.ok) {
            throw new Error('Something went wromg!')
        }

        const resDate = response.json();
        console.log(resData);  
        dispatch({ type: SIGNUP})
    }
}