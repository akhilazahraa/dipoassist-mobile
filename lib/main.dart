import 'package:dipoassist/auth/auth_check.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const dipoassist());
}

class dipoassist extends StatelessWidget {
  const dipoassist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dipoassist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 195, 10),
        ),
        useMaterial3: true,
      ),
      home: AuthCheck(),
    );
  }
}
