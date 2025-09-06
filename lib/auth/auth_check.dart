import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dipoassist/main_page/widget/navigation.dart';
import 'package:dipoassist/main_page/screens/login.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> _isLoggedIn() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "auth_token");
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
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
