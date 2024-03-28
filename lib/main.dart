import 'package:flutter/material.dart';
import 'package:digisehat/pages/sign_in.dart';
import 'package:digisehat/pages/sign_up.dart';
import 'package:digisehat/pages/forgot_password.dart';
import 'package:digisehat/pages/splash.dart';
import 'package:digisehat/pages/home/home.dart';
import 'package:digisehat/pages/home/profile.dart';
import 'package:digisehat/pages/home/cari_dokter.dart';
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
        // untuk debug :
        '/': (context) => HomePage(),

        // '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/sign-up': (context) => SignUpPage(),
        '/profile': (context) => ProfilePage(),
        '/cari-dokter': (context) => CariDokterPage(),
      },
    );
  }
}
