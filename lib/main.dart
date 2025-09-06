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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A795)),
        useMaterial3: true,
        fontFamily: "Rubik",
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: AuthCheck(),
    );
  }
}
