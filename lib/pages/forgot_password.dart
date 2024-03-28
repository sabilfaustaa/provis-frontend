import 'package:digisehat/helpers.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientAuthBoxDecoration),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 25.0,
                ),
                height: 500,
                child: Column(
                  children: [
                    _buildHeader(),
                    SizedBox(height: 25),
                    Expanded(child: _buildDataPribadiForm()),
                    Column(
                      children: <Widget>[
                        buildButton(context, "KIRIM", _submitData, alertColor,
                            primaryColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lupa Password',
              style: lightTextStyle.copyWith(fontSize: 26, fontWeight: bolder),
            )),
        SizedBox(height: 8),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Masukan Email, kami akan mengirim link keamanan untuk reset password Anda',
              style: lightTextStyle.copyWith(fontSize: 16),
            )),
      ],
    );
  }

  void _submitData() {
    redirectTo(context, '/home');
  }

  Widget _buildDataPribadiForm() {
    return Column(
      children: <Widget>[
        buildTextField(
            hint: 'Email',
            obscureText: false,
            prefixIcon: Icons.email,
            iconColor: primaryColor,
            backgroundColor: khakiColor),
        SizedBox(height: 16),
      ],
    );
  }
}
