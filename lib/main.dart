import 'package:flutter/material.dart';
import 'package:digisehat/pages/sign_in.dart';
import 'package:digisehat/pages/sign_up.dart';
import 'package:digisehat/pages/forgot_password.dart';
import 'package:digisehat/pages/splash.dart';
// import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ForgotPasswordPage(),
        // '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/sign-up': (context) => SignUpPage()
      },
    );
  }
}
