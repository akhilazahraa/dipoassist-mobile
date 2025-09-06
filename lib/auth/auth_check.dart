import 'package:flutter/material.dart';
import 'package:dipoassist/services/auth_service.dart';
import 'package:dipoassist/main_page/widget/navigation.dart';
import 'package:dipoassist/main_page/screens/login.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> _checkAuth() async {
    final token = await AuthService.getToken();
    if (token == null) return false;

    final user = await AuthService.getUser();
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuth(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return const NavigationPage();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
