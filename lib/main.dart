import 'package:digisehat/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/pages/splash.dart';
// import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage()
      },
    );
  }
}
