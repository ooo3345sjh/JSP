/**
 * 
 */

 // Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";
import { getAuth, signInWithPopup, RecaptchaVerifier, signInWithPhoneNumber} from "https://www.gstatic.com/firebasejs/9.14.0/firebase-auth.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyBteDZKy4shGe5lhIB3mE72XvpGUaxI_QA",
    authDomain: "farmstory2-13d21.firebaseapp.com",
    projectId: "farmstory2-13d21",
    storageBucket: "farmstory2-13d21.appspot.com",
    messagingSenderId: "128099688481",
    appId: "1:128099688481:web:16d400c626b5ad0b8a4360",
    measurementId: "G-QCY8S44W3N"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const auth = getAuth();
auth.languageCode = 'ko';

$(function(){
    window.recaptchaVerifier = new RecaptchaVerifier(
        'phoneNumberBtn', {
        'size': 'invisible',
        'callback': (response) => {
            // reCAPTCHA solved, allow signInWithPhoneNumber.
            onSignInSubmit();
        }
    }, auth);

    $('#phoneNumberBtn').click(function(e){
        e.preventDefault();
        const phoneNumber = '+82'+ $('#phoneNumber').val();
        const appVerifier = window.recaptchaVerifier;

        signInWithPhoneNumber(auth, phoneNumber, appVerifier)
            .then((confirmationResult) => {
            // SMS sent. Prompt user to type the code from the message, then sign the
            // user in with confirmationResult.confirm(code).
            window.confirmationResult = confirmationResult;
            console.log(confirmationResult);
            // ...
        }).catch((error) => {
            // Error; SMS not sent
            // ...
            console.log(error);
        });

    });
    
    $('#confirmCodeBtn').click(function(e){
        e.preventDefault();

        const code = $('#confirmCode').val();
        confirmationResult.confirm(code).then((result) => {
        // User signed in successfully.
        const user = result.user;
        console.log(result);
        // ...
    }).catch((error) => {
        // User couldn't sign in (bad verification code?)
        // ...
        console.log(error);
        });
    })


})