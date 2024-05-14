import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/providers/auth_provider.dart';
import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:digisehat/component.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(gradientAuthBoxDecoration),
          _buildLoginCard(context),
        ],
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              SizedBox(height: 40),
              _buildAvatar(),
              buildTextField(
                  controller: _usernameController,
                  hint: 'username',
                  obscureText: false,
                  prefixIcon: Icons.email,
                  iconColor: primaryColor,
                  backgroundColor: khakiColor),
              SizedBox(height: 16),
              buildTextField(
                  controller: _passwordController,
                  hint: 'password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  iconColor: primaryColor,
                  backgroundColor: khakiColor),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    redirectTo(context, '/forgot-password');
                  },
                  child: Text('Lupa kata sandi?', style: lightTextStyle),
                ),
              ),
              SizedBox(height: 16),
              buildButton(context, 'MASUK', () async {
                if (_usernameController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Username dan password tidak boleh kosong!'),
                  ));
                  return;
                }
                bool isLoggedIn = await Provider.of<AuthProvider>(context,
                        listen: false)
                    .login(_usernameController.text, _passwordController.text);
                if (isLoggedIn) {
                  redirectTo(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        Provider.of<AuthProvider>(context, listen: false)
                                .errorMessage ??
                            'Login gagal'),
                  ));
                }
              }, alertColor, primaryColor),
              SizedBox(height: 16),
              buildButton(context, 'DAFTAR', () {
                redirectTo(context, '/sign-up');
              }, Colors.transparent, alertColor),
            ],
          ),
        ),
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
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 180,
      child: Image(
        image: AssetImage("assets/illustration-auth.png"),
        width: 300,
      ),
    );
  }
}
