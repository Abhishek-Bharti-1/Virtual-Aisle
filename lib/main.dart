import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:walmart/constants.dart';
import 'package:walmart/firebase_options.dart';
import 'package:walmart/screens/home/home_screen.dart';
import 'package:walmart/screens/onboarding/info/info_form.dart';
import 'package:walmart/screens/onboarding/info/pages/preferences.dart';
import 'package:walmart/screens/onboarding/login.dart';
import 'package:walmart/screens/search/search_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:InfoForm(),
    );
  }
}
