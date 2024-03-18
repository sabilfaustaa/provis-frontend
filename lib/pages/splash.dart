import 'dart:async';

import 'package:digisehat/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3), () => {Navigator.pushNamed(context, '/sign-in')});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkPrimaryColor,
        body: Center(
            child: Text(
          'Selamat Datang Di',
          style: primaryTextStyle,
        )));
  }
}
