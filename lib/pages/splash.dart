import 'dart:async';

import 'package:digisehat/theme.dart';
import 'package:digisehat/helpers.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => {redirectTo(context, '/sign-in')});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(gradientAuthBoxDecoration),
          _buildHeader(),
        ],
      ),
    );
  }

  Widget _buildBackground(gradientAuthBoxDecoration) {
    return Container(
      decoration: gradientAuthBoxDecoration,
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selamat Datang Di',
                style: lightTextStyle.copyWith(fontSize: 16),
              )),
          SizedBox(height: 8),
          Align(
              alignment: Alignment.centerLeft,
              child: Image(
                image: AssetImage("assets/digisehat-text.png"),
                width: 300,
              ))
        ],
      ),
    );
  }
}
