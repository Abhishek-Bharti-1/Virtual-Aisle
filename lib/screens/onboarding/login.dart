import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:walmart/screens/home/home_screen.dart';
import 'package:walmart/screens/onboarding/info/info_form.dart';
import 'package:walmart/screens/onboarding/services/auth.dart';

import 'info/pages/preferences.dart';

Color cardColor = const Color(0xFF1F283E);
Color walmartBgColor =  Color(0xFF0055BB);
Color buttonColor = Color(0xFFFDBB30);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    int res = await _authMethods.checkUserStatus();

    if (res == 1) {
      // Move to HomeScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    } else if (res == 2) {
      // Move to PreferenceScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Preferences()));
    } else if (res == 3) {
      // Move to InfoForm screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => InfoForm()));
    } else {
      // Show snackbar if not signed in or error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please sign in to access the app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: walmartBgColor, // Set the background color here
        child: Stack(
          children: [

               Align(
                 alignment: Alignment.center,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [

                     Image.asset(
                      'assets/images/walmart_backgroundlogo.png',
                      fit: BoxFit.cover, // Adjust the fit as needed
                     ),
                     SizedBox(height: 10),

                     Padding(
                       padding: EdgeInsets.all(10),
                       child: Text(
                         'AR Shopping Experience with Walmart',
                         textAlign: TextAlign.center, // Center text inside the Text widget
                         style: TextStyle(
                           fontSize: 24,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                       ),
                     ),

                   ],
                 ),
               ),

            // Align(
            //   alignment: Alignment.center,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(20),
            //         child: Text(
            //           'Walmart AR Shopping Experience',
            //           textAlign: TextAlign.center, // Center text inside the Text widget
            //           style: TextStyle(
            //             fontSize: 32,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () async {
                    await GoogleSignIn().signOut(); // Optionally sign out previous sessions
                    int res = await _authMethods.signInWithGoogle();
                    print(res);

                    if (res == 1) {
                      // Move to HomeScreen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                    } else if (res == 2) {
                      // Move to PreferenceScreen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Preferences()));
                    } else if (res == 3) {
                      // Move to InfoForm screen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => InfoForm()));
                    } else {
                      // Handle sign-in failure or user cancellation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign in failed or cancelled')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12, top: 20, bottom: 20),
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: walmartBgColor,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset(
                              'assets/icons/google_logo.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 60),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
