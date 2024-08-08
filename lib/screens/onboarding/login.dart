import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walmart/screens/home/home_screen.dart';
import 'package:walmart/screens/onboarding/info/info_form.dart';
import 'package:walmart/screens/onboarding/services/auth.dart';

Color cardColor = const Color(0xFF1F283E);
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    //AuthService authService = AuthService();
    double screenWidth = MediaQuery.of(context).size.width;
    return
      Scaffold(
        body: Container(// Adjust the height as needed
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.75,
              image: AssetImage('assets/icons/background_image.jpg'),
              // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Space between illustration and button
          // Google Sign-In Button
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:EdgeInsets.all(20),
                      child:
                      Text('Welcome to the \n         Walmart!',style:TextStyle(fontSize: 50,fontWeight:FontWeight.bold,color: Colors.white, ),),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await _googleSignIn.signOut();
                      //await _googleSignIn.disconnect();
                      //authService.handleSignOut();
                      //GoogleSignIn().disconnect();
                      int res = await _authMethods.signInWithGoogle();
                      print(res);
                      if(res == 1){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomeScreen()));
                      }
                      if(res == 2){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> InfoForm()));
                      }
                      // await authService.handleSignIn();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 12, top: 20, bottom: 20),
                      child: Container(
                        width: 300, // Set the width of the circular button
                        height: 60, // Set the height of the circular button
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0), // Make it circular
                          color: cardColor, // Set the background color to white
                        ),
                        child: Row(
                            children :[
                              Padding(
                                padding:EdgeInsets.only(left: 15) ,
                                child:
                                Image.asset(
                                  'assets/icons/google_logo.png',
                                  width: 40,
                                  height: 40,
                                ),),
                              SizedBox(width: 60,) ,
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),);
  }



}