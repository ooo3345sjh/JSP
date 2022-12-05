/**
 * 
 */
 
 // 구글 로그인
// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-analytics.js";
import { getAuth, signInWithPopup, GoogleAuthProvider } from "https://www.gstatic.com/firebasejs/9.14.0/firebase-auth.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
	apiKey: "AIzaSyBG9WrwOrHLmrIc1-2C3GIp-NfFd24NZeo",
    authDomain: "farmstory2-46784.firebaseapp.com",
    projectId: "farmstory2-46784",
    storageBucket: "farmstory2-46784.appspot.com",
    messagingSenderId: "218489183119",
    appId: "1:218489183119:web:3170503e7640ebeb7349fa",
    measurementId: "G-YHG0CZQJNR"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const provider = new GoogleAuthProvider();
const auth = getAuth();
	
$(function(){
	$('#googleLogin').click(function(){
		console.log('click');
		signInWithPopup(auth, provider)
		 	.then((result) => {
		   		// This gives you a Google Access Token. You can use it to access the Google API.
		    	const credential = GoogleAuthProvider.credentialFromResult(result);
		    	const token = credential.accessToken;
		    	// The signed-in user info.
		    	const user = result.user;
		    	// ...
		    	console.log(result);
		    	let jsonData = {
					"uid" : user.uid,
					"pass" : "google",
					"nick" : result._tokenResponse.firstName,
					"email" : user.email,
					"name" : user.displayName
		        }
		        	
        		$.post("/" + contextRoot + '/user/kakaoLogin.do', jsonData, function(data){
					console.log(data);
        			if(!data){
						alert('로그인에 실패 했습니다.');
					} else {
						location.href = "/" + contextRoot + "/index.do";
					}
        		});
		  	}).catch((error) => {
		    // Handle Errors here.
		    const errorCode = error.code;
		    const errorMessage = error.message;
		    // The email of the user's account used.
		    const email = error.customData.email;
		    // The AuthCredential type that was used.
		    const credential = GoogleAuthProvider.credentialFromError(error);
		    // ...
		    	console.log(error);
		});
	})
	
})

