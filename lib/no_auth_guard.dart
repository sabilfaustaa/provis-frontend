import 'package:digisehat/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digisehat/providers/auth_provider.dart';

class NoAuthGuard extends StatelessWidget {
  final Widget child;

  const NoAuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (!authProvider.isAuthenticated()) {
          return child;
        } else {
          return HomePage();
        }
      },
    );
  }
}
